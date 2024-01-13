//
//  PlanetsApp.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 2/10/23.
//

import SwiftUI
import SwiftData

@main
struct PlanetsApp: App {


    @MainActor
    var appContainer: ModelContainer {
        let container = try! ModelContainer(for: Planet.self, Satellite.self)
        var fetchDescriptor = FetchDescriptor<Planet>()
        fetchDescriptor.fetchLimit = 1

        //TODO: change try!
        guard try! container.mainContext.fetch(fetchDescriptor).count == 0 else { return container}
        
        DBData.planets.forEach { planet in
            container.mainContext.insert(planet)
        }
        return container
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(appContainer)
    }
    
}
