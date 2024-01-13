//
//  PlanetSummaryView.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 4/10/23.
//

import SwiftUI
import SwiftData


struct PlanetSummaryView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var planet: Planet
        
    var showPopupForm: (Satellite?) -> ()
    
    @State var showSatellites: Bool = false

    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.thinMaterial)
            
            VStack {
                planetView
                satelliteList
            }
        }.padding([.top])
    }
    
    var planetView: some View {
        VStack {
            header
            Divider()
            HStack {
                Text(planet.planetDescription)
                    .font(.system(size: 15))
                    .minimumScaleFactor(0.5)
                    .fontWeight(.thin)
                    .fontDesign(Font.Design.monospaced)
                    .padding(.leading, 10)
                
                 viewSatellitesButton.padding(.trailing)
            }
            
        }.frame(height: 180)
    }
    
    var satelliteList: some View {
        VStack {
            if showSatellites {
                Divider()
                SatelliteListView(satellites: planet.satellites, showPopupForm: self.showPopupForm)
            }
            Spacer()
        }
    }
    
    var viewSatellitesButton: some View {
        Button(action: {
            showSatellites.toggle()
        }, label: {
            ZStack(alignment: .center) {
                Circle().fill(.white).shadow(radius: 10)
                VStack {
                    Text("📖")
                    Text("Satélites")
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .fontWeight(.thin)
                        .font(.system(size: 13))
                        .fontDesign(Font.Design.monospaced)
                }
            }
        }).frame(width: 85)
    }
    
    var header: some View {
        HStack {
            Text(planet.name)
                .fontDesign(Font.Design.monospaced)
            Spacer()
            removeButton(planet: planet)
        }.padding([.top, .leading])
    }
    
    func removeButton(planet: Planet) -> some View {
        Button(action: {
            modelContext.delete(planet)
        }, label: {
            Image(systemName: "trash.fill")
        }).padding(.trailing)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Planet.self, Satellite.self, configurations: config)
        
        PreviewData.planets.forEach { planet in
            container.mainContext.insert(planet)
        }

        return ZStack {
                    LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                
                    PlanetSummaryView(planet: PreviewData.planets.first!, showPopupForm: {_ in 
                       print("showPopupForm")
                    }).modelContainer(container)
                }
    } catch {
        fatalError("PlanetSummaryView preview configuration error")
    }

}
