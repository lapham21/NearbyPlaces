//
//  NearbyPlacesViewController.swift
//  NearbyPlaces
//
//  Created by Nolan Lapham on 12/7/16.
//  Copyright © 2016 Nolan Lapham. All rights reserved.
//

import UIKit
import RxSwift

class NearbyPlacesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	//MARK: Variables
	
	var viewModel = NearbyPlacesViewModel()
	private var disposeBag = DisposeBag()
	
	//MARK: IBOutlets
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var headerView: UIView!
	
	//MARK: Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		activityIndicator.startAnimating()
		setupTableView()
		getNearbyPlaces()
		setupObservables()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		setupHeaderView()
	}
	
	//MARK: Setup
	
	override var prefersStatusBarHidden : Bool {
		return true
	}
	
	private func setupTableView() {
		tableView.registerNib(of: NearbyPlaceTableViewCell.self)
		tableView.tableFooterView = UIView()
	}
	
	private func setupObservables() {
		LocationService.sharedInstance.location.asObservable().subscribe({ [weak self] _ in
			self?.getNearbyPlaces()
		}).addDisposableTo(disposeBag)
	}
	
	private func setupHeaderView() {
		headerView.layer.borderWidth = 0.5
		headerView.layer.borderColor = UIColor.gray.cgColor
	}
	
	// MARK: Backend Request
	
	private func getNearbyPlaces() {
		viewModel.getNearbyPlaces { [weak self] in
			DispatchQueue.main.async {
				self?.activityIndicator.stopAnimating()
				self?.activityIndicator.isHidden = true
				self?.tableView.reloadData()
			}
		}
	}
	
	// MARK: UITableViewDataSource
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "\(viewModel.cellType)", for: indexPath)
		
		guard let nearbyPlaceCell = cell as? NearbyPlaceTableViewCell else { return cell }
		nearbyPlaceCell.configure(with: viewModel.nearbyPlaceViewModel(for: indexPath))
		
		return nearbyPlaceCell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.places.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let cell = tableView.dequeueReusableCell(withIdentifier: "\(viewModel.cellType)")
		guard let nearbyPlaceCell = cell as? NearbyPlaceTableViewCell else { return 580 }
		
		return nearbyPlaceCell.bounds.size.height
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = UIColor.clear
		return view
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		let cell = tableView.dequeueReusableCell(withIdentifier: "\(viewModel.cellType)")
		guard let nearbyPlaceCell = cell as? NearbyPlaceTableViewCell else { return 8 }
		
		return nearbyPlaceCell.bounds.size.height * 0.03
	}

}
