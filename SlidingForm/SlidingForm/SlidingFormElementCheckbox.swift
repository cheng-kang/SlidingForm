//
//  SlidingFormElementCheckbox.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormElementCheckbox: UIView {
    
    var isChecked: Bool = false
    
    var toggleCallback: ((_ isSelected: Bool)->())!
    
    let dotView = UIView()
    
    var width: CGFloat = 14
    var borderWidth: CGFloat = 2
    var dotWidth: CGFloat = 10
    
    var borderColor: UIColor = UIColor(red: 240/255, green: 239/255, blue: 241/255, alpha: 1)
    var bgColor: UIColor = UIColor(red: 240/255, green: 239/255, blue: 241/255, alpha: 1)
    var dotColor: UIColor = UIColor(red: 68/255, green: 64/255, blue: 78/255, alpha: 1)
    
    func initView(isSelected: Bool) {
        self.backgroundColor = bgColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: width)
        
        dotView.backgroundColor = dotColor
        dotView.frame.size = CGSize(width: dotWidth, height: dotWidth)
        dotView.center = self.center
        self.addSubview(dotView)
        
        dotView.alpha = 0
        
        if isSelected {
            toggleCheckbox(animated: false)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormElementRatio.handleTap(_:)))
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
