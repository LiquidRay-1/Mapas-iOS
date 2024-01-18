//  Liquid wa here :P
//  Artwork.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//

import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let locationName: String
    let discipline: String
    
    var subtitle: String?{
        return locationName
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addresDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addresDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}
