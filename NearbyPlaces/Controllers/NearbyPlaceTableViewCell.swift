//
//  NearbyPlaceTableViewCell.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit

class NearbyPlaceTableViewCell: UITableViewCell {

	//MARK: Variables
	
	var viewModel: NearbyPlaceViewModel?
	
	//MARK: IBOutlets

	
	
	//MARK: Lifecycle
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setupBorder()
	}
	
	//MARK: Setup
	
	func configure(with nearbyPlaceViewModel: NearbyPlaceViewModel) {
		self.viewModel = nearbyPlaceViewModel
		
		//TODO Set all the IBOutlet values with real values coming from the viewModel
		
	}
	
	private func setupBorder() {
//		let maskLayer = CAShapeLayer()
//		maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 5, height: 5)).cgPath
//		outfitImageView.layer.mask = maskLayer
		
		contentView.layer.cornerRadius = 5
		contentView.layer.masksToBounds = true
		contentView.layer.borderWidth = 0.5
		contentView.layer.borderColor = UIColor.gray.cgColor
	}
	
}
