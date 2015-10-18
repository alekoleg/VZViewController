//
//  VZPanManager.h
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

@import UIKit;

@interface VZPanViewController : UIViewController

- (instancetype)initWithPannigController:(UIViewController *)viewController;

@property (nonatomic, strong) UIView *panView;
@property (nonatomic, strong, readonly) UIViewController *panningViewController;
@property (nonatomic) CGFloat panViewOffsetY;

@end
