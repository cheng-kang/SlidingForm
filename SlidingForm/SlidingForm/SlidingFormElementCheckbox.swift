//
//  SlidingFormElementCheckbox.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormElementCheckbox: UIView {
    
    let conf = SlidingFormPageConfig.sharedInstance
    
    var isChecked: Bool = false
    
    var toggleCallback: ((_ isSelected: Bool)->())!
    
    let dotView = UIView()
    
    func initView(isSelected: Bool) {
        self.backgroundColor = conf.checkboxBgColor
        self.layer.borderWidth = conf.checkboxBorderWidth
        self.layer.borderColor = conf.checkboxBorderColor.cgColor
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: conf.checkboxWidth, height: conf.checkboxWidth)
        
        dotView.backgroundColor = conf.checkboxDotColor
        dotView.frame.size = CGSize(width: conf.checkboxDotWidth, height: conf.checkboxDotWidth)
        dotView.center = self.center
        self.addSubview(dotView)
        
        dotView.alpha = 0
        
        if isSelected {
            toggleCheckbox(animated: false)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormElementCheckbox.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.toggleCheckbox()
    }
    
    func toggleCheckbox(animated: Bool = true) {
        self.isChecked = !self.isChecked
        let newAlpha: CGFloat = isChecked ? 1 : 0
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.dotView.alpha = newAlpha
                self.toggleCallback(self.isChecked)
                }, completion: nil)
        } else {
            self.dotView.alpha = newAlpha
        }
    }
}
