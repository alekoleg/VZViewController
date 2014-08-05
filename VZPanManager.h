//
//  VZPanManager.h
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VZPanManager : NSObject

@property (nonatomic, strong) UIView *panView;
@property (nonatomic, weak) UIViewController *presentingViewController;
@property (nonatomic, strong) UIViewController *presentedViewController;
@property (nonatomic) CGFloat offsetY;

- (void)setupViews;

@end
