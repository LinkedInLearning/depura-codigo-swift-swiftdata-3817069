//
//  PreviewContainer.swift
//  Planets
//
//  Created by Radostina Tachova Chergarska on 5/10/23.
//

import Foundation
import SwiftData


struct PreviewData {
    static let planets: [Planet] = [Planet(name: "Tierra", planetDescription: "La Tierra tiene un satélite natural: la Luna, que ilumina nocturnamente.", distanceSun: 1),
                                    Planet(name: "Mercurio", planetDescription: "Mercurio no tiene satélites naturales, está solo en el espacio.", distanceSun: 0.387 )]
    
    static let satellites: [Satellite] = [Satellite(name: "Nuevo Satélite 1") , Satellite(name: "Nuevo Satélite 2")]
}
