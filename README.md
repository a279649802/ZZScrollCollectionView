# ZZScrollCollectionView
### The Example Contains Scroll/Collection and interations between them
#### Show results:
![](https://github.com/a279649802/ZZScrollCollectionView/raw/master/ZZSCGIF.gif)  
#### How To Use:
```
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
```

```
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
```
#### About CocoaPods
pod search ZZScrollCollectionView

