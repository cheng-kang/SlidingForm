//
//  SlidingFormPageSwitchCell.swift
//  SlidingForm
//
//  Created by Ant on 16/10/14.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormPageSwitchCell: UITableViewCell {
    
    var titleLbl = UILabel()
    var switchElement = SlidingFormElementSwitch()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, isActive: Bool, toggleCallback: @escaping ((_ isActive: Bool)->())) {
        self.titleLbl.text = title
        self.switchElement.toggleCallback = toggleCallback
        
        self.backgroundColor = UIColor.clear
        
        switchElement.initView(isActive: isActive)
        
        self.addSubview(titleLbl)
        self.addSubview(switchElement)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: UIScreen.main.bounds.width - 40, height: self.frame.height)
        
        titleLbl.frame = CGRect(x: 0, y: 2, width: self.frame.width - 52 - 8, height: 27)
        switchElement.frame = CGRect(x: self.frame.width - 52, y: 2, width: 52, height: 27)
        
        let conf = SlidingFormPageConfig.sharedInstance
        titleLbl.textColor = conf.textColor
        if let font = UIFont(name: conf.customFontName, size: conf.switchTitleSize) {
            titleLbl.font = font
        } else {
            titleLbl.font = UIFont(name: "System", size: conf.switchTitleSize)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormPageSwitchCell.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        switchElement.toggleSwitch()
    }

}
