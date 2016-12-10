//
//  PlacesRequest.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import Alamofire
import CoreLocation
import SwiftyJSON

struct PlacesRequest {
	
	private var request: BackendRequest
	
	func getNearbyPlaces(completion: @escaping (Result<[Place]>) -> ()) {
		request.request { response in
			switch response.result {
			case let .success(data):
				let json = JSON(data: data, options: JSONSerialization.ReadingOptions.mutableContainers, error:nil)
				if let places = json["results"].arrayObject as? [[String : AnyObject]] {
					var placesArray = [Place]()
					for place in places {
						let place = Place(dictionary: place)
						placesArray.append(place)
					}
					completion(.success(placesArray))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
	
	init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
		request = BackendRequest()
		request.parameters = [
			"location" : "\(latitude), \(longitude)",
			"radius" : 500,
			"key" : "AIzaSyCzDdqS_-8bPX5FAjFDAhKt2DWOV8k3pPA",
		]
		request.encoding = URLEncoding.queryString
	}
}
