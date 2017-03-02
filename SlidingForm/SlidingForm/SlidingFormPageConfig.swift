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
    var textColor: UIColor = UIColor.black
    var textColorHighlighted: UIColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    var descColor: UIColor = UIColor(red: 93/255, green: 93/255, blue: 93/255, alpha: 1)
    var textBottomLineColor: UIColor = UIColor.black
    var bgColor: UIColor = UIColor.white
    var warningColor: UIColor = UIColor.red
    
    // default font family
    var customFontName = "Didot"
    
    // texts
    var requiredLblText = NSLocalizedString("*required", comment: "SlidingForm")
    var descLblText = NSLocalizedString("Description:", comment: "SlidingForm")
    
    
    // MARK: Switch Config
    
    var switchWidth: CGFloat = 50
    var switchHeight: CGFloat = 25
    var switchBorderWidth: CGFloat = 1
    
    var switchBorderColor: UIColor = UIColor.black
    var switchBgColor: UIColor = UIColor.white
    var switchBgColorActive: UIColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
    var switchButtonColor: UIColor = UIColor.black
    
    // MARK: Checkbox Config
    
    var checkboxWidth: CGFloat = 14
    var checkboxBorderWidth: CGFloat = 2
    var checkboxDotWidth: CGFloat = 8
    
    var checkboxBorderColor: UIColor = UIColor.black
    var checkboxBgColor: UIColor = UIColor.white
    var checkboxDotColor: UIColor = UIColor.black
    
    // MARK: radio Config
    
    var radioWidth: CGFloat = 14
    var radioBorderWidth: CGFloat = 2
    var radioDotWidth: CGFloat = 4
    
    var radioBorderColor: UIColor = UIColor.black
    var radioBgColor: UIColor = UIColor.white
    var radioDotColor: UIColor = UIColor.black
}
