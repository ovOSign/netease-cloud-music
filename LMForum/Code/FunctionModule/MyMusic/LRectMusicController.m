//
//  LRectMusicController.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/16.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LRectMusicController.h"
#import "LRectMusicCell.h"
#import "LRectMusicHead.h"
@interface LRectMusicController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *defaultFooterView;

@property (nonatomic, strong) LRectMusicHead *head;
@end

@implementation LRectMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINIBACKGROUNDCOLOR;
    self.navigationItem.title = @"最近播放的歌曲";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = self.defaultFooterView;
    [self.view addSubview:_tableView];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.dataArray = [[[LAVPlayer sharedInstance] getRectPlayArray] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_dismiss) _dismiss();
}


#pragma mark - getter
- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(LRectMusicHead*)head{
    if (!_head) {
        _head = [[[NSBundle mainBundle] loadNibNamed: @"LRectMusicHead"
                                                       owner: self
                                                     options: nil] lastObject];
    }
    return _head;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicModel *model = [self.dataArray objectAtIndex:[indexPath row]];
    NSString *cellID = @"LRectMusicCell";
    LRectMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell==nil){
        [tableView registerNib:[UINib nibWithNibName:@"LRectMusicCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    };
       cell.model = model;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return tableView.frame.size.width*60/400;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.head;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView.frame.size.width*60/400;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MusicModel *model = [self.dataArray objectAtIndex:[indexPath row]];
    if ([model.name isEqualToString:[LAVPlayer sharedInstance].currentMusic.name]) {
        [[LAVPlayer sharedInstance] play];
    }else{
        [[LAVPlayer sharedInstance] playSongWithSongName:model.name];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWPLAYMUSICVIEW object:nil];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (viewController == tabBarController.viewControllers[1]) {
        [self.rt_navigationController popViewControllerAnimated:true complete:nil];
    }else{
        [self.rt_navigationController popViewControllerAnimated:false complete:nil];
    }
}

@end

