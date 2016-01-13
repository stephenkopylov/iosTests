//
//  ViewController.h
//  segmentControllerTest
//
//  Created by Stephen Kopylov - Home on 13/01/16.
//  Copyright © 2016 Stephen Kopylov - Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NYSegmentedControl.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented2;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented3;
@property (weak, nonatomic) IBOutlet NYSegmentedControl *segmented4;

@end
