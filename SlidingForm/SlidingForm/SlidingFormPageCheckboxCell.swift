//
//  SlidingFormPageCheckboxCell.swift
//  SlidingForm
//
//  Created by Ant on 16/10/15.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormPageCheckboxCell: UITableViewCell {
    
    let titleLbl = UILabel()
    let checkboxElement = SlidingFormElementCheckbox()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(title: String, isSelected: Bool, toggleCallback: @escaping ((_ isSelected: Bool)->())) {
        self.titleLbl.text = title
        checkboxElement.toggleCallback = toggleCallback
        
        self.backgroundColor = UIColor.clear
        
        checkboxElement.initView(isSelected: isSelected)
        
        self.addSubview(titleLbl)
        self.addSubview(checkboxElement)
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: UIScreen.main.bounds.width - 40, height: self.frame.height)
        
        checkboxElement.frame = CGRect(x: 0, y: 8, width: 14, height: 14)
        titleLbl.frame = CGRect(x: 22, y: 2, width: self.frame.width - 22, height: 27)
        
        let conf = SlidingFormPageConfig.sharedInstance
        titleLbl.textColor = conf.textColor
        if let font = UIFont(name: conf.customFontName, size: conf.switchTitleSize) {
            titleLbl.font = font
        } else {
            titleLbl.font = UIFont(name: "System", size: conf.switchTitleSize)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormPageCheckboxCell.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        checkboxElement.toggleCheckbox()
    }
}
