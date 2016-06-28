//
//  ALPBaseCollectionViewCell.m
//  BasePro
//
//  Created by pan on 16/4/20.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "ALPBaseCollectionViewCell.h"


@implementation ALPBaseCollectionViewCell

+ (CGFloat)cellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    return .0f;
}
+ (CGFloat)cellWidthWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    return .0f;
}
- (void)alpUpdateCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{

}

- (CGFloat)getItemWidth
{
    return .0f;
}
- (void)alpCellDidSelected:(id)model target:(id)target indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected");
}
@end
