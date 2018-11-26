//
//  WeatherViewController.swift
//  WeatherAppiOS
//
//  Created by Gabriela Torres on 11/14/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var IconLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var LowTempLabel: UILabel!
    @IBOutlet weak var HighTempLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            IconLabel.text = displayWeatherData.condition.icon
            TempLabel.text = "\(displayWeatherData.temperature)°"
            HighTempLabel.text = "\(displayWeatherData.highTemperature)°"
            LowTempLabel.text = "\(displayWeatherData.lowTemperature)°"
        }
    }
    var displayGeocodingData: geocodingData! {
        didSet {
            LocationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        }
    func setupDefaultUI() {
        LocationLabel.text = ""
        IconLabel.text = "👍🏽"
        TempLabel.text = "Enter a location"
        HighTempLabel.text = "_"
        LowTempLabel.text = "_"
    }
    @IBAction func unwindToWeatherSegue(segue: UIStoryboardSegue) {}
}  
