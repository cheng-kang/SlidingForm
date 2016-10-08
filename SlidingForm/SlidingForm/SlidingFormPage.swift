//
//  SlidingFormPage.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

enum SlidingFormPageType: String {
    case input
    case select
    case switches
    case checkbox
    case ratio
    case textarea
}

class SlidingFormPage: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let conf = SlidingFormPageConfig.sharedInstance
    
    var type: SlidingFormPageType!
    var title: String!
    var desc: String?
    var isRequired: Bool!
    var errorMsg: String?
    
    let titleLbl = UILabel()
    let requiredLbl = UILabel()
    let errorMsgLbl = UILabel()
    let descLbl = UILabel()
    let descTextView = UITextView()
    
    // for input
    var inputValue: String?
    var inputFormat: String?
    
    // for select
    var selectOptions: [String]?
    var selectedOptionIndex: Int?
    
    // for switches
    var switchesOptions: [SlidingFormElementSwitch]?
    
    // for checkbox
    var checkboxList: [SlidingFormElementCheckbox]?
    
    // for ratio
    var ratioList: [SlidingFormElementRatio]?
    
    // for textarea
    var textareaValue: String?
    
    func initCommon() {
        
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        requiredLbl.translatesAutoresizingMaskIntoConstraints = false
        errorMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        descLbl.translatesAutoresizingMaskIntoConstraints = false
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLbl)
        self.addSubview(requiredLbl)
        self.addSubview(errorMsgLbl)
        self.addSubview(descLbl)
        self.addSubview(descTextView)
        
        // config titleLbl
        titleLbl.textColor = conf.textColor
        if let font = UIFont(name: conf.customFontName, size: conf.titleLblSize) {
            titleLbl.font = font
        } else {
            titleLbl.font = UIFont(name: "System", size: conf.titleLblSize)
        }
        
        // config requireLbl
        requiredLbl.textColor = conf.textColor
        if let font = UIFont(name: conf.customFontName, size: conf.requiredLblSize) {
            requiredLbl.font = font
        } else {
            requiredLbl.font = UIFont(name: "System", size: conf.requiredLblSize)
        }
        
        // config errorMsgLbl
        errorMsgLbl.textColor = conf.warningColor
        if let font = UIFont(name: conf.customFontName, size: conf.errorMsgLblSize) {
            errorMsgLbl.font = font
        } else {
            errorMsgLbl.font = UIFont(name: "System", size: conf.errorMsgLblSize)
        }
        
        // config descLbl
        descLbl.textColor = conf.descColor
        if let font = UIFont(name: conf.customFontName, size: conf.descLblSize) {
            descLbl.font = font
        } else {
            descLbl.font = UIFont(name: "System", size: conf.descLblSize)
        }
        
        // config descTextView
        descTextView.isEditable = false
        descTextView.isSelectable = false
        descTextView.isScrollEnabled = true
        descTextView.showsVerticalScrollIndicator = false
        descTextView.showsHorizontalScrollIndicator = false
        descTextView.backgroundColor = UIColor.clear
        descTextView.textColor = conf.descColor
        if let font = UIFont(name: conf.customFontName, size: conf.descTextViewSize) {
            descTextView.font = font
        } else {
            descTextView.font = UIFont(name: "System", size: conf.descTextViewSize)
        }
        
        // common
        let titleLblTopConstraint = NSLayoutConstraint(item: titleLbl, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 60)
        let titleLblLeadingConstraint = NSLayoutConstraint(item: titleLbl, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        self.addConstraint(titleLblTopConstraint)
        self.addConstraint(titleLblLeadingConstraint)
        
        let requiredLblBottomConstraint = NSLayoutConstraint(item: requiredLbl, attribute: .bottom, relatedBy: .equal, toItem: titleLbl, attribute: .bottom, multiplier: 1, constant: 0)
        let requiredLblLeadingConstraint = NSLayoutConstraint(item: requiredLbl, attribute: .leading, relatedBy: .equal, toItem: titleLbl, attribute: .trailing, multiplier: 1, constant: 8)
        self.addConstraint(requiredLblBottomConstraint)
        self.addConstraint(requiredLblLeadingConstraint)
        
        let errorMsgLblTopConstraint = NSLayoutConstraint(item: errorMsgLbl, attribute: .top, relatedBy: .equal, toItem: titleLbl, attribute: .bottom, multiplier: 1, constant: 8)
        let errorMsgLblLeadingConstraint = NSLayoutConstraint(item: errorMsgLbl, attribute: .leading, relatedBy: .equal, toItem: titleLbl, attribute: .leading, multiplier: 1, constant: 0)
        self.addConstraint(errorMsgLblTopConstraint)
        self.addConstraint(errorMsgLblLeadingConstraint)
        
        let descTextViewBottomConstraint = NSLayoutConstraint(item: descTextView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -20)
        let descTextViewLeadingConstraint = NSLayoutConstraint(item: descTextView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        let descTextViewTrailingConstraint = NSLayoutConstraint(item: descTextView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
        let descTextViewHeightConstraint = NSLayoutConstraint(item: descTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)
        self.addConstraint(descTextViewBottomConstraint)
        self.addConstraint(descTextViewLeadingConstraint)
        self.addConstraint(descTextViewTrailingConstraint)
        self.addConstraint(descTextViewHeightConstraint)
        
        let descLblBottomConstraint = NSLayoutConstraint(item: descLbl, attribute: .bottom, relatedBy: .equal, toItem: descTextView, attribute: .top, multiplier: 1, constant: 0)
        let descLblLeadingConstraint = NSLayoutConstraint(item: descLbl, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        self.addConstraint(descLblBottomConstraint)
        self.addConstraint(descLblLeadingConstraint)
        
        self.titleLbl.text = title
        self.requiredLbl.text = self.conf.requiredLblText
        
        if self.desc != nil {
            self.descLbl.text = self.conf.descLblText
            self.descTextView.text = self.desc
            
            // !!! descTextView has a bug: cannot scroll to bottom
        }
        
        self.requiredLbl.alpha = self.isRequired == true ? 1 : 0
    }
    
    class func getInput(withFrame frame: CGRect, andSetTitle title: String, isRequired: Bool, desc: String?) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .input
        page.frame = frame
        page.title = title
        page.isRequired = isRequired
        page.desc = desc
        
        page.initCommon()
        
        let textField = UITextField()
        let textFiledBottomLineView = UIView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFiledBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        page.addSubview(textField)
        page.addSubview(textFiledBottomLineView)
        
        // config textfield
        textField.delegate = page
        textField.returnKeyType = .done
        textField.borderStyle = .none
        textField.textColor = page.conf.textColor
        if let font = UIFont(name: page.conf.customFontName, size: page.conf.inputTextSize) {
            textField.font = font
        } else {
            textField.font = UIFont(name: "System", size: page.conf.inputTextSize)
        }
        
        textFiledBottomLineView.backgroundColor = page.conf.textColor
        
        // set constraints
        
        // case only
        let textFieldCenterYConstraint = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: page, attribute: .centerY, multiplier: 1, constant: 0)
        let textFieldLeadingConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: page, attribute: .leading, multiplier: 1, constant: 20)
        let textFieldTrailingConstraint = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: page, attribute: .trailing, multiplier: 1, constant: -20)
        let textFieldHeightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 38)
        page.addConstraint(textFieldCenterYConstraint)
        page.addConstraint(textFieldLeadingConstraint)
        page.addConstraint(textFieldTrailingConstraint)
        page.addConstraint(textFieldHeightConstraint)
        
        let textFieldBottomLineBottomConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .bottom, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 0)
        let textFieldBottomLineLeadingConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .leading, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1, constant: 0)
        let textFieldBottomLineTrailingConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1, constant: 0)
        let textFieldBottomLineHeightConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 2)
        page.addConstraint(textFieldBottomLineBottomConstraint)
        page.addConstraint(textFieldBottomLineLeadingConstraint)
        page.addConstraint(textFieldBottomLineTrailingConstraint)
        page.addConstraint(textFieldBottomLineHeightConstraint)
        
        return page
    }
    
    class func getSelect() {
        
    }
    
    class func getSwitches() {
        
    }
    
    class func getCheckbox() {
        
    }
    
    class func getRatio() {
        
    }
    
    class func getTextarea() {
        
    }
    
}

extension SlidingFormPage: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
