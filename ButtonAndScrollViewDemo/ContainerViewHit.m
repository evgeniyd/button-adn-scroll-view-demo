//
//  ContainerViewHit.m
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/27/24.
//

#import "ContainerViewHit.h"

@implementation ContainerViewHit {
    UIButton *_closeButton;
    UICollectionView *_collectionView;
    UITapGestureRecognizer *_collectionViewTapGesture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionViewWithParentView:self];
        [self setupCloseButtonWithParentView:self];
    }
    return self;
}

- (void)updateData
{
    [_collectionView reloadData];
}

- (void)setupCollectionViewWithParentView:(UIView *)parentView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 10;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [parentView addSubview:_collectionView];

    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_collectionView.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:0.f],
        [_collectionView.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor constant:0.f],
        [_collectionView.trailingAnchor constraintEqualToAnchor:parentView.trailingAnchor constant:0.f],
        [_collectionView.bottomAnchor constraintEqualToAnchor:parentView.bottomAnchor constant:-50]
    ]];

    _collectionViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewTapped:)];
    [_collectionView addGestureRecognizer:_collectionViewTapGesture];
    [_collectionViewTapGesture fail]
}

- (void)setupCloseButtonWithParentView:(UIView *)parentView {
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    UIImage *xmarkImage = [UIImage systemImageNamed:@"xmark"];
    [_closeButton setImage:xmarkImage forState:UIControlStateNormal];

    _closeButton.frame = CGRectZero;
    _closeButton.tintColor = [UIColor blackColor];
    _closeButton.backgroundColor = [UIColor yellowColor];

    [_closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    [parentView addSubview:_closeButton];

    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [_closeButton.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor constant:0.f],
        [_closeButton.bottomAnchor constraintEqualToAnchor:parentView.bottomAnchor constant:0],
        [_closeButton.heightAnchor constraintEqualToConstant:100],
        [_closeButton.widthAnchor constraintEqualToConstant:100]
    ]];
}

#pragma mark - Actions

- (void)closeButtonTapped {
    NSLog(@"Close button tapped!");

    [_collectionView setContentOffset:CGPointZero animated:YES];
}

- (void)collectionViewTapped:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView: _collectionView];
    CGPoint relativePoint = [self convertPoint:point fromView:_collectionView];
    if (CGRectContainsPoint(_closeButton.frame, relativePoint)) {
        [_closeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - UICollectionView DataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    cell.backgroundColor = [self randomColor];

    cell.layer.cornerRadius = 50;
    cell.layer.masksToBounds = YES;

    return cell;
}

#pragma mark - Helpers

- (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

#pragma mark - Hit Test

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];

    if (hitView == _closeButton && _collectionView.panGestureRecognizer.state == UIGestureRecognizerStatePossible) {
        return _collectionView;
    }

    return hitView;
}

@end
