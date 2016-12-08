//
//  PlacesRequest.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import Alamofire
import CoreLocation
import Genome

struct PlacesRequest {
	
	private var request: BackendRequest
	
	func getNearbyPlaces(completion: @escaping (Result<[Place]>) -> ()) {
		request.request { response in
			switch response.result {
			case let .success(data):
				do {
					let dataNode = try data.makeNode()
					guard let nearbyPlaceNode = dataNode["results"] else { return }
					
					let nearbyPlaces = try [Place](node: nearbyPlaceNode)
					completion(.success(nearbyPlaces))
				}
				catch let error {
					completion(.failure(error))
				}
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
	
	init(latitude: CLLocationDegrees, longitude: CLLocationDegrees, token: String) {
		
		request = BackendRequest()
		request.method = .post
		request.parameters = [
			"location" : "\(latitude), \(longitude)",
			"radius" : 500,
			"key" : "AIzaSyCzDdqS_-8bPX5FAjFDAhKt2DWOV8k3pPA"
		]
		request.encoding = URLEncoding.queryString
		
	}
	
}
