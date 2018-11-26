//
//  APIManager.swift
//  WeatherAppiOS
//
//  Created by Gabriela Torres on 11/14/18.
//  Copyright © 2018 Gabriela Torres. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct APIManager {
    
    enum APIErrors: Error {
        case noData
        case noResponse
        case invalidData
    }
    
    //Call darksky for weather at location
    func getWeather(at location: Location, onComplete: @escaping (WeatherData?, Error?) -> Void) {
        let root = "https://api.darksky.net/forecast"
        let key = API.darkSkyAPI
        
        let url = "\(root)/\(key)/\(location.latitude),\(location.longitude)"
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let weatherData = WeatherData(json: json) {
                    onComplete(weatherData, nil)
                } else {
                    onComplete(nil, APIErrors.invalidData)
                }
            case .failure(let error):
                onComplete(nil, error)
            }
        }
    }
    
    func geocode(address: String, onCompletion: @escaping(geocodingData?, Error?)-> Void) {
        let googleURL = "https://maps.googleapis.com/maps/api/geocode/json?address="
        let url = googleURL + address + "&key=" + API.googleAPI
        
        let request = Alamofire.request(url)
        
        request.responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let geocodingData = geocodingData(json: json) {
                    onCompletion(geocodingData,nil)
                } else {
                    onCompletion(nil,APIErrors.invalidData)
                }
                print(json)
            case.failure(let error):
                onCompletion(nil, error)
            }
        }
    }
}
