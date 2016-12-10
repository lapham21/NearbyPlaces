//
//  BackendRequest.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import Alamofire
import AlamofireImage

struct BackendRequest {
	
	private enum Url: String {
		case backEndHost = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
		case image = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&key=AIzaSyCzDdqS_-8bPX5FAjFDAhKt2DWOV8k3pPA&photoreference="
	}
	
	// MARK: Variables
	
	var headers: HTTPHeaders? = nil
	var method = HTTPMethod.get
	var parameters: Parameters? = nil
	var encoding: ParameterEncoding = URLEncoding.default
	var session: URLSession {
		return URLSession.shared
	}
	// MARK: Backend Request
	
	func request(queue: DispatchQueue = DispatchQueue.global(qos: .utility),
	             completionHandler: @escaping (DataResponse<Data>) -> Void) {
		let url = Url.backEndHost.rawValue

		Alamofire.request(url, method: method, parameters: parameters, encoding: encoding)
			.validate(statusCode: 200...299)
			.validate(contentType: ["application/json"])
			.responseData(queue: queue, completionHandler: completionHandler)
	}
	
	func requestImage(_ reference: String, completion: @escaping ((UIImage?) -> Void)) -> () {
		let urlString = Url.image.rawValue + reference
		
		Alamofire.request(urlString).responseImage { response in
			completion(response.result.value)
		}
	}
}



