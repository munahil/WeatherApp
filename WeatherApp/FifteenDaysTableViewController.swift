//
//  FifteenDaysTableViewController.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 30/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

class FifteenDaysTableViewController: UITableViewController {

    var weather_15Days = [Struct_Weather15DaysForecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(weather_15Days)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather_15Days.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FifteenDaysCell", forIndexPath: indexPath) as! FifteenDaysCell
        
        cell.lbl_date.text = weather_15Days[indexPath.row].date
        cell.lbl_tempDay.text = weather_15Days[indexPath.row].dayTemperature
        cell.lbl_tempNight.text = weather_15Days[indexPath.row].nightTemperature
        cell.lbl_desc.text = weather_15Days[indexPath.row].weatherInWords
        
        //download Image Asynchrounusly
        let imageURL =  "http://openweathermap.org/img/w/\(weather_15Days[indexPath.row].iconName).png"
        
        downloadImage(imageURL, imgV_setURLImg: cell.imgV_icon)
        
        return cell
    }
    
    
    // MARK: - AsynchronuslyLoadImage
    
    func downloadImage(string_url:String, imgV_setURLImg:UIImageView)
    {
        let url = NSURL(string: string_url)
        
        getDataFromUrl(url!) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                imgV_setURLImg.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
   
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
