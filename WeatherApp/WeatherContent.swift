//
//  WeatherContent.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 28/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import Foundation

class WeatherContent {
    
    var iconName: String!
    var cityName: String!
    var temperature: String!
    var weatherInWords: String!
    
    var wind: String!
    var cloudiness: String!
    var pressure: String!
    var humidity: String!
    var sunrise: String!
    var sunset: String!
    var geoCoords: String!
    
    init(jsonDictionary: [String : AnyObject]) {
        
        let iconName = jsonDictionary["weather"]![0]["icon"] as! String
        self.iconName = iconName
        
        let cityName = jsonDictionary["name"] as! String
        var countryName = jsonDictionary["sys"]!["country"] as! String
        countryName = ", \(countryName)"
        self.cityName = "\(cityName)\(countryName)"

        let temperature = jsonDictionary["main"]!["temp"] as! Float -  273.15 //Convert kelvin to Celsius
        self.temperature = "\(temperature)\u{00B0}C"
        
        let weatherInWords = jsonDictionary["weather"]![0]["main"] as! String
        self.weatherInWords = weatherInWords

        let wind = jsonDictionary["wind"]!["speed"] as! Int
        self.wind = "\(wind) m/s"
        
        let clouds = jsonDictionary["clouds"]!["all"] as! Int
        self.cloudiness = "\(clouds) %"
        
        let pressure = jsonDictionary["main"]!["pressure"] as! Int
        self.pressure = "\(pressure) hPa"
        
        let humidity = jsonDictionary["main"]!["humidity"] as! Int
        self.humidity = "\(humidity) %"

        let sunrise = jsonDictionary["sys"]!["sunrise"] as! Double
        let sunrise_timeDate =  NSDate(timeIntervalSince1970:sunrise)
        let sunrise_time = NSDateFormatter.localizedStringFromDate(sunrise_timeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        self.sunrise = "\(sunrise_time)"

        let sunset = jsonDictionary["sys"]!["sunset"] as! Double
        let sunset_timeDate =  NSDate(timeIntervalSince1970:sunset)
        let sunset_time = NSDateFormatter.localizedStringFromDate(sunset_timeDate, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        self.sunset = "\(sunset_time)"


        let lat = jsonDictionary["coord"]!["lat"] as! Float
        let lon = jsonDictionary["coord"]!["lon"] as! Float
        let geoCoords = String.localizedStringWithFormat("[%.2f, %.2f]", lat, lon)
        self.geoCoords = "\(geoCoords)"

   }

}