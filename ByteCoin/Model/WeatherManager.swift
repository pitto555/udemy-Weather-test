//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol Weatherdelegate: class {
    func goto(weather: WeatherModel)
}

struct WeatherManager {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=d7ce984ea3f832627a522f4e4ad99e3f&units=metric"
    let prefecturesArray = ["Tokyo","Mie","Okinawa","Saitama"]
    
    weak var delegate:Weatherdelegate?
    
    func getprefecture(for urlString:String) {
        let urlString = "\(baseURL)&q=\(urlString)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data,response,error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.paseJSON(data: safeData) {
                        self.delegate?.goto(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func paseJSON(data:Data) -> WeatherModel?{
        
        do {
            let json = JSONDecoder()
            let decode = try json.decode(WeatherData.self, from: data )
            let name = decode.name
            let temp = decode.main.temp
            let weather = WeatherModel(cityName: name, temp: temp)
            return weather
        } catch {
            print(error)
            return nil
        }
    }
    
    struct WeatherData : Codable{
        let name: String
        let main: Main
    }
    
    struct Main: Codable {
        let temp: Double
    }
}


