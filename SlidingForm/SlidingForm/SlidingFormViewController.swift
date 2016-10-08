//
//  SlidingFormViewController.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/7.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormViewController: UIViewController {
    
    class func vc(withStoryboardName name: String, bundle: Bundle?, identifier: String, andFormTitle title: String, contents: [Any], currentPageIndex: Int = 0, customFontName: String = "") -> SlidingFormViewController {
        let sb = UIStoryboard.init(name: name, bundle: bundle)
        let vc = sb.instantiateViewController(withIdentifier: identifier) as! SlidingFormViewController
        
        vc.formTitile = title
        vc.contents = contents
        vc.currentPageIndex = currentPageIndex
        
        SlidingFormPageConfig.sharedInstance.customFontName = customFontName

        return vc
    }
    
    let config = SlidingFormPageConfig.sharedInstance
    
    let cancelBtn = UIButton()
    let titleLbl = UILabel()
    let scrollview = UIScrollView()
    let prevBtn = UIButton()
    let nextBtn = UIButton()
    let pageLbl = UILabel()
    
    var pages = [UIView]()
    
    var margin: CGFloat = 20
    var titleLblY: CGFloat = 60
    var titleLblHeight: CGFloat = 50
    var titleLblToTop: CGFloat = 60
    var titleLblToLeft: CGFloat = 20
    
    var scrollviewToLeft: CGFloat = 20
    var scrollviewToRight: CGFloat = 20
    var scrollviewToTop: CGFloat = 8
    var scrollviewToBottom: CGFloat = 8
    
    var prevBtnTitle = "上一页"
    var prevBtnTitleS = "第一页"
    var nextBtnTitle = "下一页"
    var nextBtnTitleS = "完成"
    
    var prevBtnToLeft: CGFloat = 20
    var prevBtnToScrollview: CGFloat = 25
    
    var nextBtnLeftToPrevBtn: CGFloat = 10
    
    var pageLblToLeft: CGFloat = 20
    var pageLblToBottom: CGFloat = 30
    
    var lightColor: UIColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
    var lightColorHighlighted: UIColor = UIColor(red: 252/255, green: 252/255, blue: 252/255, alpha: 0.7)
    var greyColor: UIColor = UIColor(red: 240/255, green: 239/255, blue: 241/255, alpha: 1)
    var bgColor: UIColor = UIColor(red: 93/255, green: 87/255, blue: 107/255, alpha: 1)
    var warningColor: UIColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1)
    
    var formTitile = "" {
        didSet {
            self.titleLbl.text = formTitile
        }
    }
    var contents = [Any]()
    
    var anwsers = [String]()
    
    var currentPageIndex = 0 {
        didSet {
            self.pageLbl.text = "\(currentPageIndex+1)/\(contents.count)"
            
            if isLastPage {
                self.nextBtn.setTitle(nextBtnTitleS, for: .normal)
            } else {
                self.nextBtn.setTitle(nextBtnTitle, for: .normal)
            }
            
            if isFirstPage {
                self.prevBtn.setTitle(prevBtnTitleS, for: .normal)
                self.prevBtn.isEnabled = false
            } else {
                self.prevBtn.setTitle(prevBtnTitle, for: .normal)
                self.prevBtn.isEnabled = true
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.scrollview.contentOffset.x = self.scrollview.frame.width * CGFloat(self.currentPageIndex)
                }, completion: nil)
        }
    }
    
    var isLastPage: Bool {
        return currentPageIndex == contents.count - 1
    }
    var isFirstPage: Bool {
        return currentPageIndex == 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.initUI()
    }
    
    var isFirstDidLayoutSubviews = true
    override func viewDidLayoutSubviews() {
        if isFirstDidLayoutSubviews {
            isFirstDidLayoutSubviews = false
            
            
            let boxWidth = self.scrollview.frame.width
            let boxHeight = self.scrollview.frame.height
            
            // init scroll view content
            for i in 0..<self.contents.count {
                let content = self.contents[i] as! [Any]
                let sectionTitle = content[0] as! String
                let sectionDesc = content[1] as? String
                let isRequired = content[2] as! Bool
                let page = SlidingFormPage.getInput(withFrame: CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight), andSetTitle: sectionTitle, isRequired: isRequired, desc: (sectionDesc == "" ? nil : sectionDesc))
                self.scrollview.addSubview(page)
                print(page.frame)
            }
            
            self.scrollview.contentSize = CGSize(width: boxWidth*CGFloat(self.contents.count), height: boxHeight)
        }
