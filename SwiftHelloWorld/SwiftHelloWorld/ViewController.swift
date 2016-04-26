//
//  ViewController.swift
//  SwiftHelloWorld
//
//  Created by Stephen Kopylov - Home on 18/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSLog("test%@", "123123");
        TestManager.sharedInstance.test();
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
    }
}
