//
//  DataManager.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 28/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import Foundation

enum JSONError: String, ErrorType {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

let appid:String = "2de143494c0b295cca9337e1e96b00e0"

class DataManager {
    

    static func api_openWeatherMap(city:String, completion:(result: WeatherContent?) -> Void) {
        
        //Had to set NSAllowsArbitraryLoads key to YES under NSAppTransportSecurity dictionary in  info.plist file, as API is using "HTTP" over HTTPS"
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appid)"
        
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                print(json)

                var weatherModelObject: WeatherContent?
                weatherModelObject = WeatherContent(jsonDictionary: json as! [String : AnyObject])

                completion(result: weatherModelObject)
                
            } catch let error as JSONError {
                completion(result: nil)
                print(error.rawValue)
            } catch {
                completion(result: nil)
                print(error)
            }
            }.resume()
    }
    
    static func api_openWeatherMap_currentLatLon(lat:String, lon:String, completion:(result: WeatherContent?) -> Void) {
        
        //Had to set NSAllowsArbitraryLoads key to YES under NSAppTransportSecurity dictionary in  info.plist file, as API is using "HTTP" over HTTPS"
        
        let urlPath = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(appid)"
        
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                print(json)
                
                var weatherModelObject: WeatherContent?
                weatherModelObject = WeatherContent(jsonDictionary: json as! [String : AnyObject])
                
                completion(result: weatherModelObject)
                
            } catch let error as JSONError {
                completion(result: nil)
                print(error.rawValue)
            } catch {
                completion(result: nil)
                print(error)
            }
            }.resume()
    }
    
    
    
    static func api_openWeatherMap_forecast15days(city:String, completion:(result: Weather15DaysForecastContent?) -> Void) {
        
        //Had to set NSAllowsArbitraryLoads key to YES under NSAppTransportSecurity dictionary in  info.plist file, as API is using "HTTP" over HTTPS"
        
        let urlPath = "http://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&cnt=15&appid=\(appid)"
        
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                guard let dat = data else { throw JSONError.NoData }
                guard let json = try NSJSONSerialization.JSONObjectWithData(dat, options: []) as? NSDictionary else { throw JSONError.ConversionFailed }
                print(json)
                
                var weather15DaysModelObject: Weather15DaysForecastContent?
                weather15DaysModelObject = Weather15DaysForecastContent(jsonDictionary: json as! [String : AnyObject])
                
                completion(result: weather15DaysModelObject)
                
            } catch let error as JSONError {
                completion(result: nil)
                print(error.rawValue)
            } catch {
                completion(result: nil)
                print(error)
            }
            }.resume()
    }

    
}