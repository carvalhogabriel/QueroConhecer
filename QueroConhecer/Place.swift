//
//  PLace.swift
//  QueroConhecer
//
//  Created by Gabriel Carvalho Guerrero on 20/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import Foundation
import MapKit

struct Place: Codable {
    
    let name: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let address: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func getFormattedAddress(with placemark: CLPlacemark) -> String {
        var address = ""
        
        if let street = placemark.thoroughfare { //Rua
            address += street
        }
        if let number = placemark.subThoroughfare { //Numero
            address += " \(number)"
        }
        if let subLocality = placemark.subLocality { //Bairro
            address += ", \(subLocality)"
        }
        if let city = placemark.locality { //Cidade
            address += "\n\(city)"
        }
        if let state = placemark.administrativeArea { //Estado
            address += " - \(state)"
        }
        if let postalCode = placemark.postalCode { //CEP
            address += "\nCEP: \(postalCode)"
        }
        if let country = placemark.country { //País
            address += "\n\(country)"
        }
        
        return address
    }
    
}

extension Place: Equatable {
    static func ==(lhs: Place, rhs: Place) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
