//
//  MyStoryViewController.swift
//  Alpface
//
//  Created by swae on 2018/4/6.
//  Copyright © 2018年 alpface. All rights reserved.
//

import UIKit

class MyStoryViewController: UserProfileChildCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func titleForEmptyDataView() -> String? {
        return "空空如也~"
    }

}
