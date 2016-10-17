//
//  ViewController.swift
//  SlidingForm
//
//  Created by Ant on 16/10/8.
//  Copyright © 2016年 Ant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        SlidingFormPageConfig.sharedInstance.customFontName = "Futura"
        
        let options = ["男性", "女性", "其他"]
//        
//        let vc = SlidingFormViewController.vc(
//            withFormTitle: NSLocalizedString("Settings",comment: "SlidingForm"),
//            pages: [
//                SlidingFormPage.getSwitches(withTitle: "Enable Notification", desc: nil, options: ["Local Notification", "Push Notification", "定时闹钟", "自动同步"], optionsDefaultValue: [true, false, true, true]) ,
//                SlidingFormPage.getRatio(withTitle: "你的性别", desc: nil, options: ["男性", "女性", "其他", "女性", "其他"], selectedOptionIndex: 1) ,
//                SlidingFormPage.getCheckbox(withTitle: "擅长的语言", desc: nil, options: ["汉语", "英语", "日语", "法语", "西班牙语"], optionsDefaultValue: [true, true, true, false, false], selectionMin: 0, selectionMax: 4) ,
//                SlidingFormPage.getInput(withTitle: NSLocalizedString("Your Nickname", comment: "SlidingForm"), isRequired: true, desc: NSLocalizedString("Please enter your nickname.", comment: "SlidingForm"), defaultValue: NSLocalizedString("Default Nickname", comment: "SlidingForm"), errorMsg: "长度至少一位"),
//                SlidingFormPage.getTextarea(withTitle: NSLocalizedString("Partner's Nickname", comment: "SlidingForm"), isRequired: true, desc: NSLocalizedString("Please enter your partner's nickname.", comment: "SlidingForm"), defaultValue: nil, errorMsg: "长度至少一位"),
//                SlidingFormPage.getInput(withTitle: NSLocalizedString("Your Code", comment: "SlidingForm"), isRequired: true, desc: NSLocalizedString("Please enter a special code to identify yourself.\nFormat:\n4 or more characters, consisting only letters and numbers.\nUsage: When the two codes (your code and your partner's code) match with another pair of codes set by another user, your accounts are matched. Matched users will share their alarm clocks.", comment: "SlidingForm"), defaultValue: nil, textRule: "[A-Za-z0-9]{4,}", errorMsg: "长度至少四位，由字母和数字组成"),
//                SlidingFormPage.getTextarea(withTitle: NSLocalizedString("Partner's Code", comment: "SlidingForm"), isRequired: false, desc: NSLocalizedString("Please ask your partner for his/her Code.", comment: "SlidingForm"), defaultValue: nil, textRule: "[A-Za-z0-9]{4,}", errorMsg: "长度至少四位，由字母和数字组成"),
//                SlidingFormPage.getSelect(withTitle: NSLocalizedString("Your Timezone", comment: "SlidingForm"), desc: nil, selectOptions: options, selectedOptionIndex: 0),
//                SlidingFormPage.getSelect(withTitle: NSLocalizedString("Partner's Timezone", comment: "SlidingForm"), desc: nil, selectOptions: options, selectedOptionIndex: 1),
//                ]) { results in
//                    // some callback
//        }
//        self.present(vc, animated: true, completion: nil)
        
        let vc = SlidingFormViewController.vc(
            withFormTitle: "Settings",
            pages: [
                SlidingFormPage.getInput(withTitle: NSLocalizedString("Nickname", comment: "SlidingForm"), isRequired: true, desc: NSLocalizedString("Please enter your nickname.", comment: "SlidingForm"), defaultValue: NSLocalizedString("Default Nickname", comment: "SlidingForm"), errorMsg: "Cannot be empty!"),
                SlidingFormPage.getRatio(withTitle: "Gender", desc: nil, options: ["Male", "Female", "Other"], selectedOptionIndex: 0) ,
                SlidingFormPage.getTextarea(withTitle: "Self Description", isRequired: true, desc: NSLocalizedString("Describe yourself a little bit here.", comment: "SlidingForm"), defaultValue: nil, errorMsg: "Cannot be empty!"),
                SlidingFormPage.getSelect(withTitle: NSLocalizedString("Year of Birth", comment: "SlidingForm"), desc: nil, selectOptions: ["1994", "1993", "1992", "1991", "1990"], selectedOptionIndex: 2),
                SlidingFormPage.getInput(withTitle: "Four-Digit Code", isRequired: true, desc: NSLocalizedString("Please enter a four-digit code. Letters and numbers only.", comment: "SlidingForm"), defaultValue: nil, textRule: "[A-Za-z0-9]{4}", errorMsg: "The length should be 4. Use letters and numbers only."),
                SlidingFormPage.getCheckbox(withTitle: "Language Skills", desc: nil, options: ["Mandarin", "English", "Japanese", "Franch"], optionsDefaultValue: [true, true, false, false], selectionMin: 1, selectionMax: 4) ,
                SlidingFormPage.getSwitches(withTitle: "Enable Notifications", desc: nil, options: ["Local Notification", "Push Notification"], optionsDefaultValue: [true, true]) ,
                ]) { results in
                    // some callback
                    print(results)
        }
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

