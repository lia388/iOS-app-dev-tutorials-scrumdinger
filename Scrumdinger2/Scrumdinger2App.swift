//
//  Scrumdinger2App.swift
//  Scrumdinger2
//
//  Created by Yelin Hong on 2022/10/10.
//

import SwiftUI

@main
struct Scrumdinger2App: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.sampleData)
            }
        }
    }
}
