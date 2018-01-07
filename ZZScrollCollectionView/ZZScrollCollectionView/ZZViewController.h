//
//  ZZViewController.h
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define CURRENT_TRANSFORM_SX 1.2

#define LABEL_BACK_COLOR [UIColor whiteColor]
#define FONT_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define FONT_SIZE [NSNumber numberWithInteger:12]
#define SELECT_FONT_COLOR [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0]
#define SELECT_LINE_COLOR [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0]

@interface ZZViewController : UIViewController

@property (nonatomic,copy) NSString *style;

@end
