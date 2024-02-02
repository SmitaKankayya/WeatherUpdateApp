//
//  CurrentData.swift
//  WeatherUpdateApp
//
//  Created by Smita Kankayya on 31/01/24.
//

import Foundation
struct CurrentData:Codable{
    let last_updated : String
    let temp_c : Float
    let wind_kph : Float
    let humidity : Int
}
