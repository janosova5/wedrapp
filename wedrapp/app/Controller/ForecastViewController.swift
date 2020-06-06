//
//  ForecastViewController.swift
//  weatherAppJunior
//
//  Created by ljanosova on 8.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

final class ForecastViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    
    let viewModel = ForecastViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollToTop()
        
        forecastTableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        forecastTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setupTableView() {
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
    }
    
    private func bindViewModel() {
        // if there is search location
        
        viewModel
        .locationViewModel?
        .searchLocation
        .producer
        .skipNil()
        .startWithValues({ [weak self] location in
            self?.showForecast("q=\(location)")
        })
        
        // if there is not search location, take current location
        viewModel
        .locationViewModel?
        .userLocationCoordinates
        .producer
        .skipNil()
        .startWithValues({ [weak self] location in
            self?.showForecast(location)
        })
        
        viewModel
        .locationViewModel?
        .userLocationTapped
        .producer
        .startWithValues { [weak self] refresh in
            if refresh {
                if let location = self?.viewModel
                                       .locationViewModel?
                                       .userLocationCoordinates
                                       .value {
                                            self?.showForecast(location)
                                       }
            }
        }
    }
    
    private func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        forecastTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    private func showForecast(_ location: String) {
        viewModel.setForecast(location, completion: { [weak self] result in
            switch result {
            case .unknownError:
                self?.showAlertWith(message: C.Strings.error.rawValue)
            case .success:
                self?.forecastTableView.reloadData()
            default:
                break
            }
        })
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            C.Strings.forecastCell.rawValue) as! ForecastTableViewCell
        
        let first = viewModel.countOfFirstSectionRows

        if indexPath.section == 0 {
            cell.configureCellWith(data: viewModel.getForecastFor(index: indexPath.row))
            cell.setHoursLabelWith(time: viewModel.getForecastHours(at: indexPath.row))
        } else if indexPath.section == 1 {
            cell.configureCellWith(data: viewModel.getForecastFor(index: indexPath.row + first))
            cell.setHoursLabelWith(time: viewModel.getForecastHours(at: indexPath.row + first))
        } else {
            cell.configureCellWith(data: viewModel.getForecastFor(index: indexPath.row + first
                + ((indexPath.section - 1) * C.Numbers.rowsMaxCount.rawValue)))
            cell.setHoursLabelWith(time: viewModel.getForecastHours(at:
                indexPath.row + first + C.Numbers.rowsMaxCount.rawValue))
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.countOfFirstSectionRows == C.Numbers.rowsMaxCount.rawValue {
            return 5
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.countOfFirstSectionRows
        } else if section == 5 {
            return C.Numbers.rowsMaxCount.rawValue - viewModel.countOfFirstSectionRows
        }
        return C.Numbers.rowsMaxCount.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return C.CGFloats.forecastHeader.rawValue
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return C.CGFloats.forecastCell.rawValue
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let first = viewModel.countOfFirstSectionRows
        let count = viewModel.forecastCount()
        if section == 0 {
            return viewModel.getForecastDay(at: first - 1)
        }
        if section == 5 {
            return viewModel.getForecastDay(at: count - 1)
        }
        return viewModel.getForecastDay(at: first + (section * C.Numbers.rowsMaxCount.rawValue - 1))
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView

        header.textLabel?.textColor = UIColor.lightGray
        header.contentView.backgroundColor = UIColor.darkGreen
    }
}
