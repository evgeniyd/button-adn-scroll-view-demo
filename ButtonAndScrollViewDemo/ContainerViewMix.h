//
//  ContainerViewMix.h
//  ButtonAndScrollViewDemo
//
//  Created by Yevhen Dubinin on 9/27/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContainerViewMix : UIView  <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

- (void)updateData;

@end

NS_ASSUME_NONNULL_END
