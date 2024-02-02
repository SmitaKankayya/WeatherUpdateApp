//
//  WeatherData.swift
//  WeatherUpdateApp
//
//  Created by Smita Kankayya on 31/01/24.
//

import Foundation
struct WeatherData : Codable{
    let location : LocationData
    let current : CurrentData
}
