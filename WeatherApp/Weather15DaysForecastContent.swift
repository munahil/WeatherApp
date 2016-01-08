//
//  Weather15DaysForecastContent.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 31/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import Foundation

class Weather15DaysForecastContent {
    
    var weather_15Days = [Struct_Weather15DaysForecast]()
    
    init(jsonDictionary: [String : AnyObject]) {
        
        let list = jsonDictionary["list"] as! NSArray
            for index in 0..<list.count {
                
                let dict_Obj = jsonDictionary["list"]![index] as! NSDictionary
                
                let temperatureDetails = dict_Obj["temp"]! as! NSDictionary
                let dayTemp_float = temperatureDetails["day"] as! Float -  273.15 //Convert kelvin to Celsius
                let dayTemp = String.localizedStringWithFormat("%.2f \u{00B0}C", dayTemp_float)
                
                let nightTemp_float = temperatureDetails["night"] as! Float -  273.15
                let nightTemp = String.localizedStringWithFormat("%.2f \u{00B0}C", nightTemp_float)
                
                let arr_weatherDetails = dict_Obj["weather"]! as? NSArray
                let weatherDetails = arr_weatherDetails![0] as! NSDictionary
                let description = weatherDetails["description"] as! String
                let iconName = weatherDetails["icon"] as! String

                
                //Next dates
                let calendar = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)
                let dateComponent = NSDateComponents()
                
                dateComponent.day = index
                let newDate = calendar!.dateByAddingComponents(dateComponent, toDate: NSDate(), options:NSCalendarOptions(rawValue: 0))
                let next_date = NSDateFormatter.localizedStringFromDate(newDate!, dateStyle: .ShortStyle, timeStyle: .NoStyle)

                weather_15Days.append(Struct_Weather15DaysForecast(iconName: iconName, date: next_date, dayTemperature: dayTemp, nightTemperature: nightTemp, weatherInWords:description ))
        }
        
    }
    
}