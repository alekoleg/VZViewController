//
//  VZPanManager.m
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "VZPanManager.h"
#import "VZIntarnalPanView.h"


@interface VZPanManager () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) VZIntarnalPanView *internalPanView;

@end


@implementation VZPanManager

- (void)setupViews {
    if (self.presentedViewController && self.presentingViewController) {
        [self setupScrollView];
        [self setupPanView];
        [self setupViewControllers];
    }
}

#pragma mark - Setup -

- (void)setupScrollView {
    if (!self.scrollView && self.presentedViewController) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.presentedViewController.view.bounds];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.pagingEnabled = YES;
        [self.presentedViewController.view addSubview:self.scrollView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.contentSize.height);
    [self.presentedViewController.view bringSubviewToFront:self.scrollView];
}

- (void)setupPanView {
    if (!self.internalPanView && self.panView) {
        self.internalPanView = [[VZIntarnalPanView alloc] initWithFrame:self.panView.bounds];
        self.internalPanView.frame = ({
            CGRect frame = self.internalPanView.frame;
            frame.origin.x = self.presentedViewController.view.frame.size.width - frame.size.width;
            frame.origin.y = self.offsetY;
            frame;
        });
        self.internalPanView.scrollView = self.scrollView;
        [self.internalPanView  addSubview:self.panView];
        [self.scrollView addSubview:self.internalPanView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedPan:)];
        [self.internalPanView addGestureRecognizer:tap];
     }
    
}

- (void)setupViewControllers {
    if (![self.presentedViewController.childViewControllers containsObject:self.presentingViewController]) {
        [self.presentedViewController addChildViewController:self.presentingViewController];
        
        self.presentingViewController.view.frame = ({
            CGRect frame = self.presentingViewController.view.frame;
            frame.size.width = [self maxWidth];
            frame.origin.x = self.presentedViewController.view.frame.size.width + (_presentingViewController.view.frame.size.width - frame.size.width) / 2;
            frame;
        });
        
        [self.scrollView addSubview:self.presentingViewController.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.scrollEnabled = scrollView.contentOffset.x > 0;
    [self updateBackColorAlpha];
}


#pragma mark - Asctions -

- (void)updateBackColorAlpha {
    float persent = self.scrollView.contentOffset.x / _scrollView.frame.size.width + 2 * (self.scrollView.contentOffset.x > _scrollView.frame.size.width) * (1 - _scrollView.contentOffset.x / _scrollView.frame.size.width);
    persent = MIN(0.8, persent);
    persent = MAX(0, persent);
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:persent];
}

- (void)tapedPan:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateRecognized) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:YES];
    }
}

#pragma mark - VZPanInternalDelegate -

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"moved");
//    self.scrollView.scrollEnabled = YES;
//    [self.scrollView touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"began");
//    self.scrollView.scrollEnabled = YES;
//    [self.scrollView touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"ended");
//    [self.scrollView touchesEnded:touches withEvent:event];
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self.scrollView touchesCancelled:touches withEvent:event];
//}


#pragma mark - Helpers -

- (CGFloat)maxWidth {
    return 300;
}



@end
