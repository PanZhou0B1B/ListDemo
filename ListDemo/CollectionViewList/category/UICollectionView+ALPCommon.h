//
//  UICollectionView+ALPCommon.h
//  BasePro
//
//  Created by pan on 16/4/25.
//  Copyright © 2016年 pan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^refreshBlock)();

@interface UICollectionView (ALPCommon)

@property (nonatomic,copy)refreshBlock pullRefreshBlock;
@property (nonatomic,copy)refreshBlock loadMoreBlock;

- (void)pullRefresh:(refreshBlock)block;
- (void)loadMore:(refreshBlock)block;

- (void)beginPullRefresh;
- (void)endPullRefresh;
- (void)endPullLoadmore;
- (void)noticeNoMoreData;
- (void)resetNoMoreData;

- (BOOL)isPulling;

- (void)showPull:(BOOL)isShow;
- (void)enableDraging:(BOOL)isDrag;

- (void)endPullPushRefresh;
- (void)resetFooterIdle;
- (void)refreshStatusWhenNextPageHasError:(NSError *)error;

- (void)deselectAllItems;
@end
