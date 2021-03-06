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
import RxSwift

struct PlacesRequest {
	
	private var request: BackendRequest
	
	func getNearbyPlaces(completion: @escaping (Result<[Place]>) -> ()) {
		request.request { response in
			switch response.result {
			case let .success(data):
				let json = JSON(data: data, options: JSONSerialization.ReadingOptions.mutableContainers, error:nil)
				if let places = json["results"].arrayObject as? [[String : AnyObject]],
					let nextPageToken = json["next_page_token"].string {
					
					var placesArray = [Place]()
					for place in places {
						var place = Place(dictionary: place)
						place.nextPageToken = nextPageToken
						if let photoReference = place.photoReference {
							self.request.requestImage(photoReference) { image in
								place.photo.value = image
								place.photoReceivedFromBackEnd = true
							}
						} else {
							place.photoReceivedFromBackEnd = true
						}
						placesArray.append(place)
					}
					completion(.success(placesArray))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
	
	init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, nextPageToken: String? = nil) {
		request = BackendRequest()
		request.parameters = [
			"location" : "\(latitude), \(longitude)",
			"radius" : 500,
			"key" : "AIzaSyCzDdqS_-8bPX5FAjFDAhKt2DWOV8k3pPA",
		]
		if let token = nextPageToken {
			request.parameters?["pagetoken"] = token
		}
		request.encoding = URLEncoding.queryString
	}
}
