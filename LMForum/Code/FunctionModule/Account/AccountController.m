//
//  AccountController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "AccountController.h"
#import "LAccountCell.h"
#import "LAccountListCell.h"
#import "LLogoutCell.h"
@interface AccountController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property (nonatomic,strong) UIView *defaultFooterView;



@end

static NSString *AccountCellIdentifier = @"AccountCellIdentifier";

static NSString *AccountListCellIdentifier = @"AccountListCellIdentifier";

static NSString *LogoutCellIdentifier = @"LogoutCellIdentifier";

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = self.defaultFooterView;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - getter
- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 3;
    }else if(section == 3){
        return 7;
    }else if(section == 4){
        return 2;
    }else if(section == 5){
        return 1;
    }else if(section == 6){
        return 0;
    }else{
        return 0;
    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([indexPath section] == 0){
        LAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LAccountCell" bundle:nil] forCellReuseIdentifier:AccountCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:AccountCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        return cell;
    }else if([indexPath section] == 1){
        LAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LAccountListCell" bundle:nil] forCellReuseIdentifier:AccountListCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        return cell;
    }else if([indexPath section] == 2){
        LAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LAccountListCell" bundle:nil] forCellReuseIdentifier:AccountListCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        }
        if ([indexPath row] == 0) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_vip"]];
            [cell.listName setText:@"会员中心"];
        }
        if ([indexPath row] == 1) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_store"]];
            [cell.listName setText:@"商场"];
        }
        if ([indexPath row] == 2) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_combo"]];
            [cell.listName setText:@"在线听歌免流量"];
        }
        
        return cell;
    }else if([indexPath section] == 3){
        LAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LAccountListCell" bundle:nil] forCellReuseIdentifier:AccountListCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        }
        if ([indexPath row] == 0) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_set"]];
            [cell.listName setText:@"设置"];
        }
        if ([indexPath row] == 1) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_scan"]];
            [cell.listName setText:@"扫一扫"];
        }
        if ([indexPath row] == 2) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_skin"]];
            [cell.listName setText:@"主题换肤"];
        }
        if ([indexPath row] == 3) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_night"]];
            [cell.listName setText:@"夜间模式"];
        }
        if ([indexPath row] == 4) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_time"]];
            [cell.listName setText:@"定时关闭"];
        }
        if ([indexPath row] == 5) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_alamclock"]];
            [cell.listName setText:@"音乐闹钟"];
        }
        if ([indexPath row] == 6) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_vehicle"]];
            [cell.listName setText:@"驾车模式"];
        }
        
        return cell;
    }else if([indexPath section] == 4){
        LAccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LAccountListCell" bundle:nil] forCellReuseIdentifier:AccountListCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:AccountListCellIdentifier];
        }
        if ([indexPath row] == 0) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_share"]];
            [cell.listName setText:@"分享网易云"];
        }
        if ([indexPath row] == 1) {
            [cell.listImageView setImage:[UIImage imageNamed:@"cm2_set_icn_about"]];
            [cell.listName setText:@"关于"];
        }
        return cell;
    }else if([indexPath section] == 5){
         LLogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:LogoutCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LLogoutCell" bundle:nil] forCellReuseIdentifier:LogoutCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:LogoutCellIdentifier];
        }
         return cell;
    }else{
        return nil;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0) {
         return tableView.frame.size.width*181/400;
    }else{
        return tableView.frame.size.width*56/400;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    else{
        return 10;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 25; //sectionHeaderHeight
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

@end
