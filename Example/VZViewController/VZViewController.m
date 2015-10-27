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

	VZPanViewController *panVC = [[VZPanViewController alloc] initWithPannigController:nav];
    panVC.panView = pan;
    panVC.panViewOffsetY = 70;
	panVC.panBackgroundColor = [UIColor yellowColor];

    
	[self addChildViewController:panVC];
	[self.view addSubview:panVC.view];
	panVC.view.frame = self.view.bounds;
	panVC.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[panVC setShow:YES animated:YES];

		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[panVC setShow:NO animated:YES];

		});
	});
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
