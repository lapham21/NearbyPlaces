//
//  LocationServices.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import CoreLocation
import RxSwift

final class LocationService: NSObject, CLLocationManagerDelegate {
	
	// MARK: Variables
	
	private var locationManager = CLLocationManager()
	private(set) var location = Variable<CLLocation?>(nil)
	static let sharedInstance: LocationService = {
		return LocationService()
	}()

	// MARK: Init
	
	override init() {
		super.init()

		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.distanceFilter = 500
	}
	
	// MARK: Authorization & Start Updating Location
	
	func startUpdatingLocation() {
		let authorizationStatus = CLLocationManager.authorizationStatus()
		if !(authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways) {
			locationManager.requestWhenInUseAuthorization()
		}
		locationManager.startUpdatingLocation()
	}
	
	// MARK: CLLocationManagerDelegate
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location.value = location
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
}
