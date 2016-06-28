//
//  WaterCell.m
//  ListDemo
//
//  Created by pan on 16/6/27.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "WaterCell.h"

@implementation WaterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    desLB.font = [UIFont systemFontOfSize:20];
}
- (void)alpUpdateCellWithModel:(WaterModel *)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    desLB.text = model.des;
}
+ (CGFloat)cellHeightWithModel:(WaterModel *)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table
{
    return 44;
}

- (void)alpCellDidSelected:(id)model target:(id)target indexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell selected:%ld",(long)indexPath.item);
}
- (void)userImgViewClicked:(UITapGestureRecognizer *)tap
{
    //假如有额外的点击事件
}


@end
