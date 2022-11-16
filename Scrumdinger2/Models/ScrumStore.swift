//
//  ScrumStore.swift
//  Scrumdinger2
//
//  Created by Yelin Hong on 2022/11/15.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    
    static func load(completion: @escaping (Result<[DailyScrum], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURl()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrum = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(dailyScrum))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>)->Void) {
        do {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try fileURl()
            try data.write(to: outfile)
            DispatchQueue.main.async {
                completion(.success(scrums.count))
            }
        } catch {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
