//
//  ZZLabel.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/9/7.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZLabel.h"

@implementation ZZLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
            }
    return self;
}
- (void)setCurrentTransformSx:(CGFloat)currentTransformSx {
    _currentTransformSx = currentTransformSx;
    self.transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx);
}


@end
