//
//  CityInMenu.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 30/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

class CityInMenu: NSObject, NSCoding {
    
    var cityName : String!
    
    override init() {
        super.init()
    }
    
    //We are saving "cityName" here, so that we can retrive it later
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(cityName, forKey: "CityNameKey")
    }
    
    //here we decode "cityName"
    required init?(coder aDecoder: NSCoder) {
        if let text = aDecoder.decodeObjectForKey("CityNameKey") as? String {
            self.cityName = text
        }
    }
}
