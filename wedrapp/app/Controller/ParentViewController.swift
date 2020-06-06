//
//  ParentViewController.swift
//  weatherAppJunior
//
//  Created by ljanosova on 8.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit
import CoreLocation

final class ParentViewController: UIViewController {

    @IBOutlet weak var segmentedControl: HBSegmentedControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    
    private var metropolesViewModel: MetropolesWeatherViewModel?
    private let locationViewModel = LocationViewModel()
    
    enum TabIndex : Int {
        case currentWeatherTab = 0
        case forecastTab = 1
    }
    
    var currentViewController: UIViewController?
    
    lazy var firstChildTabVC: CurrentWeatherViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: C.Strings.currentWeatherController.rawValue) as! CurrentWeatherViewController
        
        
        firstChildTabVC.viewModel.locationViewModel = locationViewModel
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : ForecastViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier:
            C.Strings.forecastController.rawValue) as! ForecastViewController
        secondChildTabVC.viewModel.locationViewModel = locationViewModel
        return secondChildTabVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        locationViewModel.locationManager.determineUserLocation()
        setupMetropolesViewModel()
        setupSegmentedControl()
        displayCurrentTab(TabIndex.currentWeatherTab.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    func setupSegmentedControl() {
        segmentedControl.items = ["Now", "5 days"]
        segmentedControl.selectedIndex = 1
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedIndex = TabIndex.currentWeatherTab.rawValue
    }
    
    func setupMetropolesViewModel() {
        metropolesViewModel = MetropolesWeatherViewModel()
        metropolesViewModel?.loadAllMetropoles()
    }
    
    func bindViewModel() {
        locationViewModel.userLocationName.producer.skipNil().startWithValues { [weak self] name in
            self?.navigationItem.title = name.replacingOccurrences(of: "+", with: " ")
        }
    }
    
    @objc func segmentValueChanged(_ sender: Any) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParent()
        
        displayCurrentTab(segmentedControl.selectedIndex)
    }
    
    @IBAction func userLocationButtonTapped(_ sender: Any) {
        locationViewModel.userLocationTapped.value = true
        locationViewModel.searchLocation.value = nil
        locationViewModel.locationManager.determineUserLocation()
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChild(vc)
            vc.didMove(toParent: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.currentWeatherTab.rawValue :
            vc = firstChildTabVC
            contentViewTopConstraint.constant = 0
        case TabIndex.forecastTab.rawValue :
            vc = secondChildTabVC
            contentViewTopConstraint.constant = 100
        default:
            return nil
        }
        return vc
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.Strings.recentSearchesSegue.rawValue {
            if let controller = segue.destination as? MainViewController {
                controller.viewModel = metropolesViewModel
                controller.delegate = self
            }
        }
    }
    
}

extension ParentViewController: SearchInputDelegate {
    
    func showWeatherDataFor(location: String) {
        let location = location.replacingOccurrences(of: " ", with: "+")
        locationViewModel.searchLocation.value = location
        locationViewModel.userLocationCoordinates.value = nil
        locationViewModel.userLocationTapped.value = false
        locationViewModel.locationManager.locationManager.stopUpdatingLocation()
    }
}


