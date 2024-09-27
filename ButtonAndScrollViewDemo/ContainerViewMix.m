//
//  ContainerViewMix.m
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/27/24.
//

#import "ContainerViewMix.h"

@implementation ContainerViewMix {
    UIButton *_closeButton;
    UICollectionView *_collectionView;
    UIPanGestureRecognizer *_panGesture;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCollectionViewWithParentView:self];
        // Note: parent is self
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
}

- (void)setupCloseButtonWithParentView:(UIView *)parentView {
    // Note: Layout view is self
    UIView *layoutView = self;

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
        [_closeButton.centerXAnchor constraintEqualToAnchor:layoutView.centerXAnchor constant:0.f],
        [_closeButton.bottomAnchor constraintEqualToAnchor:layoutView.bottomAnchor constant:0],
        [_closeButton.heightAnchor constraintEqualToConstant:100],
        [_closeButton.widthAnchor constraintEqualToConstant:100]
    ]];

    _panGesture = [[UIPanGestureRecognizer alloc] init];
    _panGesture.delegate = self;
    [_closeButton addGestureRecognizer:_panGesture];
}

#pragma mark - Actions

- (void)closeButtonTapped {
    NSLog(@"Close button tapped!");

    [_collectionView setContentOffset:CGPointZero animated:YES];
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

#pragma mark - Gesture Recognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (otherGestureRecognizer == _collectionView.panGestureRecognizer) {
        return YES;
    }

    return NO;
}

#pragma mark - Helpers

- (UIColor *)randomColor {
    CGFloat red = arc4random_uniform(256) / 255.0;
    CGFloat green = arc4random_uniform(256) / 255.0;
    CGFloat blue = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
