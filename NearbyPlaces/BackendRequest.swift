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
	
	private let backendHost = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
	
	var method = HTTPMethod.get
	var parameters: Parameters? = nil
	var encoding: ParameterEncoding = URLEncoding.default
	var headers: HTTPHeaders? = nil
	
	// MARK: Backend Request
	
	func request(queue: DispatchQueue = DispatchQueue.global(qos: .utility), completionHandler: @escaping (DataResponse<Data>) -> Void) {
		let url = backendHost
		
		Alamofire.request(url, method: method, parameters: parameters, encoding: encoding)
			.validate(statusCode: 200...299)
			.validate(contentType: ["application/json"])
			.responseData(queue: queue, completionHandler: completionHandler)
	}
	
	// MARK: Fetch Image
		
	static func fetchImage(from url: URL?, completion: @escaping (UIImage?) -> ()) {
		guard let url = url else { return }
		
		Alamofire.request(url).responseImage { response in
			completion(response.result.value)
		}
	}
}
