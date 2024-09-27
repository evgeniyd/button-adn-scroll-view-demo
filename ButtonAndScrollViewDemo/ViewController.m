//
//  ViewController.m
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/26/24.
//

#import "ViewController.h"

#import "ContainerViewHit.h"
#import "ContainerViewGesture.h"
#import "ContainerViewMix.h"

@interface ViewController ()

@end

@implementation ViewController {
    ContainerViewHit *_hitContainerView;
    ContainerViewGesture *_gestureContainerView;
    ContainerViewMix *_mixContainerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];

    // Hit Test View Example

    _hitContainerView = [[ContainerViewHit alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_hitContainerView];
    [_hitContainerView setBackgroundColor:[UIColor orangeColor]];

    _hitContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_hitContainerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:0.f],
        [_hitContainerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0.f],
        [_hitContainerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0.f],
        [_hitContainerView.heightAnchor constraintEqualToConstant:150.f]
    ]];

    // Gesture View Example

    _gestureContainerView = [[ContainerViewGesture alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_gestureContainerView];
    [_gestureContainerView setBackgroundColor:[UIColor magentaColor]];

    _gestureContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_gestureContainerView.topAnchor constraintEqualToAnchor:_hitContainerView.bottomAnchor constant:20.f],
        [_gestureContainerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0.f],
        [_gestureContainerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0.f],
        [_gestureContainerView.heightAnchor constraintEqualToConstant:150.f]
    ]];

    // Mixed View Example
    _mixContainerView = [[ContainerViewMix alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_mixContainerView];
    [_mixContainerView setBackgroundColor:[UIColor magentaColor]];

    _mixContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_mixContainerView.topAnchor constraintEqualToAnchor:_gestureContainerView.bottomAnchor constant:20.f],
        [_mixContainerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:0.f],
        [_mixContainerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:0.f],
        [_mixContainerView.heightAnchor constraintEqualToConstant:150.f]
    ]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [_hitContainerView updateData];
    [_gestureContainerView updateData];
    [_mixContainerView updateData];
}

@end
