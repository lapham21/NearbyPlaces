//
//  AppDelegate.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// GooglePlaces API key
		let googlePlacesAPIKey = "AIzaSyD97OiYYcVpNO0zDD1BapcYxc7ykIC4KWg"
		GMSPlacesClient.provideAPIKey(googlePlacesAPIKey)
		
		// Start monitoring location
		LocationService.sharedInstance.startUpdatingLocation()
		
		// Show
		let frame = UIScreen.main.bounds
		window = UIWindow(frame: frame)
		
		let nearbyPlacesTableViewController = NearbyPlacesViewController()
		
		window?.rootViewController = nearbyPlacesTableViewController
		window?.makeKeyAndVisible()
	
		return true
	}

}

