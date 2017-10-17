//
//  ZZViewController.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZViewController.h"
#import "ZZScrollView.h"
#import "ZZScrollViewStyle2.h"
#import "ZZScrollViewStyle3.h"
#import "ZZCollectionView.h"
#import "ZZCollectionViewStyle2.h"
#import "ZZCollectionViewStyle3.h"

@interface ZZViewController ()<ZZScrollViewDelegate>
@property (nonatomic,strong) ZZScrollView *scrollview;


@property (nonatomic,strong) ZZCollectionView *collectionView;

@end

@implementation ZZViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self SetupScroll];
    
    [self SetupCollection];
   
   
}

- (void)SetupScroll
{
    // 初始化滚动条
    ZZScrollView *scrollview;
    if ([_style isEqualToString:@"3"]) {
        scrollview = [[ZZScrollViewStyle3 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }else if ([_style isEqualToString:@"2"]){
        scrollview = [[ZZScrollViewStyle2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }else{
        scrollview = [[ZZScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    scrollview.ZZScrollviewdelegate = self;
    self.scrollview = scrollview;
}

- (void)SetupCollection{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 初始化collection
    ZZCollectionView *collectionView;
    if ([_style isEqualToString:@"2"]) {
        collectionView = [[ZZCollectionViewStyle2 alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.view.bounds.size.height - 40) collectionViewLayout:flowlayout];
    }else if ([_style isEqualToString:@"3"]){
        collectionView = [[ZZCollectionViewStyle3 alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.view.bounds.size.height - 40) collectionViewLayout:flowlayout];
    }else{
        collectionView = [[ZZCollectionView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, self.view.bounds.size.height - 40) collectionViewLayout:flowlayout];
        
    }
    
    collectionView.zzscrollview = self.scrollview;
    [self.view addSubview:self.scrollview];
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
}
#pragma mark - ZZScrollviewdelegate
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
