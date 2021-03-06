//
//  SideMenuTableViewController.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 26/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

protocol SideMenuTableVC_Delegate{
    func selectedCity(cityName: String)
}


class SideMenuTableViewController: UITableViewController {

    var delegate_smtvc: SideMenuTableVC_Delegate! = nil
    var cityList = CityListInMenu.loadCityList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsetsMake(50.0, 0, 0, 0) //to give space for navigation bar
        self.tableView.backgroundColor = UIColor(red: 78.0/255.0, green: 77.0/255.0, blue: 74.0/255.0, alpha: 1.0)
        
        let nibName = UINib(nibName: "CityCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "CityCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cityList.cityInMenu.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...

        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        cell.lbl_cityName?.text = cityList.cityInMenu[indexPath.row].cityName

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CityCell
        let cityName = cell.lbl_cityName.text! as String
        
        print(cityName)
        
        self.delegate_smtvc.selectedCity(cityName)
        hideSideMenuView()
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func manuallyReloadTableView() {
        
        cityList = CityListInMenu.loadCityList()
        tableView.reloadData()
    }
}
