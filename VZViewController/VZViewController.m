//
//  VZViewController.m
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "VZViewController.h"

@interface VZViewController ()

@end

@implementation VZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *pan  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 120)];
    pan.backgroundColor = [UIColor redColor];
    
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"navVC"];

    VZPanManager *manager = [VZPanManager new];
    manager.panView = pan;
    manager.offsetY = 70;
    manager.presentingViewController = nav;
    self.vz_panManager = manager;
    
    [self.vz_panManager setupViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
