//
//  MyMusicController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "MyMusicController.h"
#import "LMusicListCell.h"
#import "MyMusicColumModel.h"
#import "LSongMenuCell.h"
#import "MyMusicColumMenuModel.h"
#import "LSongMenuHeadView.h"
#import "LRectMusicController.h"
@interface MyMusicController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;

@property (strong, nonatomic) UIView *defaultFooterView;

@property (strong, nonatomic) LSongMenuHeadView* createHeader;

@property (strong, nonatomic) LSongMenuHeadView* colHeader;

@property(nonatomic, strong) NSArray *columArray;

@property(nonatomic, strong) NSMutableArray *createMenuArray;

@property(nonatomic, strong) NSMutableArray *createMenuDataArray;

@property(nonatomic, strong) NSMutableArray *colMenuArray;

@property(nonatomic, strong) NSMutableArray *colMenuDataArray;


@end

static NSString *MusicListCellCellIdentifier = @"MusicListCellCellIdentifier";

static NSString *SongMenuCellCellIdentifier = @"SongMenuCellCellIdentifier";

@implementation MyMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = self.defaultFooterView;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _columArray = [NSMutableArray arrayWithCapacity:4];
        MyMusicColumModel *model = [[MyMusicColumModel alloc] init];
        model.image = @"cm2_list_icn_dld_new";
        model.itemName = @"下载音乐";
        model.num = @"0";
        MyMusicColumModel *model2 = [[MyMusicColumModel alloc] init];
        model2.image = @"cm2_list_icn_recent_new";
        model2.itemName = @"最近播放";
        model2.num = [NSString stringWithFormat:@"%lu",(unsigned long)[[[LAVPlayer sharedInstance] getRectPlayArray] count]];
        MyMusicColumModel *model3 = [[MyMusicColumModel alloc] init];
        model3.image = @"cm2_list_icn_artists_new";
        model3.itemName = @"我的歌手";
        model3.num = @"1";
        MyMusicColumModel *model4 = [[MyMusicColumModel alloc] init];
        model4.image = @"cm2_list_icn_mymv_new";
        model4.itemName = @"我的MV";
        model4.num = @"1";
        self.columArray = @[model,model2,model3,model4];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     });
}

#pragma mark - getter
- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}

-(LSongMenuHeadView*)createHeader{
    if (!_createHeader) {
        _createHeader = [[[NSBundle mainBundle] loadNibNamed: @"LSongMenuHeadView"
                                                                   owner: self
                                                            options: nil] lastObject];
        _createHeader.state = MenuHeadStateDown;
        [_createHeader addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldTapGestureRecognizer:)]];
    }
    return _createHeader;
}

-(LSongMenuHeadView*)colHeader{
    if (!_colHeader) {
        _colHeader = [[[NSBundle mainBundle] loadNibNamed: @"LSongMenuHeadView"
                                                       owner: self
                                                     options: nil] lastObject];
        _colHeader.state = MenuHeadStateDown;
        [_colHeader addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldColTapGestureRecognizer:)]];
        _colHeader.title.text = @"我收藏的歌单(3)";
    }
    return _colHeader;
}

-(NSArray *)columArray{
    if (!_columArray) {
    }
    return _columArray;
}


-(NSMutableArray *)createMenuDataArray{
    if (!_createMenuDataArray) {
        _createMenuDataArray = [NSMutableArray array];
        MyMusicColumMenuModel *model = [[MyMusicColumMenuModel alloc] init];
        model.image = @"http://img1.c.yinyuetai.com/others/frontPageRec/161213/0/-M-cc41300165c0162ae48aa878bbe3d04a_0x0.jpg";
        model.itemName = @"我喜欢的音乐";
        model.num = @"3首";
        [_createMenuDataArray addObject:model];
    }
    return _createMenuDataArray;
}

-(NSMutableArray *)createMenuArray{
    if (!_createMenuArray) {
        _createMenuArray = [self.createMenuDataArray copy];
    }
    return _createMenuArray;
}

