//
//  CityCell.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 26/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var lbl_cityName: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
