//
//  CityListInMenu.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 30/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

class CityListInMenu: NSObject, NSCoding {
    
    var cityInMenu = [CityInMenu]()
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(cityInMenu, forKey: "CityListKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let cities = aDecoder.decodeObjectForKey("CityListKey") as? [CityInMenu] {
            self.cityInMenu = cities
        }
    }
    
    class func dataPath() -> String {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        let dataPath = (documentsDirectory as NSString).stringByAppendingPathComponent("CityData")
        return dataPath
    }
    
    func saveCityData() {
        NSKeyedArchiver.archiveRootObject(self, toFile: CityListInMenu.dataPath())
    }
    
    class func loadCityList() -> CityListInMenu {
        if let cityList = NSKeyedUnarchiver.unarchiveObjectWithFile(CityListInMenu.dataPath()) as? CityListInMenu {
            return cityList
        } else {
            return CityListInMenu()
        }
    }
}