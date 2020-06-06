//
//  MetropoleTableViewCell.swift
//  weatherAppJunior
//
//  Created by ljanosova on 30.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

final class MetropoleTableViewCell: UITableViewCell {

    @IBOutlet weak var metropoleNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    func configureCellWith(data: CurrentWeather?) {
        if let data = data {
            metropoleNameLabel.text = data.cityName
            tempLabel.text = "\(data.temp?.toCelsius() ?? 0)°C"
            weatherLabel.text = data.weather?.last?.title
            weatherImageView.image = UIImage(named: data.weather?.last?.icon ?? "default")
        }
    }

}
