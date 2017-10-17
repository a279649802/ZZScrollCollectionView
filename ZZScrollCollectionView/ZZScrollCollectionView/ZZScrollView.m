//
//  ZZScrollView.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZScrollView.h"
@interface ZZScrollView()
@property (nonatomic,strong) UILabel *label;
@end

@implementation ZZScrollView

- (UIView *)bottomView{
    if (_bottomView==nil) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}
-(NSMutableArray *)labM
{
    if (_labM == nil) {
        _labM = [NSMutableArray array];
    }
    return _labM;
}

- (NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr =  @[@"adsd",@"dasdasd",@"adsd",@"dasdasd",@"adsd",@"dasdasd",@"adsd",@"dasdasd"];

    }
    return _dataArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        [self setupStyle];
        [self createChanelLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(0, 0, 100, 40);

}

- (void)create
{
    
}


- (void)setupStyle
{
    self.LabelBackColor = LABEL_BACK_COLOR;
    self.fontColor = FONT_COLOR;
    self.fontsize = FONT_SIZE;
    self.selectFontColor = SELECT_FONT_COLOR;
    self.selectLineColor = SELECT_LINE_COLOR;
    self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
}
- (void)createChanelLabel
{
    CGFloat totalWith = 0;
    int LabH = self.bounds.size.height;
    
    for (int i = 0;i < self.dataArr.count ; i ++) {
        
        
        ZZLabel *lab = [[ZZLabel alloc]init];
        lab.backgroundColor = self.LabelBackColor;
        lab.textColor = self.fontColor;
        lab.font = [UIFont systemFontOfSize:[self.fontsize floatValue]];
        
        // 适配字体
        lab.adjustsFontSizeToFitWidth = YES;
        
        NSString *str = self.dataArr[i];
        NSInteger size = [self.fontsize integerValue] + 5;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
        CGSize size2 = CGSizeMake(200, MAXFLOAT);//给出一个限制size，设定宽度200，高度可变
        CGRect rect2 = [str boundingRectWithSize:size2
                                         options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs
                                         context:nil];
        CGFloat currentWith = rect2.size.width;
        if (currentWith <=40) {
            currentWith =40;
        }
        //给lab设置frame
        lab.frame = CGRectMake(totalWith, 0, currentWith, LabH);
        totalWith = totalWith+ currentWith;
        
        //给lab赋值
        lab.text = self.dataArr[i];
        //给lab设置tag
        lab.tag = i;
        [self addSubview:lab];

        
        if (i == 0) {
            self.bottomView.frame = CGRectMake(lab.frame.origin.x, lab.frame.size.height -2, lab.frame.size.width, 2);
            self.bottomView.backgroundColor = self.selectLineColor;
            [self addSubview:self.bottomView];
            // 设置默认选中的label
            [self setSelectLabel:lab];
        }
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [lab addGestureRecognizer:tap];
        //设置lab可以点击
        lab.userInteractionEnabled = YES;
        //把lab添加到频道数组里面
        [self.labM addObject:lab];
    }
    [self bringSubviewToFront:self.bottomView];
    //设置ChannelScrollView滚动
    self.contentSize = CGSizeMake(totalWith, 0);
    
}

// 点击选中label
- (void)setSelectLabel:(ZZLabel *)lab{
    if (self.selectlabel) {
        self.selectlabel.textColor = self.fontColor;
//        self.selectlabel.font = [UIFont systemFontOfSize:[self.fontsize floatValue]];
    }
    self.selectlabel = lab;
    self.selectlabel.textColor = self.selectFontColor;
//    self.selectlabel.font = [UIFont boldSystemFontOfSize:[self.fontsize floatValue] +1];
    
    // 设置下面的滚动条
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(self.selectlabel.frame.origin.x, self.selectlabel.frame.size.height -2, self.selectlabel.frame.size.width, 2);

    }];
    [self bringSubviewToFront:self.bottomView];

}
//点击频道的方法
-(void)tapClick:(UIGestureRecognizer *)tap
{
    //获取选中的lab
    ZZLabel *lab = (ZZLabel *)tap.view;
    [self setSelectLabel:lab];
   
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labOffsetX = lab.center.x - self.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.contentSize.width - self.bounds.size.width;
    
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if(labOffsetX > maxOffsetX)
    {
        labOffsetX = maxOffsetX;
    }
    
       // 设置频道滚动视图的滚动
    [self setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];
    
#pragma mark - 点击频道标签居中时,collectionView也跟着联动
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
//     点击了scroll 事件,开始做上下联动
    self.clickScroll = YES;
#pragma mark 如果是tap点击事件把collectionview代理collection didEndDisplayingCell去除
    self.isNoDisplayingCellEnabled = YES;
    
    if ([self.ZZScrollviewdelegate respondsToSelector:@selector(scrollToItemAtIndexPath:atScrollPosition:animated:)]) {
        [self.ZZScrollviewdelegate scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];

    }
    
    
}





@end
