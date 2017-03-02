//
//  SlidingFormElementRatio.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormElementRadio: UIView {
    
    let conf = SlidingFormPageConfig.sharedInstance
    
    var isSelected: Bool = false
    
    var toggleCallback: ((_ isSelected: Bool)->())!
    
    let dotView = UIView()
    
    func initView(isSelected: Bool) {
        self.backgroundColor = conf.radioBgColor
        self.layer.borderWidth = conf.radioBorderWidth
        self.layer.borderColor = conf.radioBorderColor.cgColor
        self.layer.cornerRadius = conf.radioWidth / 2
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: conf.radioWidth, height: conf.radioWidth)
        
        dotView.backgroundColor = conf.radioDotColor
        dotView.frame.size = CGSize(width: conf.radioDotWidth, height: conf.radioDotWidth)
        dotView.center = self.center
        dotView.layer.cornerRadius = conf.radioDotWidth / 2
        self.addSubview(dotView)
        
        dotView.alpha = 0
        
        if isSelected {
            toggleRatio(animated: false)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormElementRadio.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.toggleRatio()
    }
    
    func toggleRatio(animated: Bool = true) {
        self.isSelected = !self.isSelected
        let newAlpha: CGFloat = isSelected ? 1 : 0
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: { 
                self.dotView.alpha = newAlpha
                self.toggleCallback(self.isSelected)
                }, completion: nil)
        } else {
            self.dotView.alpha = newAlpha
        }
    }
    
}
