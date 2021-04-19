//
//  WeatherModel.swift
//  ByteCoin
//
//  Created by aoka on 2021/04/19.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let cityName:String
    let temp: Double
    
    var tempString: String {
        String(format: "%.1f", temp)
    }
    
}
