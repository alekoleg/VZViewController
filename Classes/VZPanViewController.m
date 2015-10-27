//
//  VZPanManager.m
//  VZViewController
//
//  Created by Alekseenko Oleg on 05.08.14.
//  Copyright (c) 2014 alekoleg. All rights reserved.
//

#import "VZPanViewController.h"
#import "VZIntarnalPanView.h"
#import "VZPassTouchView.h"
#import "VZScrollViewPassTouch.h"


@interface VZPanViewController () <UIScrollViewDelegate> {
    BOOL _canReEnablePan;
}

@property (nonatomic, assign) BOOL panningVCVisible;
@property (nonatomic, strong) VZScrollViewPassTouch *scrollView;
@property (nonatomic, strong) VZIntarnalPanView *internalPanView;

@end


@implementation VZPanViewController

- (instancetype)initWithPannigController:(UIViewController *)viewController
{
	if (self = [super init])
	{
		_panningViewController = viewController;
	}
	return self;
}

- (void)loadView
{
	self.view = [[VZPassTouchView alloc] init];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setupScrollView];
	[self setupPanView];
	[self setupPanningViewController];	
}

#pragma mark - Setup -

- (void)setupScrollView {
    if (!self.scrollView) {
        self.scrollView = [[VZScrollViewPassTouch alloc] initWithFrame:self.view.bounds];
        self.scrollView.backgroundColor = [UIColor clearColor];
		self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = NO;
        self.scrollView.pagingEnabled = YES;
        [self.view addSubview:self.scrollView];
    }
}

- (void)setupPanView {
    if (!self.internalPanView) {
        self.internalPanView = [[VZIntarnalPanView alloc] init];
        self.internalPanView.scrollView = self.scrollView;
        [self.internalPanView  addSubview:self.panView];
        [self.scrollView addSubview:self.internalPanView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedPan:)];
        [self.internalPanView addGestureRecognizer:tap];
     }
    
}

- (void)setupPanningViewController {

	[self addChildViewController:self.panningViewController];
	[self.scrollView addSubview:self.panningViewController.view];
}

- (void)setPanView:(UIView *)panView
{
	_panView = panView;
	[self.internalPanView addSubview:panView];
	[self.view setNeedsLayout];
}

- (void)setPanViewOffsetY:(CGFloat)panViewOffsetY
{
	_panViewOffsetY = panViewOffsetY;
	[self.view setNeedsLayout];
}

- (void)setPanBackgroundColor:(UIColor *)panBackgroundColor
{
	_panBackgroundColor = panBackgroundColor;
	self.internalPanView.backgroundColor = panBackgroundColor;
}

#pragma mark - UIScrollViewDelegate -

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.scrollEnabled = scrollView.contentOffset.x > 0;
	self.panningVCVisible = scrollView.contentOffset.x >= scrollView.frame.size.width / 2.0;
    [self updateBackColorAlpha];
    [self updateReEnable];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _canReEnablePan = !decelerate;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _canReEnablePan = YES;
    [self updateReEnable];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _canReEnablePan = NO;
}

#pragma mark - Actions -

- (void)setShow:(BOOL)show animated:(BOOL)animated
{
	CGFloat x = show ? self.scrollView.frame.size.width : 0.0;
	[self.scrollView setContentOffset:CGPointMake(x, 0.0) animated:animated];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];

	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 3, self.scrollView.contentSize.height);

	self.panningViewController.view.frame = ({
		CGRect frame = self.panningViewController.view.frame;
		frame.size.width = [self maxWidth];
		frame.origin.x = self.scrollView.frame.size.width + (self.scrollView.frame.size.width - frame.size.width) / 2.0;
		frame.origin.y = 0.0;
		frame.size.height = self.scrollView.frame.size.height;
		frame;
	});

	self.panView.frame = ({
		CGRect frame = self.panView.frame;
		frame.origin = CGPointZero;
		frame;
	});

	self.internalPanView.frame = ({
		CGRect frame = self.internalPanView.frame;
		frame.origin.x = self.scrollView.frame.size.width - self.panView.frame.size.width;
		frame.origin.y = self.panViewOffsetY;
		frame.size.height = self.panView.frame.size.height;
		CGFloat additionWidth = (self.scrollView.frame.size.width - [self maxWidth]) / 2.0;
		frame.size.width = self.panView.frame.size.width + additionWidth;
		frame;
	});

	CGFloat offsetX = (self.panningVCVisible) ? self.scrollView.frame.size.width : 0.0;
	self.scrollView.contentOffset = CGPointMake(offsetX, 0.0);
}

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

- (void)updateReEnable {
    if (self.scrollView.contentOffset.x >= self.scrollView.frame.size.width * 2 && _canReEnablePan) {
        _canReEnablePan = NO;
        [self reEnable];
    }
}

- (void)reEnable {
    self.scrollView.alpha = 0.0;
    self.scrollView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.scrollView.alpha = 1.0;
    } completion:NULL];
}

#pragma mark - Helpers -

- (CGFloat)maxWidth {
    return self.view.frame.size.width * 0.9;
}



@end
