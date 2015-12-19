//
//  ViewController.h
//  ChatTest
//
//  Created by Stephen Kopylov - Home on 19/12/15.
//  Copyright © 2015 Stephen Kopylov - Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZDCChat/ZDCChat.h>


@interface ViewController : ZDUViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL modal;
@property (nonatomic, assign) BOOL nested;


- (UIButton*) buildButtonWithFrame:(CGRect)frame andTitle:(NSString*)title;


@end


