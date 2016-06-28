
//
//  ALPCollectionViewWaterLayout.m
//  Spark
//
//  Created by pan on 16/5/3.
//  Copyright © 2016年 ali. All rights reserved.
//

#import "ALPCollectionViewWaterLayout.h"

NSString *const ALPCollectionViewWaterFlowLayoutHeader = @"ALPCollectionViewWaterFlowLayoutHeader";
NSString *const ALPCollectionViewWaterFlowLayoutFooter = @"ALPCollectionViewWaterFlowLayoutFooter";

@interface  ALPCollectionViewWaterLayout()
//存储每一列最大的y值
@property(nonatomic,strong)NSMutableDictionary *columnMaxY;
//contentSize
@property(nonatomic, assign)CGSize contentSize;
//存放所有的布局属性
@property (nonatomic, strong) NSMutableArray *attributes;

@end

@implementation ALPCollectionViewWaterLayout

- (void)dealloc
{
    _delegate = nil;
    _columnMaxY = nil;
    _attributes = nil;
}
#pragma mark ======  ivar  ======
- (void)setHeaderSize:(CGSize)headerSize
{
    if(!CGSizeEqualToSize(_headerSize, headerSize))
    {
        _headerSize = headerSize;
        
        [self invalidateLayout];
    }
}

- (void)setFooterSize:(CGSize)footerSize
{
    if(!CGSizeEqualToSize(_footerSize, footerSize))
    {
        _footerSize = footerSize;
        
        [self invalidateLayout];
    }
}

- (void)setColumn:(NSUInteger)column
{
    if (_column != column) {
        _column = column;
        [self invalidateLayout];
    }
}

- (void)setColumnPadding:(CGFloat)columnPadding
{
    if (_columnPadding != columnPadding) {
        _columnPadding = columnPadding;
        [self invalidateLayout];
    }
}

- (void)setRowPadding:(CGFloat)rowPadding
{
    if (_rowPadding != rowPadding) {
        _rowPadding = rowPadding;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}


#pragma mark ======  init  ======

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self initialization];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        [self initialization];
    }
    return self;
}
- (void)initialization
{
    _column = 2;
    _columnPadding = .0f;
    _rowPadding = .0f;
    
    _sectionInset = UIEdgeInsetsZero;
    
    _headerSize = CGSizeZero;
    _footerSize = CGSizeZero;
    
    self.columnMaxY = [NSMutableDictionary dictionary];
    self.attributes = [NSMutableArray array];
    _contentSize = CGSizeZero;
}

