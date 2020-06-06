//
//  ResultsTableViewController.swift
//  weatherAppJunior
//
//  Created by ljanosova on 22.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

protocol ResultSelectDelegate: class {
    
    func resultSelected(_ location: String)
}

final class ResultsTableViewController: UITableViewController {

    let viewModel = ParentViewModel()
    weak var delegate: ResultSelectDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: C.Strings.cell.rawValue)
        tableView.delegate = self
        tableView.backgroundColor = UIColor(red: 0.14, green: 0.18, blue: 0.2, alpha: 1)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearchesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.Strings.cell.rawValue, for: indexPath)
        cell.textLabel?.text = viewModel.recentSearchesReversed()[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return C.CGFloats.recentSearchesCellHeight.rawValue
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return C.Strings.recentSearches.rawValue
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.recentSearchesReversed()[indexPath.row]
        delegate?.resultSelected(city)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.juicyGreen
        header.contentView.backgroundColor = UIColor.darkGreen
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = .lightGray
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return C.CGFloats.forecastHeader.rawValue
    }

}
