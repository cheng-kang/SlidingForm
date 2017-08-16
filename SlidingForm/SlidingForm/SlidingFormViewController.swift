//
//  SlidingFormViewController.swift
//  CoupleTimezones
//
//  Created by Ant on 16/10/7.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class SlidingFormViewController: UIViewController {
    class func vc(withFormTitle title: String, pages: [SlidingFormPage], currentPageIndex: Int = 0, cancelCallback: (()->())? = nil, finishCallback: ((_ results: [Any])->())?) -> SlidingFormViewController {
        let sb = UIStoryboard.init(name: "SlidingForm", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SlidingFormViewController") as! SlidingFormViewController
        
        vc.cancelCallback = cancelCallback
        vc.finishCallback = finishCallback
        
        vc.formTitile = title
        vc.pages = pages
        vc.currentPageIndex = currentPageIndex
        
        return vc
    }
    
    let config = SlidingFormPageConfig.sharedInstance
    
    // finishCallback: this callback is invoked when the user clicks finishBtn
    //                 (the nextBtn becomes finishBtn when it's the last page)
    // results:  contains result of each page in the order of the pages
    // note that elements in the result may have different data type according to related page type
    var cancelCallback: (()->())?
    var finishCallback: ((_ results: [Any])->())?
    
    let cancelBtn = UIButton()
    let titleLbl = UILabel()
    let scrollview = UIScrollView()
    let prevBtn = UIButton()
    let nextBtn = UIButton()
    let pageLbl = UILabel()
    
    var pages = [SlidingFormPage]()
    
    var margin: CGFloat = 20
    var titleLblY: CGFloat = 60
    var titleLblHeight: CGFloat = 50
    var titleLblToTop: CGFloat = 60
    var titleLblToLeft: CGFloat = 20
    
    var scrollviewToLeft: CGFloat = 20
    var scrollviewToRight: CGFloat = 20
    var scrollviewToTop: CGFloat = 8
    var scrollviewToBottom: CGFloat = 8
    
    var prevBtnToLeft: CGFloat = 20
    var prevBtnToScrollview: CGFloat = 25
    
    var nextBtnLeftToPrevBtn: CGFloat = 10
    
    var pageLblToLeft: CGFloat = 20
    var pageLblToBottom: CGFloat = 30
    
    var formTitile = "" {
        didSet {
            self.titleLbl.text = formTitile
        }
    }
    
    var currentPageIndex = 0 {
        didSet {
            self.pageLbl.text = "\(currentPageIndex+1)/\(pages.count)"
            
            if isLastPage {
                self.nextBtn.setTitle(config.nextBtnTitleS, for: .normal)
            } else {
                self.nextBtn.setTitle(config.nextBtnTitle, for: .normal)
            }
            
            if isFirstPage {
                self.prevBtn.setTitle(config.prevBtnTitleS, for: .normal)
                self.prevBtn.isEnabled = false
            } else {
                self.prevBtn.setTitle(config.prevBtnTitle, for: .normal)
                self.prevBtn.isEnabled = true
            }
            
            if isCurrentPageFinished {
                self.nextBtn.isEnabled = true
            } else {
                self.nextBtn.isEnabled = false
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
                self.scrollview.contentOffset.x = self.scrollview.frame.width * CGFloat(self.currentPageIndex)
                }, completion: nil)
        }
    }
    
    var isLastPage: Bool {
        return currentPageIndex == pages.count - 1
    }
    var isFirstPage: Bool {
        return currentPageIndex == 0
    }
    var isCurrentPageFinished: Bool {
        return self.pages[currentPageIndex].isFinished
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
        self.initUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SlidingFormViewController.handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SlidingFormViewController.handleCurrentPageFinished), name: NSNotification.Name(rawValue: "CurrentPageFinished"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SlidingFormViewController.handleCurrentPageUnfinished), name: NSNotification.Name(rawValue: "CurrentPageUnFinished"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "CurrentPageFinished"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "CurrentPageUnFinished"), object: nil)
    }
    
    var isFirstDidLayoutSubviews = true
    override func viewDidLayoutSubviews() {
        if isFirstDidLayoutSubviews {
            isFirstDidLayoutSubviews = false
            
            let boxWidth = self.scrollview.frame.width
            let boxHeight = self.scrollview.frame.height
            
            // init scroll view content
            for i in 0..<self.pages.count {
                pages[i].frame = CGRect(x: boxWidth*CGFloat(i), y: 0, width: boxWidth, height: boxHeight)
                self.scrollview.addSubview(pages[i])
            }
            
            self.scrollview.contentSize = CGSize(width: boxWidth*CGFloat(self.pages.count), height: boxHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        self.view.isUserInteractionEnabled = true
        self.prevBtn.isUserInteractionEnabled = true
        self.view.backgroundColor = config.bgColor
        
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
        self.cancelBtn.setImage(UIImage(named: "Dismiss")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.cancelBtn.tintColor = config.textColor
        
        self.cancelBtn.addTarget(self, action: #selector(SlidingFormViewController.cancelBtnClick), for: .touchUpInside)
        
        
        // init titleLbl
        self.titleLbl.textAlignment = .left
        self.titleLbl.textColor = config.textColor
        
        if let font = UIFont(name: config.customFontName, size: config.nameLblSize) {
            self.titleLbl.font = font
        } else {
            self.titleLbl.font = UIFont(name: "System", size: config.nameLblSize)
        }
        
        
        // init scrollview
        self.scrollview.isScrollEnabled = false
        self.scrollview.backgroundColor = UIColor.clear
        
        
        // init page btns
        self.prevBtn.setTitleColor(config.textColor, for: .normal)
        self.prevBtn.setTitleColor(config.textColorHighlighted, for: .highlighted)
        self.prevBtn.setTitleColor(config.textColorHighlighted, for: .disabled)
        
        if let font = UIFont(name: config.customFontName, size: config.pageBtnSize) {
            self.prevBtn.titleLabel?.font = font
        } else {
            self.prevBtn.titleLabel?.font = UIFont(name: "System", size: config.pageBtnSize)
        }
        
        self.nextBtn.setTitleColor(config.textColor, for: .normal)
        self.nextBtn.setTitleColor(config.textColorHighlighted, for: .highlighted)
        self.nextBtn.setTitleColor(config.textColorHighlighted, for: .disabled)
        
        if let font = UIFont(name: config.customFontName, size: config.pageBtnSize) {
            self.nextBtn.titleLabel?.font = font
        } else {
            self.nextBtn.titleLabel?.font = UIFont(name: "System", size: config.pageBtnSize)
        }
        
        self.prevBtn.addTarget(self, action: #selector(SlidingFormViewController.prevBtnClick), for: .touchUpInside)
        self.nextBtn.addTarget(self, action: #selector(SlidingFormViewController.nextBtnClick), for: .touchUpInside)
        
        
        // init pageLbl
        self.pageLbl.textAlignment = .left
        self.pageLbl.textColor = config.textColor
        
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
    
    
    func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func handleCurrentPageFinished() {
        self.nextBtn.isEnabled = true
    }
    
    func handleCurrentPageUnfinished() {
        self.nextBtn.isEnabled = false
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
            var results = [Any]()
            
            for page in pages {
                if page.type == .input {
                    // return the text, e.g. "Some Input"
                    results.append(page.textValue ?? "")
                } else if page.type == .select {
                    // return the list of selected option index and value, e.g. [1, "male"]
                    results.append([page.selectedOptionIndex, page.options[page.selectedOptionIndex]])
                } else if page.type == .checkbox {
                    // return a list of checkbox selection list and checkbox options list,
                    // e.g. [[false, true, false, false], ["chrome", "firefox", "opera", "ie"]]
                    results.append([page.optionsValue, page.options])
                } else if page.type == .radio {
                    // return the selected ratio option index and value
                    // e.g. [1, "male"]
                    results.append([page.selectedOptionIndex, page.options[page.selectedOptionIndex]])
                } else if page.type == .switches {
                    // return a list of switch activation list and switches options list,
                    // e.g. [[false, true], ["nightmode", "notification"]]
                    results.append([page.optionsValue, page.options])
                } else if page.type == .textarea {
                    // return the text, e.g. "I would rate this app 5 stars"
                    results.append(page.textValue ?? "")
                }
            }
            self.finishCallback?(results)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func cancelBtnClick() {
        self.cancelCallback?()
        self.dismiss(animated: true, completion: nil)
    }

}

extension SlidingFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
