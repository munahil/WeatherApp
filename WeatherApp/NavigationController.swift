//
//  NavigationController.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 26/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

//subclassed ENSideMenuNavigationController
class NavigationController:  ENSideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: SideMenuTableViewController(), menuPosition:.Left)
        sideMenu?.menuWidth = 200.0
        // show the navigation bar over the side menu view
        view.bringSubviewToFront(navigationBar)
    }
    

    // MARK:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
