//
//  Place.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import SwiftyJSON
import RxSwift

struct Place {
	
	let name: String
	let address: String
	let photoReference: String?
	private(set) var photo = Variable<UIImage?>(nil)
	var photoReceivedFromBackEnd = false
	var nextPageToken: String?
	
	init(dictionary: [String : AnyObject]) {
		let json = JSON(dictionary)
		name = json["name"].stringValue
		address = json["vicinity"].stringValue
		photoReference = json["photos"][0]["photo_reference"].string
	}
}
