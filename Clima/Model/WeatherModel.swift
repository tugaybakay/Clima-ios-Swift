//
//  WeatherModel.swift
//  Clima
//
//  Created by MacOS on 4.08.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    
    let id: Int
    let temp: Double
    let name: String
    
    var tempString: String{
        return String(format: "%.1f",self.temp)
    }
    
    var conditionName: String{
        
        switch self.id{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
