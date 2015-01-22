//
//  NotWindow.m
//  RotatingWindowTest
//
//  Created by Admin on 22.01.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "NotWindow.h"


@implementation NotWindow

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"initWithFrame");
    self.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0];
    return [super initWithFrame:frame];
    
}

@end
