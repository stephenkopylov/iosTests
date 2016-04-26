//
//  TestManager.swift
//  SwiftHelloWorld
//
//  Created by Stephen Kopylov - Home on 18/03/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

import Foundation

class TestManager: NSObject {
    static let sharedInstance = TestManager()
    
    func test()
    {
        NSLog("123123");
    }
}
