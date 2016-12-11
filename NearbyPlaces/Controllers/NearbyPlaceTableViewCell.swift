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

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var placeImageView: UIImageView!
	
	//MARK: Lifecycle
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setupBorder()
	}
	
	//MARK: Setup
	
	func configure(with nearbyPlaceViewModel: NearbyPlaceViewModel) {
		self.viewModel = nearbyPlaceViewModel
		
		nameLabel.text = viewModel?.place.name
		placeImageView.image = nil
		viewModel?.getPlaceImage { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let image):
					self?.viewModel?.place.photo = image
					self?.placeImageView.image = self?.viewModel?.place.photo
				case .failure( _):
					self?.placeImageView.image = #imageLiteral(resourceName: "imageNotFound")
				}
			}
		}
	}
	
	private func setupBorder() {
		self.layer.cornerRadius = 5
		self.layer.borderWidth = 0.5
		self.layer.masksToBounds = true
		self.layer.borderColor = UIColor.gray.cgColor
	}
}
