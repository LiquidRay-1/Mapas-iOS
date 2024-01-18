//
//  CLocation.swift
//  Mapas
//
//  Created by dam2 on 18/1/24.
//

import UIKit
import CoreLocation

class CLocation: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestLocation()
    }
    
    func requestLocation(){
        locationManager?.requestLocation()
    }
    
    func requestLocationUpdate(){
        locationManager?.startUpdatingLocation()
    }
    
    func stopLocationUpdate(){
        locationManager?.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("El usuario aún no ha decidido")
            locationManager?.requestAlwaysAuthorization()
        case .restricted:
            print("Restringido por control parental")
        case .denied:
            print("El usuario ha rechazado el permiso")
        case .authorizedWhenInUse:
            print("El usuario ha permitido usar la ubicación mientras se usa la app")
            self.requestLocation()
        case .authorizedAlways:
            print("El usuario ha permitido usar la ubicación simpre")
            self.requestLocation()
            self.requestLocationUpdate()
        default:
            print("Deberías dedicarte a la magia")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.last else {
            return
        }
        print("Latitud: \(locations.coordinate.latitude), Longitud: \(locations.coordinate.longitude)")
        if(locations.horizontalAccuracy < 10){
            self.stopLocationUpdate()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Se ha producido un error: \(error.localizedDescription)")
    }
    
}
