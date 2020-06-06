//
//  CurrentWeatherViewController.swift
//  weatherAppJunior
//
//  Created by ljanosova on 8.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    let viewModel = CurrentWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        // search location
        viewModel
        .locationViewModel?
        .searchLocation
        .producer
        .skipNil()
        .startWithValues({ [weak self] location in
            self?.showCurrentWeather("q=\(location)")
        })
        
        // user location
        viewModel
        .locationViewModel?
        .userLocationCoordinates
        .producer
        .skipNil()
        .startWithValues({ [weak self] location in
            self?.showCurrentWeather(location)
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
                                            self?.showCurrentWeather(location)
                                        }
            }
        }
    }
    
    func showCurrentWeather(_ location: String) {
        viewModel.setCurrentWeather(location, completion: { [weak self] result in
            switch result {
            case .notFoundError:
                self?.showAlertWith(message: C.Strings.error404.rawValue)
            case .unknownError:
                self?.showAlertWith(message: C.Strings.error.rawValue)
            case .success:
                self?.configureLayoutWithData()
            }
        })
    }
    
    private func configureLayoutWithData() {
        mainLabel.text = viewModel.weatherObject()?.title ?? "Label"
        descLabel.text = viewModel.weatherObject()?.desc ?? "label"
        iconImageView.image = UIImage(named: viewModel.weatherObject()?.icon ?? "default")
        minTempLabel.text = "\(viewModel.currentWeather?.minTemp?.toCelsius() ?? 0)°C"
        maxTempLabel.text = "\(viewModel.currentWeather?.maxTemp?.toCelsius() ?? 0)°C"
        tempLabel.text = "\(viewModel.currentWeather?.temp?.toCelsius() ?? 0)°C"
        humidityLabel.text = "\(viewModel.currentWeather?.humidity ?? 0.0) %"
        windSpeedLabel.text = "\(viewModel.currentWeather?.windSpeed ?? 0.0) km/h"
        pressureLabel.text = "\(viewModel.currentWeather?.pressure ?? 0.0) hPa"
    }
}

