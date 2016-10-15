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
    
    var isFinished: Bool {
        if self.type == .input {
            if self.isRequired != nil {
                if inputRule != nil {
                    return NSPredicate(format: "SELF MATCHES %@", self.inputRule!).evaluate(with: self.inputValue)
                } else {
                    return self.inputValue != nil && self.inputValue != ""
                }
            }
        } else if self.type == .select {
            // nothing
        } else {
        }
        
        return true
    }
    
    var type: SlidingFormPageType!
    var title: String!
    var desc: String?
    var isRequired: Bool?
    var errorMsg: String?
    
    let titleLbl = UILabel()
    let requiredLbl = UILabel()
    let errorMsgLbl = UILabel()
    let descLbl = UILabel()
    let descTextView = UITextView()
    
    // for input
    var inputValue: String?
    var inputFormat: String?
    var inputRule: String? // regular expression
    
    // for select, switches, checkbox, and ratio
    var options = [String]()
    var optionsValue = [Bool]()
    var selectedOptionIndex = 0
    var selectionMax: Int?
    var selectionMin: Int?
    
    // for switches, checkbox, and ratio
    var tbl: UITableView?
    var cellList: [String:Any]?
    
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
        
        if self.desc != nil {
            self.descLbl.text = self.conf.descLblText
            self.descTextView.text = self.desc
            
            // !!! descTextView has a bug: cannot scroll to bottom
        }
        
        if self.isRequired != nil {
            self.requiredLbl.text = self.conf.requiredLblText
            self.requiredLbl.alpha = self.isRequired == true ? 1 : 0
        }
        
        // tableview for switches, checkbox, and ratio
        if self.type == .switches || self.type == .checkbox || self.type == .ratio {
            self.tbl = UITableView()
            self.tbl!.dataSource = self
            self.tbl!.delegate = self
            self.tbl!.allowsSelection = false
            self.tbl!.showsVerticalScrollIndicator = false
            self.tbl!.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.tbl!)
            
            self.cellList = [String:Any]()
            
            let tblTop = NSLayoutConstraint(item: self.tbl!, attribute: .top, relatedBy: .equal, toItem: self.errorMsgLbl, attribute: .bottom, multiplier: 1, constant: 8)
            let tblBottom = NSLayoutConstraint(item: self.tbl!, attribute: .bottom, relatedBy: .equal, toItem: self.descLbl, attribute: .top, multiplier: 1, constant: -8)
            let tblLeading = NSLayoutConstraint(item: self.tbl!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
            let tblTrailing = NSLayoutConstraint(item: self.tbl!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
            self.addConstraint(tblTop)
            self.addConstraint(tblBottom)
            self.addConstraint(tblLeading)
            self.addConstraint(tblTrailing)
            
            self.tbl?.backgroundColor = UIColor.clear
            self.tbl?.tableFooterView = UIView()
            self.tbl?.separatorStyle = .none
        }
    }
    
    class func getInput(withTitle title: String, isRequired: Bool, desc: String?, defaultValue: String? = nil, inputRule: String? = nil, errorMsg: String? = nil) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .input
        page.title = title
        page.isRequired = isRequired
        page.desc = desc
        page.inputValue = defaultValue
        page.inputRule = inputRule
        page.errorMsg = errorMsg
        
        page.initCommon()
        
        
        let textField = UITextField()
        let textFiledBottomLineView = UIView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFiledBottomLineView.translatesAutoresizingMaskIntoConstraints = false
        page.addSubview(textField)
        page.addSubview(textFiledBottomLineView)
        
        textField.addTarget(page, action: #selector(page.handleTextFieldChange(sender:)), for: .editingChanged)
        
        
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
        
        if defaultValue != nil {
            textField.text = defaultValue!
        }
        
        return page
    }
    
    class func getSelect(withTitle title: String, desc: String?, selectOptions: [String], selectedOptionIndex: Int = 0) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .select
        page.title = title
        page.desc = desc
        page.options = selectOptions
        page.selectedOptionIndex = selectedOptionIndex
        
        page.initCommon()
        
        
        let selectView = UIPickerView()
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.delegate = page
        selectView.dataSource = page
        page.addSubview(selectView)
        
        selectView.backgroundColor = UIColor.clear
        
        let selectViewHeightConstraint = NSLayoutConstraint(item: selectView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: page.conf.selectRowHeight * page.conf.showedSelectRowNumber)
        let selectViewLeadingConstraint = NSLayoutConstraint(item: selectView, attribute: .leading, relatedBy: .equal, toItem: page, attribute: .leading, multiplier: 1, constant: 20)
        let selectViewTrailingConstraint = NSLayoutConstraint(item: selectView, attribute: .trailing, relatedBy: .equal, toItem: page, attribute: .trailing, multiplier: 1, constant: -20)
        let selectViewCenterYConstraint = NSLayoutConstraint(item: selectView, attribute: .centerY, relatedBy: .equal, toItem: page, attribute: .centerY, multiplier: 1, constant: 0)
        page.addConstraint(selectViewHeightConstraint)
        page.addConstraint(selectViewLeadingConstraint)
        page.addConstraint(selectViewTrailingConstraint)
        page.addConstraint(selectViewCenterYConstraint)
        
        
        selectView.selectRow(selectedOptionIndex, inComponent: 0, animated: true)
        
        return page
    }
    
    class func getSwitches(withTitle title: String, desc: String?, options: [String], optionsDefaultValue: [Bool], selectionMin: Int = 0, selectionMax: Int = Int.max) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .switches
        page.title = title
        page.desc = desc
        page.options = options
        page.optionsValue = optionsDefaultValue
        page.selectionMin = selectionMin
        page.selectionMax = selectionMax
        
        page.initCommon()
        
        return page
    }
    
    class func getCheckbox(withTitle title: String, desc: String?, options: [String], optionsDefaultValue: [Bool], selectionMin: Int = 0, selectionMax: Int = Int.max) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .checkbox
        page.title = title
        page.desc = desc
        page.options = options
        page.optionsValue = optionsDefaultValue
        page.selectionMin = selectionMin
        page.selectionMax = selectionMax
        
        page.initCommon()
        
        return page
    }
    
    class func getRatio(withTitle title: String, desc: String?, options: [String], selectedOptionIndex: Int = 0) -> SlidingFormPage {
        let page = SlidingFormPage()
        
        page.type = .ratio
        page.title = title
        page.desc = desc
        page.options = options
        page.selectedOptionIndex = selectedOptionIndex
        page.selectionMin = 1
        page.selectionMax = 1
        
        page.initCommon()
        
        return page
    }
    
    class func getTextarea() {
        
    }
    
    func handleTextFieldChange(sender: UITextField) {
        self.inputValue = sender.text
        
        if self.isFinished {
            self.errorMsgLbl.text = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentPageFinished"), object: nil)
        } else {
            self.errorMsgLbl.text = self.errorMsg
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "CurrentPageUnFinished"), object: nil)
        }
    }
    
}

