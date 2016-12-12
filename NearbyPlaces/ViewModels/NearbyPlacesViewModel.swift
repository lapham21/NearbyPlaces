//
//  NearbyPlacesViewModel.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit
import CoreLocation

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
	
	func getNearbyPlaces(nextPageToken: String? = nil, completion: @escaping () -> ()) {
		guard let location = LocationService.sharedInstance.location.value else { return }
		let token = nextPageToken ?? nil
		let placesRequest = PlacesRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, nextPageToken: token)
		placesRequest.getNearbyPlaces { [weak self] result in
			switch result {
			case .success(let nearbyPlaces):
				for place in nearbyPlaces {
					self?.places.append(place)
				}
				completion()
			case .failure(let error):
				guard let error = error else { return }
				print(error)
			}
		}
	}
}
