//
//  inputAccessoryViewController.h
//  inputAccessoryView
//
//  Created by Admin on 04.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextField.h"

@interface inputAccessoryViewController : UIInputViewController

@property (nonatomic, strong) TextField *textField;

@property (nonatomic) BOOL openKeyboard;

@end
