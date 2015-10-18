//
//  VZPassTouchView.m
//  VZViewController
//
//  Created by Oleg Alekseenko on 18/10/15.
//  Copyright © 2015 alekoleg. All rights reserved.
//

#import "VZPassTouchView.h"

@implementation VZPassTouchView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	UIView *hitView = [super hitTest:point withEvent:event];
	if (hitView != self)
	{
		return hitView;
	}
	return nil;
}

@end
