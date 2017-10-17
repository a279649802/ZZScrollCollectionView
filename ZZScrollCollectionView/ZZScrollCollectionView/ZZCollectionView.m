//
//  ZZCollectionView.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ZZCollectionView.h"
#import "ZZCollectionViewCell.h"
#import "ZZLabel.h"
@interface ZZCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>

@end


@implementation ZZCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if([super initWithFrame:frame collectionViewLayout:layout]){
        self.backgroundColor = [UIColor whiteColor];
        self.pagingEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}




//#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _zzscrollview.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView registerClass:[ZZCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;
    cell.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];

    return cell;
}

static int indexpathItem = 0;
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexpathItem = (int)indexPath.item;
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_zzscrollview.isNoDisplayingCellEnabled) {
        _zzscrollview.isNoDisplayingCellEnabled = NO;
        return;
    }
    if ((int)indexPath.item == indexpathItem) {
        return;
    }
    ZZLabel *lab = _zzscrollview.labM[indexpathItem];
    _zzscrollview.selectlabel.font = [UIFont systemFontOfSize:[_zzscrollview.fontsize floatValue]];
    _zzscrollview.selectlabel.textColor = _zzscrollview.fontColor;
    lab.textColor = _zzscrollview.selectFontColor;
//    lab.font = [UIFont boldSystemFontOfSize:[_zzscrollview.fontsize floatValue]+1];
    _zzscrollview.selectlabel = lab;
    
}



#pragma mark - 监听底部conllectionView的滚动 ：开始滚动时的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastContentOffset = scrollView.contentOffset.x ;
    
}

#pragma mark - 监听底部conllectionView的滚动 ：滚动进行时的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (self.scrollNoEnabled == YES) { // 禁止了这个方法
//        return;
//    }
    
    
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > SCREEN_WIDTH*(_zzscrollview.labM.count-1)) {
        return;
    }
    
    
    
    if (self.lastContentOffset >= scrollView.contentOffset.x) {
#pragma mark 滚动条向左滑
        
        if (_zzscrollview.clickScroll) { // 点击了label
            [UIView animateWithDuration:0.5 animations:^{
                _zzscrollview.bottomView.frame = CGRectMake(_zzscrollview.selectlabel.frame.origin.x, _zzscrollview.frame.size.height-2, _zzscrollview.selectlabel.frame.size.width, 2);
            }];
            // 点击后frame修改完成了，再次点击才会走这个方法
            _zzscrollview.clickScroll = NO;
            return;
        }
        
        // 滚动的方法 x是一个屏幕的滚动范围
        int x = ((int)SCREEN_WIDTH - (int)scrollView.contentOffset.x % (int)SCREEN_WIDTH);
        
        
        
        // 拿到上个一label的frame.width
        NSInteger indexLast = _zzscrollview.selectlabel.tag-1;
        
        
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
 
        ZZLabel *labLast =  _zzscrollview.labM[indexLast];
        CGFloat widthLast = labLast.frame.size.width;
        CGFloat addWidth = (widthLast - _zzscrollview.selectlabel.frame.size.width)*(x/SCREEN_WIDTH);
        
        // offsex 是滚动条的偏移量
        int offsex = widthLast*  x/SCREEN_WIDTH;
        _zzscrollview.bottomView.frame = CGRectMake(_zzscrollview.selectlabel.frame.origin.x-offsex, _zzscrollview.frame.size.height-2, _zzscrollview.selectlabel.frame.size.width +addWidth, 2);
        
        
        
    }
    else{
#pragma mark 滚动条向右滑
        if (_zzscrollview.clickScroll) { // 点击了label
            [UIView animateWithDuration:0.5 animations:^{
                _zzscrollview.bottomView.frame = CGRectMake(_zzscrollview.selectlabel.frame.origin.x, _zzscrollview.frame.size.height-2, _zzscrollview.selectlabel.frame.size.width, 2);
            }];
            
            _zzscrollview.clickScroll = NO;
            return;
        }

        
        // 滚动方法，x是一个屏幕的滚动范围
        int x = (int)scrollView.contentOffset.x % (int)SCREEN_WIDTH;
        
         // 拿到下个一label的frame.width
        NSInteger indexNext = _zzscrollview.selectlabel.tag+1;
        
        if (indexNext > _zzscrollview.labM.count-1) {
            return;
        }
        //
        if ( (int)scrollView.contentOffset.x >= (int)SCREEN_WIDTH*indexNext) {//滚动一个屏
            x=SCREEN_WIDTH;
        }
        // offsex 是滚动条的偏移量
        int offsex = _zzscrollview.selectlabel.frame.size.width* x/SCREEN_WIDTH;
        
        
        
        ZZLabel *labNext =  _zzscrollview.labM[indexNext];
        CGFloat widthNext = labNext.frame.size.width;
        
        CGFloat addWidth = (widthNext - _zzscrollview.selectlabel.frame.size.width)*(x/SCREEN_WIDTH);
        // 设置底部的宽度和origin.x
        _zzscrollview.bottomView.frame = CGRectMake(_zzscrollview.selectlabel.frame.origin.x+offsex, _zzscrollview.frame.size.height-2, addWidth + _zzscrollview.selectlabel.frame.size.width, 2);
//
//        
    }
    


    
}

#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
        //计算滚动到第几个索引
        NSInteger index = scrollView.contentOffset.x /scrollView.bounds.size.width;
        //    //根据标签去找lab
        ZZLabel *lab = _zzscrollview.labM[index];
    
        //lab滚动的偏移量
        CGFloat labOffSetX = lab.center.x - self.bounds.size.width/2;
        // 限制最大和最小的偏移量
        CGFloat minOffsetX = 0;
        CGFloat maxOffsetX = _zzscrollview.contentSize.width - self.bounds.size.width;
    
        if (labOffSetX < minOffsetX) {
            labOffSetX = 0;
        }else if(labOffSetX > maxOffsetX)
        {
            labOffSetX = maxOffsetX;
        }
    
        //真正的滚动channelScollview
        [_zzscrollview setContentOffset:CGPointMake(labOffSetX, 0) animated:YES];
    
}


    


@end
