//
//  ZZScrollView.h
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZLabel.h"

@protocol ZZScrollViewDelegate
- (void)scrollToItemAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
@end
@interface ZZScrollView : UIScrollView
@property (nonatomic,weak) id ZZScrollviewdelegate;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *labM;

@property (nonatomic,strong) ZZLabel *selectlabel;
@property (nonatomic,strong) UIView *bottomView;

// LABEL背景色
@property (nonatomic,strong) UIColor *LabelBackColor;
@property (nonatomic,strong) UIColor *fontColor;
@property (nonatomic,strong) NSNumber* fontsize;
@property (nonatomic,strong) UIColor *selectFontColor;
@property (nonatomic,strong) UIColor *selectLineColor;


@property (nonatomic,assign) BOOL isNoDisplayingCellEnabled; //didEndDisplayingCell禁止
@property (nonatomic,assign) BOOL clickScroll;

// 设置样式
- (void)setupStyle;
// 创建label方法
- (void)createChanelLabel;
// 点击选中label
- (void)setSelectLabel:(ZZLabel *)lab;

@end
