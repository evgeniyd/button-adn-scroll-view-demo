//
//  ViewController.m
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/26/24.
//

#import "ViewController.h"
#import "ContainerView.h"

@interface ViewController ()

@end

@implementation ViewController {
    ContainerView *_containerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];

    _containerView = [[ContainerView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_containerView];
    [_containerView setBackgroundColor:[UIColor orangeColor]];

    _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_containerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0.f],
        [_containerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0.f],
        [_containerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0.f],
        [_containerView.heightAnchor constraintEqualToConstant:150.f]
    ]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [_containerView updateData];
}

@end
