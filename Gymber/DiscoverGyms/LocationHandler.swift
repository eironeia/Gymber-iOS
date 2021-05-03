//
//  LocationHandler.swift
//  Gymber
//
//  Created by Alex Cuello on 03/05/2021.
//

import Foundation
import CoreLocation

protocol LocationAuthorizationHandlerInterface {
    var onLocationStatusChanged: ((LocationAuthorizationHandler.LocationStatus) -> ())? { get set }
    func checkLocationServices()
}

final class LocationAuthorizationHandler: NSObject {
    enum LocationStatus {
        case notDetermined
        case restricted
        case denied
        case authorized(CLLocation)
    }

    // MARK: PlacesLocationAuthorizationHandler Interface

//    private let locationStatusSubject = PublishSubject<LocationStatus>()
//    lazy var locationStatusObservable: Observable<LocationStatus> = locationStatusSubject.asObservable()
    var onLocationStatusChanged: ((LocationStatus) -> ())?
    private(set) var lastLocation: CLLocation?

    // MARK: Stored properties

    private let locationManager = CLLocationManager()
    private var isUpdatingLocationFirstTime: Bool = true
}

extension LocationAuthorizationHandler: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didChangeAuthorization _: CLAuthorizationStatus) {
        handleLocationAuthorizationStatusChanges()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        sendLocationEvent(from: locations.last?.coordinate)
    }
}

extension LocationAuthorizationHandler: LocationAuthorizationHandlerInterface {
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            handleLocationAuthorizationStatusChanges()
        } else {
            onLocationStatusChanged?(.restricted)
        }
    }
}

private extension LocationAuthorizationHandler {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    func handleLocationAuthorizationStatusChanges() {
        isUpdatingLocationFirstTime = true
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            onLocationStatusChanged?(.notDetermined)
        case .restricted:
            onLocationStatusChanged?(.restricted)
        case .denied:
            onLocationStatusChanged?(.denied)
        case .authorizedWhenInUse, .authorizedAlways:
            sendLocationEvent(from: locationManager.location?.coordinate)
        default: // Otherwise, it triggers a warning.
            assertionFailure("New state not handled, refer to documentation")
        }
    }

    func sendLocationEvent(from coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else {
            debugPrint("Location is not activated, or if using simulator you are set a location.")
            return
        }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        lastLocation = location
        if isUpdatingLocationFirstTime {
            isUpdatingLocationFirstTime = false
            onLocationStatusChanged?(.authorized(location))
        }
    }
}
