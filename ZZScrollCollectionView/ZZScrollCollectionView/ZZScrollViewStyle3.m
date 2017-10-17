//
//  ZZScrollViewStyle3.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/9/25.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZScrollViewStyle3.h"

@implementation ZZScrollViewStyle3

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupStyle{
    [super setupStyle];
    self.selectFontColor = [UIColor colorWithRed:0.5 green:0.1 blue:0 alpha:1.0];

    
}

- (void)createChanelLabel
{
    [super createChanelLabel];
    self.bottomView.hidden = YES;

    
}


// 点击选中label
- (void)setSelectLabel:(ZZLabel *)lab{
    if (self.selectlabel) {
        self.selectlabel.textColor = self.fontColor;
        lab.currentTransformSx = CURRENT_TRANSFORM_SX;
    }
    self.selectlabel.currentTransformSx = 1.0;
    self.selectlabel = lab;
    self.selectlabel.textColor = self.selectFontColor;
    lab.currentTransformSx = CURRENT_TRANSFORM_SX;

}
@end
