//
//  ViewController.m
//  ListDemo
//
//  Created by pan on 16/6/27.
//  Copyright © 2016年 pan. All rights reserved.
//

#import "ViewController.h"

#import "ALPCollectionViewWaterLayout.h"
#import "ALPWaterFlowDelegate.h"
#import "ALPBaseDatasource.h"

#import "UICollectionView+ALPCommon.h"

#import "WaterCell.h"
#import "WaterModel.h"
#import "WaterModel+Request.h"

@interface ViewController ()

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)ALPBaseDataSource *dataSource;
@property (nonatomic,strong)ALPWaterFlowDelegate *delegate;

@end

@implementation ViewController

- (void)initList
{
    NSString *cellReuseId = [NSString stringWithFormat:@"%@Id",[[WaterCell class] description]];
    
    self.dataSource = [[ALPBaseDataSource alloc] init];
    _dataSource.cellBlock = ^id<ALPCellProtocol>(UICollectionView *collectionView,id<ALPModelProtocol> model, NSIndexPath *indexPath) {
        
        id<ALPCellProtocol> cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseId forIndexPath:indexPath];
        [cell alpUpdateCellWithModel:model indexPath:indexPath table:collectionView];
        return cell;
    };
    
    //delegate
    __weak __typeof(self)weakself = self;
    
    self.delegate = [[ALPWaterFlowDelegate alloc] initWithretModelBlock:^CGSize (UICollectionView *collectionView, NSIndexPath *indexPath) {
        __strong __typeof(weakself)strongself = weakself;
        
        WaterModel *model = [strongself.dataSource.dataArray objectAtIndex:indexPath.item];
        CGFloat height = [WaterCell cellHeightWithModel:model indexPath:indexPath table:collectionView];
        return CGSizeMake(0, height);
    } selectedBlock:^(id<ALPCellProtocol>cell, NSIndexPath *indexPath) {
        __strong __typeof(weakself)strongself = weakself;
        
        WaterModel *model = [strongself.dataSource.dataArray objectAtIndex:indexPath.item];
        
        [cell alpCellDidSelected:model target:strongself indexPath:indexPath];
        
    }];
    //layout settings
    ALPCollectionViewWaterLayout *layout= [[ALPCollectionViewWaterLayout alloc] init];
    
    layout.rowPadding = 10;
    layout.columnPadding = 10;
    layout.column = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    layout.delegate = _delegate;
    _collectionView.delegate = _delegate;
    _collectionView.dataSource = _dataSource;
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.frame = self.view.bounds;
    
    [self.view addSubview:_collectionView];
    
    _collectionView.showsVerticalScrollIndicator = NO;
    //register
    
    [_collectionView registerNib:[UINib nibWithNibName:[[WaterCell class] description] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellReuseId];
    
    [_collectionView pullRefresh:^{
       [WaterModel requestFirstPageFinishedBlock:^uint64_t(id objData, NSError *error, BOOL hasMore) {
           __strong __typeof(weakself)strongself = weakself;
           
           [strongself.collectionView endPullRefresh];
           if(!hasMore)
           {
               [strongself.collectionView noticeNoMoreData];
           }
           
           if(!error)
           {
               [strongself.dataSource refreshCollectionView:strongself.collectionView withFirstPage:objData];
               return 0;
           }
           else
           {
               return 0;
               
           }

       }];
    }];
    
    [_collectionView loadMore:^{
       
        [WaterModel requestNextPageFinishedBlock:^(id objData, NSError *error, BOOL hasMore) {
             __strong __typeof(weakself)strongself = weakself;
            
            [strongself.collectionView endPullLoadmore];
            
            if(!error)
            {
                [strongself.dataSource refreshCollectionView:strongself.collectionView withNextPage:objData];
                
                if(!hasMore)
                {
                    [strongself.collectionView noticeNoMoreData];
                }
                [strongself.collectionView resetFooterIdle];
            }
            else
            {
                [strongself.collectionView refreshStatusWhenNextPageHasError:error];
            }
        }];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"UiCollectionView封装简易示例";
    [self initList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView deselectAllItems];
    if(self.dataSource.dataArray.count<=0)
    {
        [self.collectionView beginPullRefresh];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
