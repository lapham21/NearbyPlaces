//
//  UITableView+RegisterNib.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

extension UITableView {
	
	func registerNib<T: UITableViewCell>
		(of type: T.Type,
		bundle: Bundle? = nil,
		forCellWithReuseIdentifier identifier: String? = nil) {
		
		let nib = UINib(nibName: "\(type)", bundle: bundle)
		register(nib, forCellReuseIdentifier: identifier ?? "\(type)")
		
	}
	
}
