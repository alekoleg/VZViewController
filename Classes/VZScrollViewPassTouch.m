//
//  VZScrollViewPassTouch.m
//  VZViewController
//
//  Created by Oleg Alekseenko on 20/10/15.
//  Copyright © 2015 alekoleg. All rights reserved.
//

#import "VZScrollViewPassTouch.h"

@implementation VZScrollViewPassTouch

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	UIView *hitView = [super hitTest:point withEvent:event];
	if (self == hitView && !self.scrollEnabled)
	{
		return nil;
	}
	return hitView;
}

@end
