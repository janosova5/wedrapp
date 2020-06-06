//
//  MainViewController.swift
//  weatherAppJunior
//
//  Created by ljanosova on 22.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

protocol SearchInputDelegate: class {
    
    func showWeatherDataFor(location: String)
}

final class MainViewController: UIViewController {
    
    @IBOutlet weak var metropolesTableView: UITableView!
    
    private var searchController: UISearchController!
    private var resultsTableController: ResultsTableViewController!
    
    private var searchBar: UISearchBar! {
        get {
            return searchController.searchBar
        }
    }
    
    weak var delegate: SearchInputDelegate?
    
    var viewModel: MetropolesWeatherViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        metropolesTableView.delegate = self
        metropolesTableView.dataSource = self
        resultsTableController.delegate = self
    }
    
    private func setupSearchController() {
        resultsTableController = ResultsTableViewController()
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchBar.autocapitalizationType = .none
        
        if #available(iOS 11.0, *) {
            navigationItem.title = "Location"
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = true // The default is true.
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        definesPresentationContext = true
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }
    
    private func showWeather(location: String) {
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = location.trimmingCharacters(in: whitespaceCharacterSet)
        resultsTableController.viewModel.addSearch(strippedString)
        resultsTableController.tableView.reloadData()
        delegate?.showWeatherDataFor(location: location)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension MainViewController: UISearchControllerDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        resultsTableController.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            showWeather(location: text)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.metropolesWeather?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.Strings.selectionCell.rawValue, for: indexPath) as! MetropoleTableViewCell
        cell.configureCellWith(data: viewModel?.metropolesWeather?[indexPath.row])
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = viewModel?.metropoleName(index: indexPath.row) {
            showWeather(location: location)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return C.CGFloats.metropoleCell.rawValue
    }
}

extension MainViewController: ResultSelectDelegate {
    
    func resultSelected(_ location: String) {
        searchBar.text = location
        showWeather(location: location)
    }
}


