//
//  SlidingFormElementSwitch.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormElementSwitch: UIView {
    
    let conf = SlidingFormPageConfig.sharedInstance
    
    var isActive: Bool = false
    
    var toggleCallback: ((_ isActive: Bool)->())!
    
    var bgLeftActiveView = UIView()
    var switchButtonView = UIView()
    
    func initView(isActive: Bool) {
        self.backgroundColor = conf.switchBgColor
        self.layer.borderWidth = conf.switchBorderWidth
        self.layer.borderColor = conf.switchBorderColor.cgColor
        
        bgLeftActiveView.frame = CGRect(x: conf.switchBorderWidth, y: conf.switchBorderWidth, width: conf.switchWidth/2, height: conf.switchHeight)
        bgLeftActiveView.backgroundColor = conf.switchBgColorActive
        self.addSubview(bgLeftActiveView)
        
        switchButtonView.frame = CGRect(x: conf.switchBorderWidth, y: conf.switchBorderWidth, width: conf.switchWidth/2, height: conf.switchHeight)
        switchButtonView.backgroundColor = conf.switchButtonColor
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
        
        let newCenter: CGPoint = CGPoint(x: self.isActive ? conf.switchWidth/4*3 + conf.switchBorderWidth : conf.switchWidth/4 + conf.switchBorderWidth, y: switchButtonView.center.y)
        
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