//        let boxWidth = self.scrollview.frame.width
//        let boxHeight = self.scrollview.frame.height
//        
//        // init scroll view content
//        for i in 0..<self.contents.count {
//            let content = self.contents[i] as! [Any]
//            let sectionTitle = content[0] as! String
//            let sectionDesc = content[1] as? String
//            let isRequired = content[2] as! Bool
//
//            let boxView = UIView()
//            let sectionTitleLbl = UILabel()
//            let sectionTitleAdditionLbl = UILabel()
//            let errorMsgLbl = UILabel()
//            let textField = UITextField()
//            let textFiledBottomLineView = UIView()
//            let sectionDescLbl = UILabel()
//            let sectionDescTextView = UITextView()
//            
//            boxView.frame = CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight)
//            
//            boxView.addSubview(sectionTitleLbl)
//            boxView.addSubview(sectionTitleAdditionLbl)
//            boxView.addSubview(errorMsgLbl)
//            boxView.addSubview(textField)
//            boxView.addSubview(textFiledBottomLineView)
//            boxView.addSubview(sectionDescLbl)
//            boxView.addSubview(sectionDescTextView)
//            
//            sectionTitleLbl.translatesAutoresizingMaskIntoConstraints = false
//            sectionTitleAdditionLbl.translatesAutoresizingMaskIntoConstraints = false
//            errorMsgLbl.translatesAutoresizingMaskIntoConstraints = false
//            textField.translatesAutoresizingMaskIntoConstraints = false
//            textFiledBottomLineView.translatesAutoresizingMaskIntoConstraints = false
//            sectionDescLbl.translatesAutoresizingMaskIntoConstraints = false
//            sectionDescTextView.translatesAutoresizingMaskIntoConstraints = false
//            
//            textField.delegate = self
//            textField.returnKeyType = .done
//            textField.borderStyle = .none
//            textField.textColor = lightColor
//            if let font = UIFont(name: customFontName, size: 20) {
//                textField.font = font
//            } else {
//                textField.font = UIFont(name: "System", size: 20)
//            }
//            
//            textFiledBottomLineView.backgroundColor = lightColor
//            
//            sectionTitleLbl.textColor = lightColor
//            if let font = UIFont(name: customFontName, size: 22) {
//                sectionTitleLbl.font = font
//            } else {
//                sectionTitleLbl.font = UIFont(name: "System", size: 22)
//            }
//            
//            sectionTitleAdditionLbl.textColor = lightColor
//            if let font = UIFont(name: customFontName, size: 10) {
//                sectionTitleAdditionLbl.font = font
//            } else {
//                sectionTitleAdditionLbl.font = UIFont(name: "System", size: 10)
//            }
//            
//            errorMsgLbl.textColor = warningColor
//            if let font = UIFont(name: customFontName, size: 10) {
//                errorMsgLbl.font = font
//            } else {
//                errorMsgLbl.font = UIFont(name: "System", size: 10)
//            }
//            
//            sectionDescLbl.textColor = greyColor
//            if let font = UIFont(name: customFontName, size: 12) {
//                sectionDescLbl.font = font
//            } else {
//                sectionDescLbl.font = UIFont(name: "System", size: 12)
//            }
//            
//            sectionDescTextView.isEditable = false
//            sectionDescTextView.isSelectable = false
//            sectionDescTextView.backgroundColor = UIColor.clear
//            sectionDescTextView.textColor = greyColor
//            if let font = UIFont(name: customFontName, size: 10) {
//                sectionDescTextView.font = font
//            } else {
//                sectionDescTextView.font = UIFont(name: "System", size: 10)
//            }
//            sectionDescTextView.showsVerticalScrollIndicator = false
//            sectionDescTextView.showsHorizontalScrollIndicator = false
//            
//            
//            let textFieldCenterYConstraint = NSLayoutConstraint(item: textField, attribute: .centerY, relatedBy: .equal, toItem: boxView, attribute: .centerY, multiplier: 1, constant: 0)
//            let textFieldLeadingConstraint = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            let textFieldTrailingConstraint = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: boxView, attribute: .trailing, multiplier: 1, constant: -20)
//            let textFiledHeightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 38)
//            
//            let textFieldBottomLineLeadingConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            let textFieldBottomLineTrailingConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .trailing, relatedBy: .equal, toItem: boxView, attribute: .trailing, multiplier: 1, constant: -20)
//            let textFieldBottomLineBottomConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .bottom, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 0)
//            let textFieldBottomLineHeightConstraint = NSLayoutConstraint(item: textFiledBottomLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 2)
//            
//            let errorMsgBottomConstraint = NSLayoutConstraint(item: errorMsgLbl, attribute: .bottom, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1, constant: -8)
//            let errorMsgLeadingConstraint = NSLayoutConstraint(item: errorMsgLbl, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            
//            let sectionTitleBottomConstraint = NSLayoutConstraint(item: sectionTitleLbl, attribute: .bottom, relatedBy: .equal, toItem: errorMsgLbl, attribute: .top, multiplier: 1, constant: 8)
//            let sectionTitleBottomConstraint2 = NSLayoutConstraint(item: sectionTitleLbl, attribute: .bottom, relatedBy: .equal, toItem: textField, attribute: .top, multiplier: 1, constant: 20)
//            let sectionTitleLeadingConstraint = NSLayoutConstraint(item: sectionTitleLbl, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            
//            let sectionTitleAdditionBottomConstraint = NSLayoutConstraint(item: sectionTitleAdditionLbl, attribute: .bottom, relatedBy: .equal, toItem: sectionTitleLbl, attribute: .bottom, multiplier: 1, constant: 0)
//            let sectionTitleAdditionLeadingConstraint = NSLayoutConstraint(item: sectionTitleAdditionLbl, attribute: .leading, relatedBy: .equal, toItem: sectionTitleLbl, attribute: .trailing, multiplier: 1, constant: 8)
//            
//            let sectionDescLblTopConstraint = NSLayoutConstraint(item: sectionDescLbl, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 8)
//            let sectionDescLblLeadingConstraint = NSLayoutConstraint(item: sectionDescLbl, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            
//            let sectionDescTextTopConstraint = NSLayoutConstraint(item: sectionDescTextView, attribute: .top, relatedBy: .equal, toItem: sectionDescLbl, attribute: .bottom, multiplier: 1, constant: 0)
//            let sectionDescTextLeadingConstraint = NSLayoutConstraint(item: sectionDescTextView, attribute: .leading, relatedBy: .equal, toItem: boxView, attribute: .leading, multiplier: 1, constant: 20)
//            let sectionDescTextTrailingConstraint = NSLayoutConstraint(item: sectionDescTextView, attribute: .trailing, relatedBy: .equal, toItem: boxView, attribute: .trailing, multiplier: 1, constant: -20)
//            let sectionDescTextBottomConstraint = NSLayoutConstraint(item: sectionDescTextView, attribute: .bottom, relatedBy: .equal, toItem: boxView, attribute: .bottom, multiplier: 1, constant: 0)
//            
//            boxView.addConstraints([textFieldCenterYConstraint, textFieldLeadingConstraint, textFieldTrailingConstraint, textFiledHeightConstraint, textFieldBottomLineBottomConstraint, textFieldBottomLineHeightConstraint, textFieldBottomLineLeadingConstraint, textFieldBottomLineTrailingConstraint, errorMsgBottomConstraint, errorMsgLeadingConstraint, sectionTitleBottomConstraint, sectionTitleBottomConstraint2, sectionTitleLeadingConstraint, sectionTitleAdditionBottomConstraint, sectionTitleAdditionLeadingConstraint, sectionDescLblTopConstraint, sectionDescLblLeadingConstraint, sectionDescTextTopConstraint, sectionDescTextBottomConstraint, sectionDescTextLeadingConstraint, sectionDescTextTrailingConstraint])
//            
//            sectionTitleLbl.text = sectionTitle
//            sectionTitleAdditionLbl.text = "*必填"
//            errorMsgLbl.text = "!Error"
//            errorMsgLbl.alpha = 1
//            sectionDescLbl.text = "说明："
//            sectionDescTextView.text = sectionDesc
//            sectionTitleAdditionLbl.alpha = isRequired ? 1 : 0
//            
//            self.scrollview.addSubview(boxView)
//            self.pages.append(boxView)
            
            
//            let page = SlidingFormPage.getInput(withFrame: CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight), andSetname: sectionTitle, isRequired: isRequired, desc: (sectionDesc == "" ? nil : sectionDesc))
//            let page = SlidingFormPage(inputWithFrame: CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight), andSetname: sectionTitle, isRequired: isRequired, desc: (sectionDesc == "" ? nil : sectionDesc))
//            self.scrollview.addSubview(page)
//        }
//        
//        self.scrollview.contentSize = CGSize(width: boxWidth*CGFloat(self.contents.count), height: boxHeight)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        let boxWidth = self.scrollview.frame.width
//        let boxHeight = self.scrollview.frame.height
//        
//        // init scroll view content
//        for i in 0..<self.contents.count {
//            let content = self.contents[i] as! [Any]
//            let sectionTitle = content[0] as! String
//            let sectionDesc = content[1] as? String
//            let isRequired = content[2] as! Bool
//            let page = SlidingFormPage.getInput(withFrame: CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight), andSetname: sectionTitle, isRequired: isRequired, desc: (sectionDesc == "" ? nil : sectionDesc))
//            self.scrollview.addSubview(page)
//            print(page.frame)
//        }
//        
//        self.scrollview.contentSize = CGSize(width: boxWidth*CGFloat(self.contents.count), height: boxHeight)
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.view.isUserInteractionEnabled = true
        self.prevBtn.isUserInteractionEnabled = true
        self.view.backgroundColor = bgColor
        
        self.view.addSubview(cancelBtn)
        self.view.addSubview(titleLbl)
        self.view.addSubview(scrollview)
        self.view.addSubview(prevBtn)
        self.view.addSubview(nextBtn)
        self.view.addSubview(pageLbl)
        
        self.cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        self.titleLbl.translatesAutoresizingMaskIntoConstraints = false
        self.scrollview.translatesAutoresizingMaskIntoConstraints = false
        self.prevBtn.translatesAutoresizingMaskIntoConstraints = false
        self.nextBtn.translatesAutoresizingMaskIntoConstraints = false
        self.pageLbl.translatesAutoresizingMaskIntoConstraints = false
        
        // init cancelBtn
        self.cancelBtn.setImage(UIImage(named: "Dismiss"), for: .normal)
        
        self.cancelBtn.addTarget(self, action: #selector(SlidingFormViewController.cancelBtnClick), for: .touchUpInside)
        
        
        // init titleLbl
        self.titleLbl.textAlignment = .left
        self.titleLbl.textColor = lightColor
        
        if let font = UIFont(name: config.customFontName, size: config.nameLblSize) {
            self.titleLbl.font = font
        } else {
            self.titleLbl.font = UIFont(name: "System", size: config.nameLblSize)
        }
        
        
        // init scrollview
        self.scrollview.isScrollEnabled = false
        self.scrollview.backgroundColor = UIColor.clear
        
        
        // init page btns
        self.prevBtn.tintColor = lightColor
        self.prevBtn.setTitleColor(lightColorHighlighted, for: .highlighted)
        self.prevBtn.setTitleColor(lightColorHighlighted, for: .disabled)
        
        if let font = UIFont(name: config.customFontName, size: config.pageBtnSize) {
            self.prevBtn.titleLabel?.font = font
        } else {
            self.prevBtn.titleLabel?.font = UIFont(name: "System", size: config.pageBtnSize)
        }
        
        self.nextBtn.tintColor = lightColor
        self.nextBtn.setTitleColor(lightColorHighlighted, for: .highlighted)
        self.nextBtn.setTitleColor(lightColorHighlighted, for: .disabled)
        
        if let font = UIFont(name: config.customFontName, size: config.pageBtnSize) {
            self.nextBtn.titleLabel?.font = font
        } else {
            self.nextBtn.titleLabel?.font = UIFont(name: "System", size: config.pageBtnSize)
        }
        
        self.prevBtn.addTarget(self, action: #selector(SlidingFormViewController.prevBtnClick), for: .touchUpInside)
        self.nextBtn.addTarget(self, action: #selector(SlidingFormViewController.nextBtnClick), for: .touchUpInside)
        
        
        // init pageLbl
        self.pageLbl.textAlignment = .left
        self.pageLbl.textColor = lightColor
        
        if let font = UIFont(name: config.customFontName, size: config.pageLblSize) {
            self.pageLbl.font = font
        } else {
            self.pageLbl.font = UIFont(name: "System", size: config.pageLblSize)
        }
        
        
        // init constraints
        let cancelBtnWidthConstraint = NSLayoutConstraint(item: self.cancelBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 30)
        let cancelBtnHeightConstraint = NSLayoutConstraint(item: self.cancelBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30)
        let cancelBtnLeadingConstraint = NSLayoutConstraint(item: self.cancelBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20)
        let cancelBtnBottomToNameLblConstraint = NSLayoutConstraint(item: self.cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: self.titleLbl, attribute: .top, multiplier: 1, constant: -4)
        
        let titleLblLeftConstraint = NSLayoutConstraint(item: self.titleLbl, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: titleLblToLeft)
        let titleLblTopConstaint = NSLayoutConstraint(item: self.titleLbl, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: titleLblToTop)
        
        let scroolviewLeftConstraint = NSLayoutConstraint(item: self.scrollview, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let scroolviewRightConstraint = NSLayoutConstraint(item: self.scrollview, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let scroolviewHeightConstraint = NSLayoutConstraint(item: self.scrollview, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0)
        let scroolviewVerticalCenterConstraint = NSLayoutConstraint(item: self.scrollview, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        
        let prevBtnLeftConstraint = NSLayoutConstraint(item: self.prevBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: prevBtnToLeft)
        let prevBtnToScrollviewConstraint = NSLayoutConstraint(item: self.prevBtn, attribute: .top, relatedBy: .equal, toItem: self.scrollview, attribute: .bottom, multiplier: 1, constant: prevBtnToScrollview)
        
        let nextBtnLeftToPrevBtnConstraint = NSLayoutConstraint(item: self.nextBtn, attribute: .leading, relatedBy: .equal, toItem: self.prevBtn, attribute: .trailing, multiplier: 1, constant: nextBtnLeftToPrevBtn)
        let nextBtnTopConstraint = NSLayoutConstraint(item: self.nextBtn, attribute: .top, relatedBy: .equal, toItem: self.prevBtn, attribute: .top, multiplier: 1, constant: 0)
        
        let pageLblLeftConstraint = NSLayoutConstraint(item: self.pageLbl, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: pageLblToLeft)
        let pageLblBottomConstraint = NSLayoutConstraint(item: self.pageLbl, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -pageLblToBottom)
        
        
        self.view.addConstraints([cancelBtnWidthConstraint, cancelBtnHeightConstraint, cancelBtnLeadingConstraint, cancelBtnBottomToNameLblConstraint, titleLblTopConstaint, titleLblLeftConstraint, pageLblLeftConstraint, pageLblBottomConstraint, scroolviewHeightConstraint, scroolviewLeftConstraint, scroolviewRightConstraint, scroolviewVerticalCenterConstraint, prevBtnLeftConstraint, prevBtnToScrollviewConstraint, nextBtnTopConstraint, nextBtnLeftToPrevBtnConstraint])
    }
    
    func prevBtnClick() {
        if !isFirstPage {
            self.currentPageIndex -= 1
        } else {
            
        }
    }
    
    func nextBtnClick() {
        if !isLastPage {
            self.currentPageIndex += 1
        } else {
            
        }
    }
    
    func cancelBtnClick() {
        self.dismiss(animated: true, completion: nil)
    }

}

extension SlidingFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
