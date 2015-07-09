//
//  TableViewController.h
//  MessageComposerView-test
//
//  Created by rovaev on 30.06.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageComposerView.h"

@interface TableViewController : UITableViewController<MessageComposerViewDelegate>

@property (nonatomic, strong) MessageComposerView *messageComposerView;

@end
