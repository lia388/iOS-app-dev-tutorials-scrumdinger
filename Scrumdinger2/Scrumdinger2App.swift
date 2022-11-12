//
//  Scrumdinger2App.swift
//  Scrumdinger2
//
//  Created by Yelin Hong on 2022/10/10.
//

import SwiftUI

@main
struct Scrumdinger2App: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
