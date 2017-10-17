//
//  ZZCollectionViewStyle2.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/9/25.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZCollectionViewStyle2.h"

@interface ZZCollectionViewStyle2()
// 字体颜色大小设置
@property (strong, nonatomic) NSArray *deltaRGBA;
@property (strong, nonatomic) NSArray *selectedColorRGBA;
@property (strong, nonatomic) NSArray *normalColorRGBA;

@end

@implementation ZZCollectionViewStyle2



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > SCREEN_WIDTH*(self.zzscrollview.labM.count-1)) {
        return;
    }
    
    
    
    if (self.lastContentOffset >= scrollView.contentOffset.x) {
#pragma mark 滚动条向左滑
        
        if (self.zzscrollview.clickScroll) { // 点击了label
            [UIView animateWithDuration:0.5 animations:^{
                self.zzscrollview.bottomView.frame = CGRectMake(self.zzscrollview.selectlabel.frame.origin.x, self.zzscrollview.frame.size.height-2, self.zzscrollview.selectlabel.frame.size.width, 2);
            }];
            // 点击后frame修改完成了，再次点击才会走这个方法
            self.zzscrollview.clickScroll = NO;
            return;
        }
        
        // 滚动的方法 x是一个屏幕的滚动范围
        int x = ((int)SCREEN_WIDTH - (int)scrollView.contentOffset.x % (int)SCREEN_WIDTH);
        
        
        
        // 拿到上个一label的frame.width
        NSInteger indexLast = self.zzscrollview.selectlabel.tag-1;
        
        
        if (indexLast<0) {
            return;
        }
        if ( (int)scrollView.contentOffset.x <= (int)SCREEN_WIDTH*indexLast) {//滚动一个屏
            x=SCREEN_WIDTH;
        }else{
            if(x == (int)SCREEN_WIDTH)
            {
                x = 0;
            }
        }
        
        ZZLabel *labLast =  self.zzscrollview.labM[indexLast];
        CGFloat widthLast = labLast.frame.size.width;
        CGFloat addWidth = (widthLast - self.zzscrollview.selectlabel.frame.size.width)*(x/SCREEN_WIDTH);
        
        // offsex 是滚动条的偏移量
        int offsex = widthLast*  x/SCREEN_WIDTH;
        self.zzscrollview.bottomView.frame = CGRectMake(self.zzscrollview.selectlabel.frame.origin.x-offsex, self.zzscrollview.frame.size.height-2, self.zzscrollview.selectlabel.frame.size.width +addWidth, 2);
        // 修改字体颜色 self.zzscrollview.selectlabel.textColor labLast.textColor
                labLast.textColor = [UIColor
                                              colorWithRed:[self.selectedColorRGBA[0] floatValue] + [self.deltaRGBA[0] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                              green:[self.selectedColorRGBA[1] floatValue] + [self.deltaRGBA[1] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                              blue:[self.selectedColorRGBA[2] floatValue] + [self.deltaRGBA[2] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                              alpha:[self.selectedColorRGBA[3] floatValue] + [self.deltaRGBA[3] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH];
                self.zzscrollview.selectlabel.textColor = [UIColor
                                     colorWithRed:[self.normalColorRGBA[0] floatValue] - [self.deltaRGBA[0] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                     green:[self.normalColorRGBA[1] floatValue] - [self.deltaRGBA[1] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                     blue:[self.normalColorRGBA[2] floatValue] - [self.deltaRGBA[2] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH
                                     alpha:[self.normalColorRGBA[3] floatValue] - [self.deltaRGBA[3] floatValue] * (SCREEN_WIDTH - x)/SCREEN_WIDTH];
        
        
    }
    else{
#pragma mark 滚动条向右滑
        if (self.zzscrollview.clickScroll) { // 点击了label
            [UIView animateWithDuration:0.5 animations:^{
                self.zzscrollview.bottomView.frame = CGRectMake(self.zzscrollview.selectlabel.frame.origin.x, self.zzscrollview.frame.size.height-2, self.zzscrollview.selectlabel.frame.size.width, 2);
            }];
            
            self.zzscrollview.clickScroll = NO;
            return;
        }
        
        
        // 滚动方法，x是一个屏幕的滚动范围
        int x = (int)scrollView.contentOffset.x % (int)SCREEN_WIDTH;
        
        // 拿到下个一label的frame.width
        NSInteger indexNext = self.zzscrollview.selectlabel.tag+1;
        
        if (indexNext > self.zzscrollview.labM.count-1) {
            return;
        }
        //
        if ( (int)scrollView.contentOffset.x >= (int)SCREEN_WIDTH*indexNext) {//滚动一个屏
            x=SCREEN_WIDTH;
        }
        // offsex 是滚动条的偏移量
        int offsex = self.zzscrollview.selectlabel.frame.size.width* x/SCREEN_WIDTH;
        
        
        
        ZZLabel *labNext =  self.zzscrollview.labM[indexNext];
        CGFloat widthNext = labNext.frame.size.width;
        
        CGFloat addWidth = (widthNext - self.zzscrollview.selectlabel.frame.size.width)*(x/SCREEN_WIDTH);
        // 设置底部的宽度和origin.x
        self.zzscrollview.bottomView.frame = CGRectMake(self.zzscrollview.selectlabel.frame.origin.x+offsex, self.zzscrollview.frame.size.height-2, addWidth + self.zzscrollview.selectlabel.frame.size.width, 2);
        //
        //
        // 修改字体颜色
                labNext.textColor = [UIColor
                                     colorWithRed:[self.normalColorRGBA[0] floatValue] - [self.deltaRGBA[0] floatValue] * x/SCREEN_WIDTH
                                     green:[self.normalColorRGBA[1] floatValue] - [self.deltaRGBA[1] floatValue] * x/SCREEN_WIDTH
                                     blue:[self.normalColorRGBA[2] floatValue] - [self.deltaRGBA[2] floatValue] * x/SCREEN_WIDTH
                                     alpha:[self.normalColorRGBA[3] floatValue] - [self.deltaRGBA[3] floatValue] * x/SCREEN_WIDTH];
                self.zzscrollview.selectlabel.textColor =[UIColor
                                             colorWithRed:[self.selectedColorRGBA[0] floatValue] + [self.deltaRGBA[0] floatValue] * x/SCREEN_WIDTH
                                             green:[self.selectedColorRGBA[1] floatValue] + [self.deltaRGBA[1] floatValue] * x/SCREEN_WIDTH
                                             blue:[self.selectedColorRGBA[2] floatValue] + [self.deltaRGBA[2] floatValue] * x/SCREEN_WIDTH
                                             alpha:[self.selectedColorRGBA[3] floatValue] + [self.deltaRGBA[3] floatValue] * x/SCREEN_WIDTH];
        
    }
    
}

// 字体颜色渐变
- (NSArray *)deltaRGBA {
    if (_deltaRGBA == nil) {
        NSArray *normalColorRgb = self.normalColorRGBA;
        NSArray *selectedColorRgb = self.selectedColorRGBA;
        
        NSArray *delta;
        if (normalColorRgb && selectedColorRgb) {
            CGFloat deltaR = [normalColorRgb[0] floatValue] - [selectedColorRgb[0] floatValue];
            CGFloat deltaG = [normalColorRgb[1] floatValue] - [selectedColorRgb[1] floatValue];
            CGFloat deltaB = [normalColorRgb[2] floatValue] - [selectedColorRgb[2] floatValue];
            CGFloat deltaA = [normalColorRgb[3] floatValue] - [selectedColorRgb[3] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
            _deltaRGBA = delta;
            
        }
    }
    return _deltaRGBA;
}
- (NSArray *)selectedColorRGBA {
    if (!_selectedColorRGBA) {
        NSArray *selectedColorRGBA = [self getColorRGBA:self.zzscrollview.selectFontColor];
        NSAssert(selectedColorRGBA, @"设置选中状态的文字颜色时 请使用RGBA空间的颜色值");
        _selectedColorRGBA = selectedColorRGBA;
        
    }
    return  _selectedColorRGBA;
}

- (NSArray *)normalColorRGBA {
    if (!_normalColorRGBA) {
        NSArray *normalColorRGBA = [self getColorRGBA:self.zzscrollview.fontColor];
        NSAssert(normalColorRGBA, @"设置普通状态的文字颜色时 请使用RGBA空间的颜色值");
        _normalColorRGBA = normalColorRGBA;
        
    }
    return  _normalColorRGBA;
}
- (NSArray *)getColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;
    
}


@end
