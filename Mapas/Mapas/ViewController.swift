//
//  ViewController.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
   
    let initialLocation = CLLocation(latitude: 38.09420601696138, longitude: -3.63124519770404)
    let estechChoords = CLLocationCoordinate2D(latitude: 38.09420601696138, longitude: -3.63124519770404)
    let ayuntamientoChoords = CLLocationCoordinate2D(latitude: 38.0942250750064, longitude: -3.6359578227707847)
    let regionRadius: CLLocationDistance = 1000 // 1000 metros, es la unidad de medida de distancia
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        centerMapOnLocation(location: initialLocation)
        createAnnotation(title: "Escuela Estech", locationName: "Escuela de Tecnologias Aplicadas", discipline: "Centro de estudios", coordinate: estechChoords)
        createAnnotation(title: "Ayuntamiento Linares", locationName: "Ayuntamiento", discipline: "Edificio público", coordinate: ayuntamientoChoords)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func createAnnotation(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        let artwork = Artwork(title: title, locationName: locationName, discipline: discipline, coordinate: coordinate)
        mapView.addAnnotation(artwork)
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
