//
//  ZZCollectionView.h
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZScrollView.h"
@interface ZZCollectionView : UICollectionView
@property (nonatomic,weak) ZZScrollView *zzscrollview;
@property (nonatomic,assign) float lastContentOffset; //最后滑动的content.x


@end
