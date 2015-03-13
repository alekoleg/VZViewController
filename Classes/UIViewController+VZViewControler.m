//
//  UIViewController+VZViewControler.m
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "UIViewController+VZViewControler.h"
#import <objc/runtime.h>

@implementation UIViewController (VZViewControler)

#pragma mark - Variables -

- (void)setVz_panManager:(VZPanManager *)vz_panManager {
    vz_panManager.presentedViewController = self;
    objc_setAssociatedObject(self, @selector(vz_panManager), vz_panManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VZPanManager *)vz_panManager {
    return objc_getAssociatedObject(self, @selector(vz_panManager));
}
@end
