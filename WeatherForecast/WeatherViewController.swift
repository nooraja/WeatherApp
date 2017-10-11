//
//  WeatherViewController.swift
//  weatherforecast
//
//  Created by Muhammad Noor on 11/10/2017.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelNumberWeather: UILabel!
    @IBOutlet weak var labelSatuan: UILabel!
    
    @IBOutlet weak var indicatorWeather: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.darksky.net/forecast/818a1c9ed5ae5f57a64b18bf89c915ac/-6.175110,106.865039")
        let urlRequest = URLRequest(url: url!)
        
        let networkProcessor: NetworkProcessing = NetworkProcessing(request : urlRequest)
        
        networkProcessor.downloadJSON { (jsonDictionary) in
            if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : Any]{
                
                let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
//                let currentTimezone = CurrentWeather(weatherDictionary: currentTimezoneDic)
                
                DispatchQueue.main.async {
                    if let temperature = currentWeather.temperature{
                        self.labelNumberWeather.text = "\(temperature)"
//                        self.labelLocation.text = "\(timezone)"
                        self.showView()
                    } else {
                        self.labelNumberWeather.text = "-"
                    }
                }
            }
        }
        
//        labelSatuan.text = "Celcius"
        labelLocation.text = "Jakarta"
        // Do any additional setup after loading the view.
    }

    func showView()  {
        indicatorWeather.isHidden = true
        labelLocation.isHidden = false
        labelNumberWeather.isHidden = false
        labelSatuan.isHidden = false
    }
    

   
}