#pragma mark ======  life  ======

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self setColumnMaxYAll:0.0];
    [_attributes removeAllObjects];
    
    //header
    if (!CGSizeEqualToSize(_headerSize, CGSizeZero)) {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:ALPCollectionViewWaterFlowLayoutHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attribute.frame = CGRectMake(0, 0, _headerSize.width, _headerSize.height);
        [_attributes addObject:attribute];
        [self setColumnMaxYAll:_headerSize.height];
    }
    
    // item
    NSInteger sections = [self.collectionView numberOfSections];
    for (NSInteger s = 0; s < sections; s++) {
        NSUInteger maxColumn = [self maxColumn];
        //CGFloat y = [_columnMaxY shy_floatForKey:@(maxColumn)] + _sectionInset.top;
        CGFloat y = [[_columnMaxY objectForKey:@(maxColumn)] floatValue] + _sectionInset.top;
        //section header
        if (_delegate != nil && [_delegate conformsToProtocol:@protocol(ALPCollectionViewWaterDelegateLayout)] && [_delegate respondsToSelector:@selector(collectionView:layout:heightForHeaderInSection:)]) {
            CGSize size = [_delegate collectionView:self.collectionView layout:self heightForHeaderInSection:s];
            
            if (!CGSizeEqualToSize(size, CGSizeZero)) {
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:s]];
                attribute.frame = CGRectMake(0, y, size.width, size.height);
                [_attributes addObject:attribute];
                [self setColumnMaxYAll:y + size.height];
            }
        }
        
        // item
        NSInteger count = [self.collectionView numberOfItemsInSection:s];
        for (NSInteger i = 0; i < count; i++) {
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:s]];
            [_attributes addObject:attribute];
        }
        
        //section footer
        if (_delegate != nil && [_delegate conformsToProtocol:@protocol(ALPCollectionViewWaterDelegateLayout)] && [_delegate respondsToSelector:@selector(collectionView:layout:heightForFooterInSection:)]) {
            CGSize size = [_delegate collectionView:self.collectionView layout:self heightForFooterInSection:s];
            
            if (!CGSizeEqualToSize(size, CGSizeZero)) {
                NSUInteger maxColumn = [self maxColumn];
                //CGFloat y = [_columnMaxY shy_floatForKey:@(maxColumn)] + _sectionInset.bottom;
                CGFloat y = [[_columnMaxY objectForKey:@(maxColumn)] floatValue] + _sectionInset.bottom;
                UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:s]];
                attribute.frame = CGRectMake(0, y, size.width, size.height);
                [_attributes addObject:attribute];
                [self setColumnMaxYAll:y + size.height];
            }
        }
        
    }
    
    //footer
    NSUInteger maxColumn = [self maxColumn];
    CGFloat height = [[_columnMaxY objectForKey:@(maxColumn)] floatValue] + _sectionInset.bottom;
    
    if (!CGSizeEqualToSize(_footerSize, CGSizeZero)) {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:ALPCollectionViewWaterFlowLayoutFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attribute.frame = CGRectMake(0, height, _footerSize.width, _footerSize.height);
        [_attributes addObject:attribute];
        
        _contentSize = CGSizeMake(self.collectionView.bounds.size.width, height + _footerSize.height);
    }
    else {
        _contentSize = CGSizeMake(self.collectionView.bounds.size.width, height);
    }

    
}
- (CGSize)collectionViewContentSize
{
    return _contentSize;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{

    return _attributes;
    
    if(self.collectionView.dataSource)
    {
        NSMutableArray *tmp_attributes = [NSMutableArray array];
        for(UICollectionViewLayoutAttributes *attributes in _attributes)
        {
            CGRect att_rect = attributes.frame;
            
            if(CGRectIntersectsRect(rect, att_rect))
            {
                [tmp_attributes addObject:attributes];
            }
        }
        return tmp_attributes;
    }
    else
    {
        return nil;
    }
   
}
//单一attribute
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger minColumn = [self minColumn];
    CGFloat width = (self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right - (_column - 1) * _columnPadding) / _column;
    CGFloat height = 0.0;
    if (_delegate != nil && [_delegate conformsToProtocol:@protocol(ALPCollectionViewWaterDelegateLayout)] && [_delegate respondsToSelector:@selector(collectionView:customLayout:width:heightForRowAtIndexPath:)]) {
        height = [_delegate collectionView:self.collectionView customLayout:self width:width heightForRowAtIndexPath:indexPath];
    }
    
    CGFloat x = _sectionInset.left + (width + _columnPadding) * minColumn;
    CGFloat y = [[_columnMaxY objectForKey:[NSNumber numberWithUnsignedInteger:minColumn]] floatValue];
    y = (y == _sectionInset.top) ? y : y + _rowPadding;
    
    [_columnMaxY setObject:@(y + height) forKey:@(minColumn)];
    
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = CGRectMake(x, y, width, height);
    return attribute;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

#pragma mark ======  private  ======

//设置所有列的最大y值
- (void) setColumnMaxYAll:(CGFloat)y
{
    for (NSUInteger i = 0; i < _column; i++) {
        [_columnMaxY setObject:@(y) forKey:@(i)];
    }
}

//最短的那一列
- (NSUInteger) minColumn
{
    __weak typeof(self)weakSelf = self;
    __block NSUInteger minColumn = 0;//0列开始
    [_columnMaxY enumerateKeysAndObjectsUsingBlock:^(NSNumber *column, NSNumber *maxY, BOOL *stop) {//找出最短的那一列
        __strong typeof(self)strongSelf = weakSelf;
        //if ([maxY floatValue] < [strongSelf.columnMaxY shy_floatForKey:[NSNumber numberWithUnsignedInteger:minColumn]])
        if ([maxY floatValue] < [[strongSelf.columnMaxY objectForKey:[NSNumber numberWithUnsignedInteger:minColumn]] floatValue])
        {
            minColumn = [column unsignedIntegerValue];
        }
    }];
    return minColumn;
}

//最长的那一列
- (NSUInteger) maxColumn
{
    __weak typeof(self)weakSelf = self;
    __block NSUInteger maxColumn = 0;
    [_columnMaxY enumerateKeysAndObjectsUsingBlock:^(NSNumber *column, NSNumber *maxY, BOOL *stop) {
        __strong typeof(self)strongSelf = weakSelf;
        //if ([maxY floatValue] > [strongSelf.columnMaxY shy_floatForKey:[NSNumber numberWithUnsignedInteger:maxColumn]])
        if ([maxY floatValue] > [[strongSelf.columnMaxY objectForKey:[NSNumber numberWithUnsignedInteger:maxColumn]] floatValue])
        {
            maxColumn = [column unsignedIntegerValue];
        }
    }];
    return maxColumn;
}

#pragma mark ======  update  ======
- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    // Keep track of insert and delete index paths
    [super prepareForCollectionViewUpdates:updateItems];
    
    self.deleteItems = [NSMutableArray array];
    self.insertItems = [NSMutableArray array];
    
    for (UICollectionViewUpdateItem *update in updateItems)
    {
        if (update.updateAction == UICollectionUpdateActionDelete)
        {
            [self.deleteItems addObject:update.indexPathBeforeUpdate];
        }
        else if (update.updateAction == UICollectionUpdateActionInsert)
        {
            [self.insertItems addObject:update.indexPathAfterUpdate];
        }
    }
}
- (void)finalizeCollectionViewUpdates
{
    [super finalizeCollectionViewUpdates];
    // release the insert and delete index paths
    self.deleteItems = nil;
    self.insertItems = nil;
}
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // Must call super
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    
    if(itemIndexPath.item != 0)//不是首页插入时
    {
        self.insertItems = nil;
    }
    if ([self.insertItems containsObject:itemIndexPath])
    {
        // only change attributes on inserted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        
        //attributes.hidden = YES;
        
        //        attributes.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
        //        attributes.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        
        
    }
    
    return attributes;
}


// Note: name of method changed
// Also this gets called for all visible cells (not just the deleted ones) and
// even gets called when inserting cells!
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    // So far, calling super hasn't been strictly necessary here, but leaving it in
    // for good measure
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    
    if ([self.deleteItems containsObject:itemIndexPath])
    {
        // only change attributes on deleted cells
        if (!attributes)
            attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
        
        // Configure attributes ...
        //attributes.alpha = 0.0;
        [UIView animateWithDuration:1.2 animations:^{
            //attributes.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), M_PI);
        } completion:^(BOOL finished) {
            attributes.alpha = .2f;
        }];
        
    }
    
    return attributes;
}

@end
