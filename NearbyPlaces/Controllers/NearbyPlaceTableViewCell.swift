//
//  NearbyPlaceTableViewCell.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/8/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit
import RxSwift

class NearbyPlaceTableViewCell: UITableViewCell {

	//MARK: Variables
	
	var viewModel: NearbyPlaceViewModel?
	private var disposeBag = DisposeBag()
	
	//MARK: IBOutlets

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var placeImageView: UIImageView!
	
	//MARK: Lifecycle
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setupBorder()
		setupObservables()
	}
	
	//MARK: Setup
	
	func configure(with nearbyPlaceViewModel: NearbyPlaceViewModel) {
		self.viewModel = nearbyPlaceViewModel
		
		nameLabel.text = viewModel?.place.name
		placeImageView.image = nil
	}
	
	private func setupBorder() {
		self.layer.cornerRadius = 5
		self.layer.borderWidth = 0.5
		self.layer.masksToBounds = true
		self.layer.borderColor = UIColor.gray.cgColor
	}
	
	private func setupObservables() {
		viewModel?.place.photo.asObservable().subscribe({ [weak self] _ in
			if let photo = self?.viewModel?.place.photo.value {
				self?.placeImageView.image = photo
			} else {
				if let recieved = self?.viewModel?.place.photoReceivedFromBackEnd,
					recieved == true {
					self?.placeImageView.image = #imageLiteral(resourceName: "imageNotFound")
				}
			}
		}).addDisposableTo(disposeBag)
	}
}
