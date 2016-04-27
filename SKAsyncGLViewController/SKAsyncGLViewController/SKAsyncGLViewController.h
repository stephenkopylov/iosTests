//
//  SKAsyncGLViewController.h
//  SKAsyncGLViewController
//
//  Created by Stephen Kopylov - Home on 27/04/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKAsyncGLView.h"

@class SKAsyncGLViewController;

@protocol SKAsyncGLViewControllerDelegate <NSObject>

- (void)createBuffers:(SKAsyncGLViewController *)viewController;

@end

@interface SKAsyncGLViewController : UIViewController

@property (strong, nonatomic) SKAsyncGLView *view;
@property (nonatomic, weak) id<SKAsyncGLViewControllerDelegate> delegate;

@end