extension SlidingFormPage: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

extension SlidingFormPage: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedOptionIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = self.conf.textColor
        pickerLabel.text = self.options[row]
        if let font = UIFont(name: self.conf.customFontName, size: self.conf.selectTitleSize) {
            pickerLabel.font = font
        } else {
            pickerLabel.font = UIFont(name: "System", size: self.conf.selectTitleSize)
        }
        
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.conf.selectRowHeight
    }
}

extension SlidingFormPage: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.type == .switches {
            let cell = SlidingFormPageSwitchCell()
            cell.configureCell(title: self.options[indexPath.row], isActive: self.optionsValue[indexPath.row], toggleCallback:  { isActive in
                if isActive {
                    var count = 0
                    for i in 0..<self.options.count {
                        if self.optionsValue[i] {
                            count += 1
                        }
                    }
                    
                    if count == self.selectionMax {
                        cell.switchElement.toggleSwitch(animated: false)
                    } else {
                        self.optionsValue[indexPath.row] = isActive
                    }
                } else {
                    self.optionsValue[indexPath.row] = isActive
                }
                
            })
            
            return cell
        } else if self.type == .ratio {
            let cell = SlidingFormPageRatioCell()
            cell.configureCell(title: self.options[indexPath.row], isSelected: indexPath.row == selectedOptionIndex, toggleCallback:  { isSelected in
                if indexPath.row != self.selectedOptionIndex {
                    let temp = self.selectedOptionIndex
                    self.selectedOptionIndex = indexPath.row
                    
                    tableView.reloadData()
                } else {
                    cell.ratioElement.toggleRatio(animated: false)
                }
            })
            
            return cell
        } else if self.type == .checkbox {
            let cell = SlidingFormPageCheckboxCell()
            cell.configureCell(title: self.options[indexPath.row], isSelected: self.optionsValue[indexPath.row], toggleCallback:  { isActive in
                if isActive {
                    var count = 0
                    for i in 0..<self.options.count {
                        if self.optionsValue[i] {
                            count += 1
                        }
                    }
                    
                    if count == self.selectionMax {
                        tableView.reloadData()
                    } else {
                        self.optionsValue[indexPath.row] = isActive
                    }
                } else {
                    self.optionsValue[indexPath.row] = isActive
                }
                
            })
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
