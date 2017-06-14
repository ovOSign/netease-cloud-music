//
//  LSelectMusicController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/5.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LSelectMusicController.h"
#import "LSearchMusicDisplayController.h"
#import "LSearchMusicResultController.h"
#import "LSelectMusicCell.h"
#import "LShareManager.h"
@interface LSelectMusicController ()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *defaultFooterView;

@property (strong, nonatomic) LSearchMusicDisplayController *searchController;


@end

@implementation LSelectMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择音乐";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = self.defaultFooterView;
    _tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:_tableView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.dataArray = [[[LAVPlayer sharedInstance] getRectPlayMoreArry] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
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

#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
//搜索的结果列表
- (LSearchMusicDisplayController *)searchController{
    if (_searchController == nil) {
        LSearchMusicResultController *rc = [[LSearchMusicResultController alloc] init];
        _searchController = [[LSearchMusicDisplayController alloc] initWithSearchResultsController:rc];
        _searchController.searchBar.placeholder = @"搜索音乐";
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.delegate = self;
        //_searchController.obscuresBackgroundDuringPresentation = NO;
        _searchController.searchBar.tintColor = RGB(196,36,37, 1);
//        for (UIView *subView in _searchController.searchBar.subviews) {
//            subView.backgroundColor = [UIColor clearColor];
//            for (UIView *v in subView.subviews) {
//                if ([v isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//                    [(UIImageView*)v setImage:[CommonUtils ImageWithColor:[UIColor redColor] width:1 height:1] ];
//                }
//            }
//        }

    }

    return _searchController;
}
#pragma mark - UISearchControllerDelegate


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray count]+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cellMargin, 10, 100, 30)];
            label.text = @"最近播放";
            label.textColor = RGB(103,104,104,1);
            label.font = Font(H5);
            [cell addSubview:label];
            cell.separatorInset = UIEdgeInsetsMake(0, cellMargin, 0, 0);
            cell.backgroundColor =[UIColor clearColor];
        }
        return cell;
    }else{
        MusicModel *model = [self.dataArray objectAtIndex:[indexPath row]-1];
        NSString *cellID = @"LSelectMusicCell";
        LSelectMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LSelectMusicCell" bundle:nil] forCellReuseIdentifier:cellID];
            cell=[tableView dequeueReusableCellWithIdentifier:cellID];
            cell.separatorInset = UIEdgeInsetsMake(0, 87*W_SCALE, 0, 0);
        };
        cell.model = model;
        if ([indexPath row] == [self.dataArray count]) {
            cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        return 40;
    }else{
        return tableView.frame.size.width*75/400;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicModel *model = [self.dataArray objectAtIndex:[indexPath row]-1];
    [[LShareManager sharedInstance] setCurrentSelectMusic:model];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
