//
//  ViewController.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 25/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, ENSideMenuDelegate, UISearchBarDelegate, SideMenuTableVC_Delegate, CLLocationManagerDelegate {

    //IBOutlets
    @IBOutlet weak var imgV_weather: UIImageView!
    @IBOutlet weak var lbl_CityName: UILabel!
    @IBOutlet weak var lbl_Temperature: UILabel!
    @IBOutlet weak var lbl_WeatherInWords: UILabel!
    @IBOutlet weak var lbl_Wind: UILabel!
    @IBOutlet weak var lbl_Cloudiness: UILabel!
    @IBOutlet weak var lbl_Pressure: UILabel!
    @IBOutlet weak var lbl_Humidity: UILabel!
    @IBOutlet weak var lbl_Sunrise: UILabel!
    @IBOutlet weak var lbl_Sunset: UILabel!
    @IBOutlet weak var lbl_GeoCoords: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager: CLLocationManager!
    var weather_15Days = [Struct_Weather15DaysForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //get current location
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        //side menu
        self.sideMenuController()?.sideMenu?.delegate = self
        
       let menu =  self.sideMenuController()?.sideMenu?.menuViewController as! SideMenuTableViewController
        menu.delegate_smtvc = self
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //Read from Json File
        if let searchCity = searchBar.text {
            self.weatherForCity(searchCity)
            searchBar.resignFirstResponder()
        }
    }
    
    func weatherForCity(city: String)
    {
        DataManager.api_openWeatherMap(city) { (result) in
            guard let weatherResult = result else { return }
            dispatch_async(dispatch_get_main_queue()) { () in
                if let url  = NSURL(string: "http://openweathermap.org/img/w/\(weatherResult.iconName).png"),
                    data_img = NSData(contentsOfURL: url)
                {
                    self.imgV_weather.image = UIImage(data: data_img)
                }
                
                self.lbl_CityName.text = weatherResult.cityName
                self.lbl_Temperature.text = weatherResult.temperature
                self.lbl_WeatherInWords.text = weatherResult.weatherInWords
                self.lbl_Wind.text = weatherResult.wind
                self.lbl_Cloudiness.text = weatherResult.cloudiness
                self.lbl_Pressure.text = weatherResult.pressure
                self.lbl_Humidity.text = weatherResult.humidity
                self.lbl_Sunrise.text = weatherResult.sunrise
                self.lbl_Sunset.text = weatherResult.sunset
                self.lbl_GeoCoords.text = weatherResult.geoCoords
            }
            
        }
    }
    
    func weatherForCurrentLatLon(lat: String, lon: String)
    {
        DataManager.api_openWeatherMap_currentLatLon(lat, lon: lon) { (result) in
            guard let weatherResult = result else { return }
            dispatch_async(dispatch_get_main_queue()) { () in
                if let url  = NSURL(string: "http://openweathermap.org/img/w/\(weatherResult.iconName).png"),
                    data_img = NSData(contentsOfURL: url)
                {
                    self.imgV_weather.image = UIImage(data: data_img)
                }
                
                self.lbl_CityName.text = weatherResult.cityName
                self.lbl_Temperature.text = weatherResult.temperature
                self.lbl_WeatherInWords.text = weatherResult.weatherInWords
                self.lbl_Wind.text = weatherResult.wind
                self.lbl_Cloudiness.text = weatherResult.cloudiness
                self.lbl_Pressure.text = weatherResult.pressure
                self.lbl_Humidity.text = weatherResult.humidity
                self.lbl_Sunrise.text = weatherResult.sunrise
                self.lbl_Sunset.text = weatherResult.sunset
                self.lbl_GeoCoords.text = weatherResult.geoCoords
            }
            
        }
        
    }
    
    @IBAction func tapped_OnView(recogniser: AnyObject) {
        //Hide Keyboard
        self.searchBar.endEditing(true)
    }

    
    @IBAction func sideMenu(sender: AnyObject) {
        //Show side menu
        toggleSideMenuView()
    }
    
    @IBAction func saveCity(sender: AnyObject) {
    
        let newCity = CityInMenu()
        newCity.cityName = self.lbl_CityName.text
        
        let cityList = CityListInMenu.loadCityList()
        
        //temperory Array to keep a list of City Names
        var tempArray_CityNames: [String] = []
        for index in 0..<cityList.cityInMenu.count {
            tempArray_CityNames.append(cityList.cityInMenu[index].cityName)
        }
        
        if (!tempArray_CityNames.contains(newCity.cityName) && !newCity.cityName.isEmptyOrWhitespace)
        {
            //Only add City if it is not already present
            cityList.cityInMenu.append(newCity)
            cityList.saveCityData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "VC_to_FifteenDaysForecast") {
            // pass data to next view
            let destVC:FifteenDaysTableViewController = segue.destinationViewController as! FifteenDaysTableViewController
            destVC.weather_15Days = weather_15Days
        }
    }
    
    @IBAction func nextFifteenDaysForecast(sender: AnyObject) {
         var city_name = self.lbl_CityName.text
        
        if (!city_name!.isEmptyOrWhitespace)
        {
            if city_name!.containsString(",")
            {
                var onlyCityName = city_name!.componentsSeparatedByString(",")
                city_name = onlyCityName[0]
                
            }
            
            DataManager.api_openWeatherMap_forecast15days(city_name!) { (result) in
                guard let weatherResult = result else { return }
                dispatch_async(dispatch_get_main_queue()) { () in
                    self.weather_15Days = weatherResult.weather_15Days
                    
                    self.performSegueWithIdentifier("VC_to_FifteenDaysForecast", sender: nil)
                }
            }
        }
    }

    //MARK:
    func selectedCity(cityName: String)
    {
        if cityName.containsString(",")
        {
            var onlyCityName = cityName.componentsSeparatedByString(",")
            self.weatherForCity(onlyCityName[0])
        }
    }

    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        let menu = self.sideMenuController()?.sideMenu?.menuViewController as! SideMenuTableViewController
        menu.manuallyReloadTableView()
        
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("location : \(center)")
        let lat = String.localizedStringWithFormat("%.3f", location.coordinate.latitude)
        let lon = String.localizedStringWithFormat("%.3f", location.coordinate.longitude)
        
        self.weatherForCurrentLatLon(lat, lon: lon)
        locationManager.stopUpdatingLocation()
    }
    

    
    // MARK:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension String {
    var isEmptyOrWhitespace: Bool {
        
        if(self.isEmpty)
        {
            return true
        }
        
        return (self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) == "")
    }
}
