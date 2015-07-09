//
//  DetailViewController.h
//  CoreDataCryptoTest
//
//  Created by rovaev on 14.04.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

