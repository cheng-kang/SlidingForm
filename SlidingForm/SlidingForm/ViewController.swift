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
        
        
        let vc = SlidingFormViewController.vc(withStoryboardName: "Main",
                                              bundle: nil,
                                              identifier: "SlidingFormViewController",
                                              andFormTitle: "设置",
                                              contents: [["昵称","你的昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称昵称",true], ["密码","一个密码",false], ["时区","",false]],
                                              currentPageIndex: 0,
                                              customFontName: "FZYanSongS-R-GB")
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

