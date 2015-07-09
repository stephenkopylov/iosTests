//
//  InputAccessoryViewViewController.m
//  InputAccessoryViewTest
//
//  Created by rovaev on 17.04.15.
//  Copyright (c) 2015 rovaev. All rights reserved.
//

#import "InputAccessoryViewViewController.h"
#import "TestModalViewController.h"

@interface InputAccessoryViewViewController ()

@end

@implementation InputAccessoryViewViewController {
    UIView *testAcc;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [test setTitle:@"TEST2" forState:UIControlStateNormal];
    [test setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}


- (void)clicked
{
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[TestModalViewController new]];
    
    [self presentViewController:nav animated:YES completion:^{
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}


- (UIView *)inputAccessoryView
{
    if ( !testAcc ) {
        testAcc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        testAcc.backgroundColor = [UIColor greenColor];
        
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [testAcc addSubview:tv];
    }
    
    return testAcc;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
