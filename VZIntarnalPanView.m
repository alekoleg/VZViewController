//
//  VZIntarnalPanView.m
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "VZIntarnalPanView.h"

@implementation VZIntarnalPanView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == self || view.superview == self) {
        self.scrollView.scrollEnabled = YES;
        return self.scrollView;
    }
    return view;
}


@end
