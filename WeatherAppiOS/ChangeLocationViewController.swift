//
//  ChangeLocationViewController.swift
//  WeatherAppiOS
//
//  Created by Gabriela Torres on 11/15/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit

class ChangeLocationViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    let apiManager = APIManager()
    var geocodingData: geocodingData?
    var weatherData: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func handleError() {
        geocodingData = nil
        weatherData = nil
    }
    func retrivegeocodeData(searchAddress: String) {
        apiManager.geocode(address: searchAddress) {
            (geocodingData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = geocodingData {
                self.geocodingData = receivedData
                self.retriveWeatherData(latitude: receivedData.latitude, longitude: receivedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    func retriveWeatherData(latitude: Double, longitude: Double) {
        apiManager.getWeather(at: (latitude, longitude)) { (weatherData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = weatherData {
                self.weatherData = receivedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else {
            print("Can not find location")
            return
        }
        retrivegeocodeData(searchAddress: searchAddress)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherViewController,
            let receivedGeocodingData = geocodingData,
            let retrievedWeatherData = weatherData {
            destinationVC.displayWeatherData = retrievedWeatherData
            destinationVC.displayGeocodingData = receivedGeocodingData
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
