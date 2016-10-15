//
//  SlidingFormElementSwitch.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormElementSwitch: UIView {
    
    var isActive: Bool = false
    
    var toggleCallback: ((_ isActive: Bool)->())!
    
    var width: CGFloat = 50
    var height: CGFloat = 25
    var borderWidth: CGFloat = 1
    
    var borderColor: UIColor = UIColor(red: 68/255, green: 64/255, blue: 78/255, alpha: 1)
    var bgColor: UIColor = UIColor(red: 240/255, green: 239/255, blue: 241/255, alpha: 1)
    var bgColorActive: UIColor = UIColor(red: 93/255, green: 87/255, blue: 107/255, alpha: 1)
    var buttonColor: UIColor = UIColor(red: 68/255, green: 64/255, blue: 78/255, alpha: 1)
    
    var bgLeftActiveView = UIView()
    var switchButtonView = UIView()
    
    func initView(isActive: Bool) {
        self.backgroundColor = bgColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        bgLeftActiveView.frame = CGRect(x: borderWidth, y: borderWidth, width: width/2, height: height)
        bgLeftActiveView.backgroundColor = bgColorActive
        self.addSubview(bgLeftActiveView)
        
        switchButtonView.frame = CGRect(x: borderWidth, y: borderWidth, width: width/2, height: height)
        switchButtonView.backgroundColor = buttonColor
        self.addSubview(switchButtonView)
        
        // init tap event by adding tap gesture recognizer to self
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormElementSwitch.handleTap(_:)))
        self.addGestureRecognizer(tap)
        
        if isActive {
            self.toggleSwitch(animated: false)
        }
    }
    
    deinit {
        // remove gesture recognizers
        self.gestureRecognizers?.forEach({ (gr) in
            self.removeGestureRecognizer(gr)
        })
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        self.toggleSwitch()
    }
    
    func toggleSwitch(animated: Bool = true) {
        self.isActive = !self.isActive
        
        let newCenter: CGPoint = CGPoint(x: self.isActive ? width/4*3 + borderWidth : width/4 + borderWidth, y: switchButtonView.center.y)
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.switchButtonView.center = newCenter
                self.toggleCallback(self.isActive)
            }) { (isSuccess) in
            }
        } else {
            self.switchButtonView.center = newCenter
        }
    }
}
