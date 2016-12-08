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
		viewModel?.getPlaceImage { [weak self] image in
			guard let image = image else { return }
			DispatchQueue.main.async {
				self?.placeImageView.image = image
			}
		}
		placeImageView.image = #imageLiteral(resourceName: "imageNotFound")
	}
	
	private func setupBorder() {		
		contentView.layer.cornerRadius = 5
		contentView.layer.masksToBounds = true
		contentView.layer.borderWidth = 0.5
		contentView.layer.borderColor = UIColor.gray.cgColor
	}
	
}
