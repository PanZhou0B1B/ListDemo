//
//  UICollectionView+ALPCommon.m
//  BasePro
//
//  Created by pan on 16/4/25.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "UICollectionView+ALPCommon.h"
#import "MJRefresh.h"


#import <objc/runtime.h>
@implementation UICollectionView (ALPCommon)

- (refreshBlock)pullRefreshBlock
{
    return objc_getAssociatedObject(self, @selector(pullRefreshBlock));
}
- (refreshBlock)loadMoreBlock
{
    return objc_getAssociatedObject(self, @selector(loadMoreBlock));
}
- (void)setPullRefreshBlock:(refreshBlock)pullRefreshBlock
{
    objc_setAssociatedObject(self, @selector(pullRefreshBlock), pullRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setLoadMoreBlock:(refreshBlock)loadMoreBlock
{
    objc_setAssociatedObject(self, @selector(loadMoreBlock), loadMoreBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)pullRefresh:(refreshBlock)block
{
    self.pullRefreshBlock = block;
    if(block)
    {
        if(self.mj_header)
        {
            return;
        }
        __weak __typeof(self) weakSelf = self;
        self.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            
            __strong __typeof(weakSelf)strongself = weakSelf;
            
            [strongself resetNoMoreData];
            strongself.pullRefreshBlock();
        }];
        self.mj_header.ignoredScrollViewContentInsetTop = 0;
    }
    else
    {
        self.mj_header = nil;
    }
    
}
- (void)loadMore:(refreshBlock)block
{
    self.loadMoreBlock = block;
    
    if(block)
    {
        if(self.mj_footer)
        {
            return;
        }
        __weak __typeof(self) weakSelf = self;
        
        self.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            
            strongSelf.loadMoreBlock();
        }];
        self.mj_footer.automaticallyHidden = YES;
    }
    else
    {
        self.mj_footer = nil;
    }
}
- (void)beginPullRefresh
{
    [self.mj_header beginRefreshing];
}
- (void)endPullRefresh
{
    [self.mj_header endRefreshing];
}
- (void)endPullLoadmore
{
    [self.mj_footer endRefreshing];
}
- (void)noticeNoMoreData
{
    if(self.loadMoreBlock)
    {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}
- (void)resetNoMoreData
{
    [self.mj_footer resetNoMoreData];
}

- (void)endPullPushRefresh
{
    if(self.pullRefreshBlock)
    {
        [self endPullRefresh];
    }
    if(self.loadMoreBlock)
    {
        [self endPullLoadmore];
    }
}
- (void)resetFooterIdle
{
    //[self.mj_footer setTitle:@"奋力加载中..." forState:MJRefreshStateIdle];
}
- (void)refreshStatusWhenNextPageHasError:(NSError *)error
{
    [self endPullPushRefresh];
    
    if(self.loadMoreBlock)
    {
        //[self.mj_footer setTitle:@"加载失败,请重试～" forState:MJRefreshStateIdle];
    }
}
- (BOOL)isPulling
{
    return [self.mj_header isRefreshing];
}
- (void)showPull:(BOOL)isShow
{
   //self.mj_header.permitHidden = !isShow;
}

- (void)enableDraging:(BOOL)isDrag
{
    //[self.mj_header setDragging:isDrag];
}
- (void)deselectAllItems
{
    NSArray *selects =[self indexPathsForSelectedItems];
    if(selects && selects.count>0)
    {
        [self deselectItemAtIndexPath:selects[0] animated:YES];
    }
}
@end
