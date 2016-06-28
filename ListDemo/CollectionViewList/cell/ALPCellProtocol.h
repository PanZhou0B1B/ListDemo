//
//  ALPCellProtocol.h
//  Spark
//
//  Created by pan on 16/5/9.
//  Copyright © 2016年 ali. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@protocol ALPCellProtocol <NSObject>

//ui
+ (CGFloat)cellHeightWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table;
- (void)alpUpdateCellWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table;

+ (CGFloat)cellWidthWithModel:(id)model indexPath:(NSIndexPath *)indexPath table:(UICollectionView *)table;

- (CGFloat)getItemWidth;
//event
- (void)alpCellDidSelected:(id)model target:(id)target indexPath:(NSIndexPath *)indexPath;

@end
