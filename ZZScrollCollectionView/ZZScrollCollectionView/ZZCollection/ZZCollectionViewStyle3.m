//
//  ZZCollectionViewStyle3.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/9/25.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZCollectionViewStyle3.h"

@implementation ZZCollectionViewStyle3

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
        if ( (int)scrollView.contentOffset.x <= (int)SCREEN_WIDTH *indexLast) {//滚动一个屏
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
    
        // 改变字体的大小 deltaScale * (SCREEN_WIDTH - x)/SCREEN_WIDTH deltaScale * (SCREEN_WIDTH - x)
        CGFloat deltaScale = CURRENT_TRANSFORM_SX - 1.0;
        labLast.currentTransformSx = 1.0 + deltaScale * x/SCREEN_WIDTH;
        self.zzscrollview.selectlabel.currentTransformSx = CURRENT_TRANSFORM_SX - deltaScale * x/SCREEN_WIDTH;
        
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
        
        //     改变字体的大小 deltaScale * x/SCREEN_WIDTH deltaScale * x/SCREEN_WIDTH
        CGFloat deltaScale = CURRENT_TRANSFORM_SX - 1.0;
        labNext.currentTransformSx = 1.0 + deltaScale * x/SCREEN_WIDTH;
        self.zzscrollview.selectlabel.currentTransformSx = CURRENT_TRANSFORM_SX - deltaScale * x/SCREEN_WIDTH;
    
    }
    
    
    
}



@end
