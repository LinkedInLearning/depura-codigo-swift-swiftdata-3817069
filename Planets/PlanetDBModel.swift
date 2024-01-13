//
//  Planet.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 2/10/23.
//

import Foundation
import SwiftData

@Model
class Planet {
    @Attribute(.unique) let name: String
    let planetDescription: String
    let distanceSun: Float //astronomical units
    
    @Relationship(inverse: \Satellite.planet) var satellites: [Satellite]
    
        
    init(name: String, planetDescription: String, distanceSun: Float, satellites: [Satellite] = []) {
        self.name = name
        self.planetDescription =  planetDescription
        self.distanceSun = distanceSun
        self.satellites = satellites
    }
}

@Model
class Satellite {
    @Attribute(.unique) var id: UUID
    var name: String
    @Relationship(inverse: \Planet.satellites) var planet: Planet?
    
    init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}


struct DBData {
    static let planets: [Planet] = [Planet(name: "Tierra", planetDescription: "La Tierra tiene un satélite natural: la Luna, que ilumina nocturnamente.", distanceSun: 1),
                                    Planet(name: "Mercurio", planetDescription: "Mercurio no tiene satélites naturales, está solo en el espacio.", distanceSun: 0.387),
                                    Planet(name: "Venus", planetDescription: "Venus carece de satélites naturales, orbita en solitario alrededor del Sol.", distanceSun: 0.722),
                                    Planet(name: "Marte", planetDescription: "Marte tiene dos lunas: Fobos y Deimos, pequeñas y irregulares.", distanceSun: 1.52),
                                    Planet(name: "Júpiter", planetDescription: "El gigante gaseoso posee más de 80 lunas, siendo las más grandes Ío, Europa, Ganimedes y Calisto..", distanceSun: 5.2),
                                    Planet(name: "Saturno", planetDescription: "Saturno ostenta múltiples lunas, con Titán y Encélado destacando significativamente.", distanceSun: 9.58),
                                    Planet(name: "Urano", planetDescription: "Urano tiene 27 lunas conocidas, las más grandes son Titania y Oberón.", distanceSun: 19.2)]
}
