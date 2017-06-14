//
//  RecommendController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/17.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "RecommendController.h"
#import "PullDownView.h"
#import "RecommendViewHeaderCell.h"
#import "RecommendViewButtonsCell.h"
#import "RecommendViewColumnCell.h"
#import "RecommendViewEndCell.h"
#import "RecommendLoadCell.h"
#import "CarouselUrl.h"
#import "LTableView.h"
#import "ColumSetController.h"
@interface RecommendController()<UITableViewDelegate,UITableViewDataSource>{
    BOOL loadingColumFlag;
    NSInteger loadIndex;
}

@property(nonatomic, strong) LTableView *tableView;

@property(nonatomic, strong) UIView *defaultFooterView;

@property(nonatomic, strong) PullDownView *pullDownView;

@property(nonatomic, strong) NSMutableArray *columIdArray;

@property(nonatomic, strong) NSArray *sectionArray;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property(nonatomic, strong) NSArray *bannerArray;

@end

static NSString *RecommendViewHeaderCellIdentifier = @"RecommendViewHeaderCellIdentifier";
static NSString *RecommendViewButtonsCellIdentifier = @"RecommendViewButtonsCellIdentifier";
static NSString *RecommendViewColumnRecommendCellIdentifier = @"RecommendViewColumnRecommendCellIdentifier";
static NSString *RecommendViewColumnExclusiveCellIdentifier = @"RecommendViewColumnExclusiveCellIdentifier";
static NSString *RecommendViewColumnNewestCellIdentifier = @"RecommendViewColumnNewestCellIdentifier";
static NSString *RecommendViewColumnRadioCellIdentifier = @"RecommendViewColumnRadioCellIdentifier";
static NSString *RecommendViewColumnMvCellIdentifier = @"RecommendViewColumnMvCellIdentifier";
static NSString *RecommendViewEndCellIdentifier = @"RecommendViewEndCellIdentifier";
static NSString *RecommendViewLoadCellIdentifier = @"RecommendViewLoadCellIdentifier";

