//
//  SingMenuView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/12.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "SingMenuView.h"
#import "SingMenuCell.h"
#import "LTableView.h"
#import "SingMenuHeaderView.h"
#import "SingMenuHeaderCell.h"
#import "SingMenuBean.h"

@interface SingMenuView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView *defaultFooterView;

@property(nonatomic, strong)SingMenuHeaderView *defaultHeaderView;

@property(nonatomic, strong)MJRefreshBackGifFooter *footRefreshView;

@end

static NSString *SingMenuCellIdentifier = @"SingMenuCellIdentifier";
static NSString *SingMenuHeaderCellIdentifier = @"SingMenuHeaderCellIdentifier";

@implementation SingMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _tableView = [[LTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = self.defaultFooterView;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_tableView];
        
        _defaultHeaderView= [[SingMenuHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 60*H_SCALE)];
        _tableView.tableHeaderView = _defaultHeaderView;
        
        _tableView.mj_footer = self.footRefreshView;
        
         
        
        
    }
    return self;
}

#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        _dataArray = [self handleArrayForDoubel:[self createCarouseUrls]];
    }
    return _dataArray;
}

#pragma mark - getter
- (UIView *)defaultFooterView
{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}


-(MJRefreshBackGifFooter *)footRefreshView{
    if (!_footRefreshView) {
        _footRefreshView = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            
        }];
        [_footRefreshView setImages:@[[UIImage imageNamed:@"cm2_list_icn_loading1"],[UIImage imageNamed:@"cm2_list_icn_loading2"],[UIImage imageNamed:@"cm2_list_icn_loading3"],[UIImage imageNamed:@"cm2_list_icn_loading4"]] duration:0.5 forState:MJRefreshStateRefreshing];
        [_footRefreshView setMj_h:90*H_SCALE];
        [_footRefreshView setTitle:@"上拉加载" forState:MJRefreshStateIdle];
        [_footRefreshView setTitle:@"松开刷新" forState:MJRefreshStatePulling];
        [_footRefreshView setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    }
    return _footRefreshView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        return [SingMenuHeaderCell cellHeight];
    }else{
        return [SingMenuCell cellHeight];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray count]+1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if ([indexPath row] == 0) {
        SingMenuHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:SingMenuHeaderCellIdentifier];
        if(cell==nil){
            cell=[[SingMenuHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingMenuHeaderCellIdentifier];
        }
        return cell;
    }else{
        NSMutableArray *singMenuArray = [self.dataArray objectAtIndex:[indexPath row]-1];
        SingMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SingMenuCellIdentifier];
        if(cell==nil){
            cell=[[SingMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SingMenuCellIdentifier];
        }
        cell.dataArray = singMenuArray;
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - private
//对array进行两两分组
-(NSMutableArray*)handleArrayForDoubel:(NSArray*)array{
   __block NSMutableArray *sortArray = [NSMutableArray array];
   __block NSMutableArray *currentSortArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if((idx+1)%2==0 || (idx+1)==[array count]){
            [currentSortArray addObject:obj];
            [sortArray addObject:[currentSortArray copy]];
            currentSortArray = [NSMutableArray array];
        }else{
            [currentSortArray addObject:obj];
        }
    }];
    return sortArray;
}


-(NSArray *)createCarouseUrls{
    SingMenuBean *bean1 = [[SingMenuBean alloc] init];
    bean1.imgUrl = @"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4b79c8ac3571ea9675bbb613d3325beb_0x0.jpg";
    bean1.describe = @"可爱的笑容";
    bean1.listenNum = @"17万";
    bean1.person = @"半岛铁盒";
    
    SingMenuBean *bean2 = [[SingMenuBean alloc] init];
    bean2.imgUrl = @"http://img2.c.yinyuetai.com/others/frontPageRec/161219/0/-M-f83414f548534448281d8b453d85a403_0x0.jpg";
    bean2.describe = @"Billboard 2016年度单曲榜《上集》";
    bean2.listenNum = @"10万";
    bean2.person = @"~半仙";
    
    SingMenuBean *bean3 = [[SingMenuBean alloc] init];
    bean3.imgUrl = @"http://img0.c.yinyuetai.com/others/frontPageRec/161214/0/-M-6a767298ca5ef25d1109bae1d40967e9_0x0.jpg";
    bean3.describe = @"BiHeartRadio Jingle Ball 2016";
    bean3.listenNum = @"130万";
    bean3.person = @"乡乡";
    
    SingMenuBean *bean4 = [[SingMenuBean alloc] init];
    bean4.imgUrl = @"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg";
    bean4.describe = @"VEVO 2016年全球最热25支mv年榜";
    bean4.listenNum = @"17万";
    bean4.person = @"艾丽斯";
    
    SingMenuBean *bean5 = [[SingMenuBean alloc] init];
    bean5.imgUrl = @"http://img1.c.yinyuetai.com/others/frontPageRec/161213/0/-M-cc41300165c0162ae48aa878bbe3d04a_0x0.jpg";
    bean5.describe = @"那些由童话故事改编的真人版电影";
    bean5.listenNum = @"1000";
    bean5.person = @"半岛铁盒";
    
    SingMenuBean *bean6 = [[SingMenuBean alloc] init];
    bean6.imgUrl = @"http://img0.c.yinyuetai.com/others/frontPageRec/161201/0/-M-ff7222eaf4d8236bb9df0522980b6ee7_0x0.jpg";
    bean6.describe = @"《时代》杂志评选出2016年十大最烂歌曲";
    bean6.listenNum = @"1980";
    bean6.person = @"半岛——盒";
    
    
    return @[bean1,bean2,bean3,bean4,bean5,bean6];
    
}

@end
