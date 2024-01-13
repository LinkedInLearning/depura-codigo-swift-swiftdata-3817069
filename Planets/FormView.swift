//
//  PopupView.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 10/10/23.
//

import SwiftUI
import SwiftData

struct FormView: View {
    
    @Environment(\.modelContext) var modelContext
    
    let planet: Planet
    
    var satellite: Satellite?
    
    @State var satelliteName: String = ""
    
    let close: () -> ()
        
    init(planet: Planet, satellite: Satellite? = nil, close: @escaping () -> Void) {
        self.planet = planet
        self.satellite = satellite
        self.close = close
    }
    
 
    var body: some View {
        VStack(spacing: .zero) {
            closeButton
            Form {
                Section(header: titleView) {
                      formFields
                }
               formButton
            }
            .scrollContentBackground(.hidden)
            .frame(maxHeight: 250)
                
            
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 25))
        
    }
    
    var titleView: some View {
            Text("\(planet.name): \(satellite == nil ? "Nuevo satélite" : "Editar satélite")")
                .fontWeight(.semibold)
                .fontDesign(Font.Design.monospaced)
    }
    
    var formFields: some View {
        TextField(text: $satelliteName, label: {
            Text("\(satellite == nil ? "Nombre" : "Anterior nombre: \(satellite?.name ?? "")")")
        })
    }
    
    var closeButton: some View {
        HStack {
            Spacer()
            Button(action: close, label: {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.black)
                    .font(.title)
                    .opacity(0.6)
            })
            
        }
    }
    
    var formButton: some View {
        Button(action: {
           formAction()
        }, label: {
            HStack {
                Spacer()
                Text("\(satellite == nil ? "Añadir" : "Editar")")
                Spacer()
            }
        })
    }
    
    func formAction() {
        if let selectedSatellite = satellite {
            selectedSatellite.name = satelliteName
        } else {
            let newSatellite = Satellite(id: UUID(), name: satelliteName)
            modelContext.insert(newSatellite)
            newSatellite.planet = planet
        }
        close()
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
        

        return FormView(planet: PreviewData.planets.first!, satellite: PreviewData.satellites.first, close: {
            print("Close ")
        })
    } catch {
        fatalError("PlanetSummaryView preview configuration error")
    }
    
}
