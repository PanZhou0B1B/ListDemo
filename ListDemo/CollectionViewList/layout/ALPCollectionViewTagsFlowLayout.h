//
//  ALPCollectionViewTagsFlowLayout.h
//  Spark
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ALPCollectionViewTagsFlowLayoutHeader;//header KEY
extern NSString *const ALPCollectionViewTagsFlowLayoutFooter;//footer KEY

@class ALPCollectionViewTagsFlowLayout;

@protocol ALPCollectionViewTagsDelegateLayout <UICollectionViewDelegate>

@required
//height需要固定
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForHeaderInSection:(NSInteger)section;

/*!
 @method collectionView:layout:heightForFooterInSection:
 @abstract 获取 section 底部控件的宽高
 @param collectionView collectionView
 @param collectionViewLayout layout
 @param section section
 */
- (CGSize)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewTagsFlowLayout *)layout sizeForFooterInSection:(NSInteger)section;


@end


@interface ALPCollectionViewTagsFlowLayout : UICollectionViewLayout


//contentSize
@property(nonatomic, assign)CGSize contentSize;
/*!
 @property columnPadding
 @abstract 列之间的间距；默认为0
 */
@property (nonatomic, assign) CGFloat columnPadding;
/*!
 @property rowPadding
 @abstract 行之间的间距；默认为0
 */
@property (nonatomic, assign) CGFloat rowPadding;

/*!
 @property sectionInset
 @abstract section 内 四周边界的间距；默认为UIEdgeInsetsZero
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@property (nonatomic, assign) CGSize headerSize;
@property (nonatomic, assign) CGSize footerSize;

@property (nonatomic, weak) id<ALPCollectionViewTagsDelegateLayout> delegate;

@end
