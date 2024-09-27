//
//  ViewController.h
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/26/24.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

