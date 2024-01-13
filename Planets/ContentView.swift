//
//  ContentView.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 2/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \Planet.distanceSun) var planets: [Planet]
    
    @State var showForm: Bool = false
    
    @State var selectedPlanet: Planet? = nil
    @State var selectedSatellite: Satellite? = nil
    
    var body: some View {
        ZStack {
            backgroundColor
            VStack {
                headerView
                ScrollView {
                    ForEach(planets) { planet in
                            PlanetSummaryView(planet: planet, showPopupForm: { satellite in
                                selectedSatellite = satellite
                                selectedPlanet = planet
                                showForm.toggle()
                            }).shadow(radius: 10)
                    }.padding()
                }
            }
            .overlay(alignment: .bottom, content: {
                if showForm {
                    FormView(planet: selectedPlanet!, satellite: selectedSatellite) {
                        showForm = false
                    }
                }
            })
        }
    }
    
    var headerView: some View {
        Group {
            Text("Sistema Solar")
                .fontDesign(Font.Design.monospaced)
                .font(.title3)
        
            Text("Nuestro sistema solar: ocho planetas, el sol y misterios cósmicos. Gestiona los satélites haciendo clic en Satélites.")
                .fontDesign(Font.Design.monospaced)
                .font(.system(size: 15))
        }.padding()
    }
    
    var backgroundColor: some View {
        LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
    
}


#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Planet.self, Satellite.self, configurations: config)
        
        PreviewData.planets.forEach { planet in
            container.mainContext.insert(planet)
        }
        
        return ContentView().modelContainer(container)

    } catch {
        fatalError("Error preview modelContainer")
    }
}
