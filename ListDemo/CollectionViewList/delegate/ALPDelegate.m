//
//  ALPDelegate.m
//  BasePro
//
//  Created by pan on 16/4/25.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "ALPDelegate.h"

@interface ALPDelegate ()

@property (nonatomic,copy)CellDidSelected selectedBlock;
@property (nonatomic,copy)RetModelBlock retModelBlock;

@end
@implementation ALPDelegate

#pragma mark ======  init  ======
- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}
- (instancetype)initWithretModelBlock:(RetModelBlock)retBlock selectedBlock:(CellDidSelected)block
{
    self = [self init];
    
    if(self)
    {
        self.retModelBlock = retBlock;
        self.selectedBlock = block;
        
    }
    return self;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    id<ALPCellProtocol>cell = (id<ALPCellProtocol>)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(_selectedBlock)
    {
        _selectedBlock(cell,indexPath);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if(_retModelBlock)
    {
        size = _retModelBlock(collectionView,indexPath);
    }
    
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_cellWillDisplayBlock)
    {
        _cellWillDisplayBlock((id<ALPCellProtocol>)cell,indexPath);
    }
}

#pragma mark ======  header,footer  ======
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if(_reuseViewWillDisplay)
    {
        _reuseViewWillDisplay((id<ALPReuseViewProtocol>)view,indexPath,elementKind);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeZero;
    if(_retModelHeaderBlock)
    {
        size = _retModelHeaderBlock(collectionView,section);
    }
    
    return size;
    
}
@end
