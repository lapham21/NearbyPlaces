//
//  AppDelegate.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// Start monitoring location
		LocationService.sharedInstance.startUpdatingLocation()

		let frame = UIScreen.main.bounds
		window = UIWindow(frame: frame)
		
		let nearbyPlacesTableViewController = NearbyPlacesViewController()
		
		window?.rootViewController = nearbyPlacesTableViewController
		window?.makeKeyAndVisible()
	
		return true
	}

}

