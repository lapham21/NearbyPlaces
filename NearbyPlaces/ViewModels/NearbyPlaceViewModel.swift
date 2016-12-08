//
//  NearbyPlaceViewModel.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit
import RxSwift

class NearbyPlaceViewModel {
	
	//MARK: Variables
	
	var place: Place
	
	//MARK: Init
	
	init(with place: Place) {
		
		self.place = place
		
	}
	
	func getPlaceImage(completion: @escaping (UIImage?) -> ()) {
		
		guard let photoReference = place.photoReference else { return }
		
		let request = BackendRequest()
		request.requestImage(photoReference) { image in
			guard let image = image else { return }
			completion(image)
		}
	
	}
	
}
