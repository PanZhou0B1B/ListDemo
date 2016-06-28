//
//  ALPCollectionViewWaterLayout.h
//  Spark
//
//  Created by pan on 16/5/3.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <UIKit/UIKit.h>

//参考SHYCollectionViewWaterFlowLayout
//优化点：返回attribute时，只返回rect中的
//insert、delete效果标记
#import <UIKit/UIKit.h>

extern NSString *const ALPCollectionViewWaterFlowLayoutHeader;//header KEY
extern NSString *const ALPCollectionViewWaterFlowLayoutFooter;//footer KEY


@class ALPCollectionViewWaterLayout;

@protocol ALPCollectionViewWaterDelegateLayout <UICollectionViewDelegate>

@required

/*!
 @method collectionViewWaterFlowLayout:heightForRowAtIndexPath:forWidth:
 @abstract 获取这个cell的高
 @param collectionViewWaterFlowLayout SHYCollectionViewWaterFlowLayout的对象
 @param indexPath NSIndexPath
 @param width 这个cell的宽 (width 是算出来的)
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView customLayout:(ALPCollectionViewWaterLayout *)layout width:(CGFloat)width heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/*!
 @method collectionView:layout:heightForHeaderInSection:
 @abstract 获取 section 头部控件的宽高
 @param collectionView collectionView
 @param collectionViewLayout layout
 @param section section
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ALPCollectionViewWaterLayout *)layout heightForHeaderInSection:(NSInteger)section;

/*!
 @method collectionView:layout:heightForFooterInSection:
 @abstract 获取 section 底部控件的宽高
 @param collectionView collectionView
 @param collectionViewLayout layout
 @param section section
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ALPCollectionViewWaterLayout *)layout heightForFooterInSection:(NSInteger)section;


@end


@interface ALPCollectionViewWaterLayout : UICollectionViewLayout

/*!
 @property column
 @abstract 列数；默认为2
 */
@property (nonatomic, assign) NSUInteger column;
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

@property (nonatomic,strong)NSMutableArray *insertItems;
@property (nonatomic,strong)NSMutableArray *deleteItems;
/*!
 @property delegate
 @abstract 代理
 */
@property (nonatomic, weak) id<ALPCollectionViewWaterDelegateLayout> delegate;

@end