@implementation RecommendController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.dataArray addObject:@(1)];
     [self loadColumSetList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[LTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = self.defaultFooterView;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    
    loadingColumFlag = NO;
    loadIndex = 0;
    self.bannerArray = [self createCarouseUrls];
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
-(UIView* )pullDownView{
    if (!_pullDownView) {
        CGFloat width = self.view.frame.size.width*0.6;
        _pullDownView = [[PullDownView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-width)*0.5, 0, width, 64)image:[UIImage imageNamed:@"cm2_discovery_icn_pulldown"] text:@"首页内容根据你的口味而定"];
        _pullDownView.label.font = Font(H4);
        _pullDownView.label.textColor = RGB(92, 92, 93, 1);
    }
    
    return _pullDownView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(loadingColumFlag){
        if (loadIndex == 0)
            return self.tableView.frame.size.height;
        if (loadIndex == 1){
            if ([indexPath section] == 0) {
                return [RecommendViewHeaderCell cellHeight];
            }else{
                return self.tableView.frame.size.height - [RecommendViewHeaderCell cellHeight];
            }
        }
    }
    if ([indexPath section] == 0) {
        return [RecommendViewHeaderCell cellHeight];
    }else if([indexPath section] == 1){
        return [RecommendViewButtonsCell cellHeight];
    }else if([indexPath section] == 2){
        NSInteger index = [[self.columIdArray objectAtIndex:[indexPath row]] integerValue];
        switch (index) {
            case RecommendColumnCellTypeRecommend:
                return [RecommendViewColumnCell cellHeight:RecommendColumnCellTypeRecommend];
                break;
            case RecommendColumnCellTypeExclusive:
                return [RecommendViewColumnCell cellHeight:RecommendColumnCellTypeExclusive];
                break;
            case RecommendColumnCellTypeNewest:
                return [RecommendViewColumnCell cellHeight:RecommendColumnCellTypeNewest];
                break;
            case RecommendColumnCellTypeMv:
                return [RecommendViewColumnCell cellHeight:RecommendColumnCellTypeMv];
                break;
            case RecommendColumnCellTypeRadio:
                return [RecommendViewColumnCell cellHeight:RecommendColumnCellTypeMv];
                break;
            default:
                break;
        }
    }else if([indexPath section] == 3){
        return [RecommendViewEndCell cellHeight];
    }
    return 100;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (loadingColumFlag) return 1;
    NSInteger show = [[self.sectionArray objectAtIndex:section] integerValue];
    if (section == 0 && show == 1) return 1;
    if (section == 1 && show == 1) return 1;
    if (section == 2 && show == 1) return [self.columIdArray count];
    if (section == 3 && show == 1) return 1;
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (loadingColumFlag && [indexPath section] == loadIndex) {
        RecommendLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewLoadCellIdentifier];
        if(cell==nil){
            cell=[[RecommendLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewLoadCellIdentifier];
        }
        return cell;
    }
    if ([indexPath section] == 0) {
        RecommendViewHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewHeaderCellIdentifier];
        if(cell==nil){
            cell=[[RecommendViewHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewHeaderCellIdentifier];
        }
        cell.carouseMakes = self.bannerArray;
        return cell;
    }else if([indexPath section] == 1){
        RecommendViewButtonsCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewButtonsCellIdentifier];
        if(cell==nil){
            cell=[[RecommendViewButtonsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewButtonsCellIdentifier];
        }
        return cell;
    }else if([indexPath section] == 2){
        
        NSInteger index = [[self.columIdArray objectAtIndex:[indexPath row]] integerValue];
        switch (index) {
            case RecommendColumnCellTypeRecommend:{
                RecommendViewColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewColumnRecommendCellIdentifier];
                if(cell==nil){
                    cell=[[RecommendViewColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewColumnRecommendCellIdentifier type:RecommendColumnCellTypeRecommend];
                }
                return cell;
            }
                break;
            case RecommendColumnCellTypeExclusive:{
                RecommendViewColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewColumnExclusiveCellIdentifier];
                if(cell==nil){
                    cell=[[RecommendViewColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewColumnExclusiveCellIdentifier type:RecommendColumnCellTypeExclusive];
                }
                return cell;
            }
                break;
            case RecommendColumnCellTypeNewest:{
                RecommendViewColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewColumnNewestCellIdentifier];
                if(cell==nil){
                    cell=[[RecommendViewColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewColumnNewestCellIdentifier type:RecommendColumnCellTypeNewest];
                }
                return cell;
            }
                break;
            case RecommendColumnCellTypeMv:{
                RecommendViewColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewColumnMvCellIdentifier];
                if(cell==nil){
                    cell=[[RecommendViewColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewColumnMvCellIdentifier type:RecommendColumnCellTypeMv];
                }
                return cell;
            }
                break;
            case RecommendColumnCellTypeRadio:{
                RecommendViewColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewColumnRadioCellIdentifier];
                if(cell==nil){
                    cell=[[RecommendViewColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewColumnRadioCellIdentifier type:RecommendColumnCellTypeRadio];
                }
                cell.bottomTrim.alpha = YES;
                return cell;
            }
                break;
            default:
                break;
        }
        return nil;
    }else if([indexPath section] == 3){
        RecommendViewEndCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendViewEndCellIdentifier];
        if(cell==nil){
            cell=[[RecommendViewEndCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RecommendViewEndCellIdentifier];
            [cell addTarget:self action:@selector(buttonSetAction)];
        }
        return cell;
    }else{
        return nil;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (loadingColumFlag) {
        return loadIndex+1;
    }else{
        return [self.sectionArray count];
    }
}



#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)columIdArray{
    if (!_columIdArray) {
        _columIdArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _columIdArray;
}

-(NSArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = @[@(0),@(0),@(0),@(0)];
    }
    return _sectionArray;
}
-(NSArray *)bannerArray{
    if (!_bannerArray) {
        _bannerArray = [NSArray array];
    }
    return _bannerArray;
}
#pragma mark - action
-(void)buttonSetAction{
    ColumSetController *columController = [[ColumSetController alloc] init];
    [self.rt_navigationController pushViewController:columController animated:YES complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}

#pragma  mark - handleData

-(void)loadColumSetList{
    if ([self.dataArray count] > 0) {
        NSArray *list = [UserDefaults getColumSetList];
        [self.columIdArray removeAllObjects];
        for (NSNumber *i in list) {
            [self.columIdArray addObject:i];
        }
        self.sectionArray = @[@(1),@(1),@(1),@(1)];
        [self.view insertSubview:self.pullDownView atIndex:0];
    }else{
        self.sectionArray = @[@(1),@(1),@(0),@(0)];
    }
    dispatch_main_async_safe(^{
        [self.tableView reloadData];
    });
}


-(void)startLoadingColumSetData{
    NSInteger index = 0;
    if ([_bannerArray count] > 0) {
        index +=1;
    }
    loadIndex = index;
    loadingColumFlag = YES;
    self.tableView.scrollEnabled = NO;
    dispatch_main_async_safe(^{
        [self.tableView reloadData];
    });
    
}

-(void)stopLoadingColumSetData{
    loadingColumFlag = NO;
    loadIndex = 0;
    self.tableView.scrollEnabled = YES;
    dispatch_main_async_safe(^{
        [self.tableView reloadData];
    });
}


-(NSArray *)createCarouseUrls{
    CarouselUrl *url0 = [[CarouselUrl alloc] init];
    url0.url = @"http://img1.c.yinyuetai.com/others/admin/161213/0/9a27155032001ce981f9fff995ffdd75_0x0.jpg";
    url0.tagName = @"专栏";
    url0.model = LTagViewModelNormal;
    CarouselUrl *url1 = [[CarouselUrl alloc] init];
    url1.url = @"http://img3.c.yinyuetai.com/others/admin/161212/0/9a47308c2f13c31fa7790097cac28d16_0x0.jpg";
    url1.tagName = @"话题";
    url1.model = LTagViewModelHot;
    CarouselUrl *url2 = [[CarouselUrl alloc] init];
    url2.url = @"http://img3.c.yinyuetai.com/others/admin/161209/0/b7d84da50d620ceee4722e6301be397a_0x0.jpg";
    url2.tagName = @"活动";
    url2.model = LTagViewModelNormal;
    CarouselUrl *url3 = [[CarouselUrl alloc] init];
    url3.url = @"http://img4.c.yinyuetai.com/others/admin/161212/0/4a0bb90aed270122347308a66999e14f_0x0.jpg";
    url3.tagName = @"独家首发";
    url3.model = LTagViewModelNormal;
    CarouselUrl *url4 = [[CarouselUrl alloc] init];
    url4.url = @"http://img1.c.yinyuetai.com/others/admin/161210/0/8e516487c0d8dedc529946138ad99022_0x0.jpg";
    url4.tagName = @"明星访谈";
    url4.model = LTagViewModelHot;
    CarouselUrl *url5 = [[CarouselUrl alloc] init];
    url5.url = @"http://img1.c.yinyuetai.com/others/admin/161210/0/8e516487c0d8dedc529946138ad99022_0x0.jpg";
    url5.tagName = @"明星访谈";
    url5.model = LTagViewModelHot;
    return @[url0,url1,url2,url3,url4];
}
@end
