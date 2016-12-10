//
//  NearbyPlaceViewModel.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

class NearbyPlaceViewModel {
	
	//MARK: Variables
	
	var place: Place
	
	//MARK: Init
	
	init(with place: Place) {
		self.place = place
	}
	
	//MARK: Get Image of Place
	
	func getPlaceImage(completion: @escaping (Result<UIImage>) -> ()) {
		guard let photoReference = place.photoReference else {
			completion(.failure(nil))
			return
		}
		
		let request = BackendRequest()
		request.requestImage(photoReference) { image in
			if let image = image {
				completion(.success(image))
			} else {
				completion(.failure(nil))
			}
		}
	}
}
