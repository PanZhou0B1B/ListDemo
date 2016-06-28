//
//  ALPBaseDataSource+SPKHeaderFooterView.m
//  Spark
//
//  Created by pan on 16/6/4.
//  Copyright © 2016年 ali. All rights reserved.
//

#import "ALPBaseDataSource+SPKHeaderFooterView.h"

@implementation ALPBaseDataSource (SPKHeaderFooterView)

#pragma mark ======  header footer  ======

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reuseView = nil;
    
    @try {
        if(self.reuserViewBlock)
        {
            reuseView = self.reuserViewBlock(kind,collectionView,indexPath);
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        reuseView = [[UICollectionReusableView alloc] init];
    }
    @finally {
        return reuseView;
    }
}
@end