-(NSMutableArray *)colMenuDataArray{
    if (!_colMenuDataArray) {
        _colMenuDataArray = [NSMutableArray array];
        MyMusicColumMenuModel *model = [[MyMusicColumMenuModel alloc] init];
        model.image = @"http://img0.c.yinyuetai.com/others/frontPageRec/161201/0/-M-ff7222eaf4d8236bb9df0522980b6ee7_0x0.jpg";
        model.itemName = @"【欧美】有种爱好觉：列表循环";
        model.num = @"233首";
        model.person = @"by 樱花深木";
        MyMusicColumMenuModel *model1 = [[MyMusicColumMenuModel alloc] init];
        model1.image = @"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg";
        model1.itemName = @"北大图书馆闭馆音乐备选列表";
        model1.num = @"393首";
        model1.person = @"by 放假哦哦i哦i";
        
        MyMusicColumMenuModel *model2 = [[MyMusicColumMenuModel alloc] init];
        model2.image = @"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4b79c8ac3571ea9675bbb613d3325beb_0x0.jpg";
        model2.itemName = @"100首经典英文老歌。 （3）";
        model2.num = @"100首";
        model2.person = @"by 音乐分享达人";
        
        [_colMenuDataArray addObject:model];
        [_colMenuDataArray addObject:model1];
        [_colMenuDataArray addObject:model2];
    }
    return _colMenuDataArray;
}

-(NSMutableArray *)colMenuArray{
    if (!_colMenuArray) {
        _colMenuArray = [self.colMenuDataArray copy];
    }
    return _colMenuArray;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return [self.columArray count];
    }else  if (section == 1) {
        return [self.createMenuArray count];
    }else  if (section == 2) {
        return [self.colMenuArray count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath section] == 0) {
        LMusicListCell *cell = [tableView dequeueReusableCellWithIdentifier:MusicListCellCellIdentifier];
        MyMusicColumModel *columModel = [self.columArray objectAtIndex:[indexPath row]];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LMusicListCell" bundle:nil] forCellReuseIdentifier:MusicListCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:MusicListCellCellIdentifier];
        }
        if ([indexPath row] == [self.columArray count]-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        cell.model = columModel;
        return cell;
    }else if ([indexPath section] == 1) {
        LSongMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
         MyMusicColumMenuModel *menuModel = [self.createMenuArray objectAtIndex:[indexPath row]];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LSongMenuCell" bundle:nil] forCellReuseIdentifier:SongMenuCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        }
        if ([indexPath row] == [self.createMenuArray count]-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        cell.model = menuModel;
        return cell;
        
    }else if ([indexPath section] == 2) {
        LSongMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        MyMusicColumMenuModel *menuModel = [self.colMenuArray objectAtIndex:[indexPath row]];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LSongMenuCell" bundle:nil] forCellReuseIdentifier:SongMenuCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        }
        if ([indexPath row] == [self.colMenuArray count]-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        cell.model = menuModel;
        return cell;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.width*62/400;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        
        return self.createHeader;
        
    }if(section == 2){
        
        return self.colHeader;
        
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1||section == 2){
      return tableView.frame.size.width*38/400;
    }
    else{
        return 0;
    }
}

-(void)foldTapGestureRecognizer:(UITapGestureRecognizer *)sender{
    LSongMenuHeadView *view = (LSongMenuHeadView*)[sender view];
    switch (view.state) {
        case MenuHeadStateFold:
            self.createMenuArray = [self.createMenuDataArray copy];
            view.state = MenuHeadStateDown;
            break;
        case MenuHeadStateDown:
            self.createMenuArray = [NSMutableArray array];
            view.state = MenuHeadStateFold;
            break;
            
        default:
           
            break;
    }
    
     [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
   
    
}

-(void)foldColTapGestureRecognizer:(UITapGestureRecognizer *)sender{
    LSongMenuHeadView *view = (LSongMenuHeadView*)[sender view];
    switch (view.state) {
        case MenuHeadStateFold:
            self.colMenuArray = [self.colMenuDataArray copy];
            view.state = MenuHeadStateDown;
            break;
        case MenuHeadStateDown:
            self.colMenuArray = [NSMutableArray array];
            view.state = MenuHeadStateFold;
            break;
        default:
            break;
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath section] == 0 && [indexPath row] == 1) {
        LRectMusicController *lc = [[LRectMusicController alloc] init];
        [self.tabBarController addChildViewController:lc];
        CGRect rect = self.tabBarController.tabBar.frame;
        self.tabBarController.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y+64, rect.size.width, rect.size.height);
        self.tabBarController.delegate = lc;
        lc.dismiss = ^{
            self.tabBarController.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
            [self.navigationController.visibleViewController.view addSubview:self.tabBarController.tabBar];
        };

        [[[UIApplication sharedApplication] keyWindow] insertSubview:self.tabBarController.tabBar atIndex:1];
        [self.rt_navigationController pushViewController:lc animated:YES complete:^(BOOL finished) {
            [self.rt_navigationController removeViewController:self];
        }];
        
    }
}

@end
