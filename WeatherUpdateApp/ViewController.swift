//
//  ViewController.swift
//  WeatherUpdateApp
//
//  Created by Smita Kankayya on 31/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UpdateTimeLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var refreshDataButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labels = [UpdateTimeLabel, regionLabel, countryLabel, temperatureLabel, windLabel, humidityLabel]
        
        labels.forEach { label in
            label!.layer.cornerRadius = 5
            label!.layer.borderWidth = 1
            label!.layer.borderColor = UIColor.black.cgColor
            label!.layer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2).cgColor
        }
        
        addGradient(to: view, colors: [UIColor.systemBlue, UIColor.systemGreen], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        addGradient(to: refreshDataButton, colors: [UIColor.systemRed, UIColor.systemBlue], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        
        fetchdata()
    }
    
    func addGradient(to view: UIView, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func fetchdata(){
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=65a7aea3e395474187a20653220504&q=india&aqi=no")
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data , error == nil else {
                print("Error Occured While Accessing Data with URL")
                return
            }
            var fullWeatherData: WeatherData?
            do {
                fullWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            } catch {
                print("Error Occured While Decodeing JSON into Swift Structure \(error)")
            }
            DispatchQueue.main.async {
                self.UpdateTimeLabel.text = "Updated : \(fullWeatherData!.current.last_updated)"
                self.regionLabel.text = "Region : \(fullWeatherData!.location.region)"
                self.countryLabel.text = "Contry : \(fullWeatherData!.location.country)"
                self.temperatureLabel.text = "Temperature (Celsius) : \(fullWeatherData!.current.temp_c)"
                self.humidityLabel.text = "Humidity : \(fullWeatherData!.current.humidity)"
                self.windLabel.text = "Wind(km/hrs) : \(fullWeatherData!.current.wind_kph)"
            }
        }
        dataTask.resume()
    }
    
    @IBAction func refreshData(_ sender: Any) {
        fetchdata()
    }
    
}

