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
    UIButton *_closeButton;
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

    [self setupCollectionViewWithParentView:_containerView];
    [self setupCloseButtonWithParentView:_containerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.collectionView reloadData];
}

- (void)setupCollectionViewWithParentView:(UIView *)parentView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumLineSpacing = 10;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [parentView addSubview:self.collectionView];

    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:parentView.topAnchor constant:0.f],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:parentView.leadingAnchor constant:0.f],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:parentView.trailingAnchor constant:0.f],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:parentView.bottomAnchor constant:-50]
    ]];
}

- (void)setupCloseButtonWithParentView:(UIView *)parentView {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];

    // Set the SF Symbol "xmark" as the image for the button
    UIImage *xmarkImage = [UIImage systemImageNamed:@"xmark"];
    [closeButton setImage:xmarkImage forState:UIControlStateNormal];

    // Set button frame and position (adjust as needed)
    closeButton.frame = CGRectZero;
    closeButton.tintColor = [UIColor blackColor]; // Set the tint color (this will color the SF Symbol)
    closeButton.backgroundColor = [UIColor yellowColor];

    // Add target for the button action (tap)
    [closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];

    // Add the button to the view
    [parentView addSubview:closeButton];

    closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [closeButton.centerXAnchor constraintEqualToAnchor:parentView.centerXAnchor constant:0.f],
        [closeButton.bottomAnchor constraintEqualToAnchor:parentView.bottomAnchor constant:0],
        [closeButton.heightAnchor constraintEqualToConstant:100],
        [closeButton.widthAnchor constraintEqualToConstant:100]
    ]];
}


#pragma mark - Actions

- (void)closeButtonTapped {
    NSLog(@"Close button tapped!");

    [self.collectionView setContentOffset:CGPointZero animated:YES];
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

@end
