//
//  NearbyPlacesViewModel.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

class NearbyPlacesViewModel {
	
	//MARK: Variables
	
	var places = [Place]()
	var cellType: UITableViewCell.Type {
		return NearbyPlaceTableViewCell.self
	}
	
	//MARK: Configure ViewModel for individual places
	
	func nearbyPlaceViewModel(for indexPath: IndexPath) -> NearbyPlaceViewModel {
		
		return NearbyPlaceViewModel(with: places[indexPath.section])
		
	}
	
	//MARK: GooglePlaces
	
	func getNearbyPlaces(completion: @escaping () -> ()) {
		
	
		
	}
}
