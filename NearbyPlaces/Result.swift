//
//  Result.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import Foundation

enum Result<T> {
	case success(T)
	case failure(Error)
}
