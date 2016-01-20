//
//  PlotView.h
//  OpenGlC++Test
//
//  Created by Stephen Kopylov - Home on 16/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "PlotPoint.h"

@interface PlotViewController : GLKViewController

- (void)addPoint:(PlotPoint *)point;
- (void)addPoints:(NSArray *)points;

@end
