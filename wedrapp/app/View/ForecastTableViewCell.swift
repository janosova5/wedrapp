//
//  ForecastTableViewCell.swift
//  weatherAppJunior
//
//  Created by ljanosova on 10.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

final class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func configureCellWith(data: Forecast?) {
        if let data = data {
            tempLabel.text = "\(data.temp?.toCelsius() ?? 0)°C"
            mainLabel.text = data.weather?.last?.title
            iconImageView.image = UIImage(named: data.weather?.last?.icon ?? "default")
        }
    }
    
    func setHoursLabelWith(time: String) {
        hoursLabel.text = time
    }

}
