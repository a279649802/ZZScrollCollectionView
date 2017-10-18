//
//  ViewController.m
//  ZZScrollCollectionView
//
//  Created by 久其智通 on 2017/8/10.
//  Copyright © 2017年 none. All rights reserved.
//

#import "ViewController.h"
#import "ZZViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

static NSInteger indexOne = 2;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
      UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == indexOne) {
        cell.textLabel.text = [NSString stringWithFormat:@"默认的效果"];
    }else if (indexPath.row ==indexOne +1){
        cell.textLabel.text = [NSString stringWithFormat:@"带颜色变化的效果"];
    }else if (indexPath.row == indexOne +2){
        cell.textLabel.text = [NSString stringWithFormat:@"带字体大小变化效果"];
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT/10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZViewController *zzvc = [[ZZViewController alloc] init];
    [self.navigationController pushViewController:zzvc animated:YES];
    if (indexPath.row == indexOne) {
    }else if (indexPath.row == indexOne +1){
        zzvc.style = @"2";
    }else if (indexPath.row == indexOne +2){
        zzvc.style = @"3";
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
