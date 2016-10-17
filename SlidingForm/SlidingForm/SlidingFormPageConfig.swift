//
//  SlidingFormPageConfig.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import Foundation
import UIKit

class SlidingFormPageConfig: NSObject {
    static let sharedInstance = SlidingFormPageConfig()
    
    // MARK: Form Config
    
    // size
    var nameLblSize: CGFloat = 40
    var pageBtnSize: CGFloat = 20
    var pageLblSize: CGFloat = 17
    
    // texts
    var prevBtnTitle = NSLocalizedString("Prev", comment: "SlidingForm")
    var prevBtnTitleS = NSLocalizedString("First", comment: "SlidingForm")
    var nextBtnTitle = NSLocalizedString("Next", comment: "SlidingForm")
    var nextBtnTitleS = NSLocalizedString("Done", comment: "SlidingForm")
    
    
    // MARK: Page Config
    
    // size
    var titleLblSize: CGFloat = 22
    var requiredLblSize: CGFloat = 10
    var errorMsgLblSize: CGFloat = 10
    var descLblSize: CGFloat = 12
    var descTextViewSize: CGFloat = 10
    
    var inputTextSize: CGFloat = 20
    var selectTitleSize: CGFloat = 20
    var switchTitleSize: CGFloat = 18
    var textareaTextSize: CGFloat = 16
    
    var selectRowHeight: CGFloat = 20
    var showedSelectRowNumber: CGFloat = 5
    
    // color
    var textColor: UIColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
    var textColorHighlighted: UIColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 0.7)
    var textBottomLineColor: UIColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
    var descColor: UIColor = UIColor(red: 240/255, green: 239/255, blue: 241/255, alpha: 0.7)
    var bgColor: UIColor = UIColor(red: 93/255, green: 87/255, blue: 107/255, alpha: 1)
    var warningColor: UIColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
    
    // default font
    var customFontName = "Futura"
    
    // texts
    var requiredLblText = NSLocalizedString("*required", comment: "SlidingForm")
    var descLblText = NSLocalizedString("Description:", comment: "SlidingForm")
    
    
    // MARK: Switch Config
    
    var switchWidth: CGFloat?
    var switchHeight: CGFloat?
    var switchBorderWidth: CGFloat?
    
    var switchBorderColor: UIColor?
    var switchBgColor: UIColor?
    var switchBgColorActive: UIColor?
    var switchButtonColor: UIColor?
    
    // MARK: Checkbox Config
    
    var checkboxWidth: CGFloat?
    var checkboxBorderWidth: CGFloat?
    var checkboxDotWidth: CGFloat?
    
    var checkboxBorderColor: UIColor?
    var checkboxBgColor: UIColor?
    var checkboxDotColor: UIColor?
    
    
    // MARK: Ratio Config
    
    var ratioWidth: CGFloat?
    var ratioBorderWidth: CGFloat?
    var ratioDotWidth: CGFloat?
    
    var ratioBorderColor: UIColor?
    var ratioBgColor: UIColor?
    var ratioDotColor: UIColor?
}
