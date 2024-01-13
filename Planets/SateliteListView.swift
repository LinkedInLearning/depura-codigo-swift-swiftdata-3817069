//
//  SatellitesView.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 10/10/23.
//

import SwiftUI
import SwiftData

struct SatelliteListView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var showPopupForm: (Satellite?) -> ()
            
    var satellites: [Satellite]
    
    init(satellites: [Satellite], showPopupForm: @escaping (Satellite?) -> Void) {
        self.showPopupForm = showPopupForm
        self.satellites = satellites
    }
    
    
    
    var body: some View {
            VStack {
                ForEach(satellites) { satellite in
                    HStack {
                        Text(satellite.name)
                        Spacer()
                        
                        editButton(satellite: satellite)
                        removeButton(satellite: satellite)
                    }.padding()
                }
              addButton
            }
    }
    
    var addButton: some View {
        Button(action: {
            showPopupForm(nil)
        }, label: {
            Text("Añadir")
        })
    }
    
    func removeButton(satellite: Satellite) -> some View {
        Button(action: {
            modelContext.delete(satellite)
        }, label: {
            Image(systemName: "trash.fill")
        }).padding(.trailing)
    }
    
    func editButton(satellite: Satellite) -> some View {
        Button(action: {
            showPopupForm(satellite)
        }, label: {
            Text("Editar")
        }).padding([.trailing])
    }
    
    
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Planet.self, Satellite.self, configurations: config)
        
        container.mainContext.insert(PreviewData.planets.first!)
        
        PreviewData.satellites.forEach { satellite in
            container.mainContext.insert(satellite)
            satellite.planet = PreviewData.planets.first!
        }
        

        return SatelliteListView(satellites: PreviewData.planets.first!.satellites, showPopupForm: {_ in 
            print("Click on showPopupForm")
        }).modelContainer(container)
    } catch {
        fatalError("PlanetSummaryView preview configuration error")
    }
}
