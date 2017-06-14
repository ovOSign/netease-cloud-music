//
//  RadioController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/17.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "RadioController.h"
#import "LTableView.h"
#import "BannerMenuCell.h"
#import "RadioRankCell.h"
#import "RadioRecommendHeadCell.h"
#import "RadioRecomendCell.h"
#import "RadioRecBean.h"

@interface RadioController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView *defaultFooterView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)LTableView *tableView;

@end

static NSString *BannerMenuCellIdentifier = @"BannerMenuCellIdentifier";
static NSString *RadioRankCellIdentifier = @"RadioRankCellIdentifier";

static NSString *RadioRecomendHeadCellIdentifier = @"RadioRecomendHeadCellIdentifier";
static NSString *RadioRecomendCellIdentifier = @"RadioRecomendCellIdentifier";

@implementation RadioController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[LTableView alloc] initWithFrame:CGRectMake(cellMargin, 0, self.view.frame.size.width-cellMargin*2, self.view.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = self.defaultFooterView;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        _dataArray = [[self createCarouseUrls] mutableCopy];
        
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0) {
        return [BannerMenuCell cellHeight];
    }else if ([indexPath section] == 1) {
        return tableView.frame.size.width*104/400;
    }else if ([indexPath section] == 2) {
        if ([indexPath row] == 0)
            return tableView.frame.size.width*80/400;
        else
            return tableView.frame.size.width*90/400;
    }
    return 100;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ( section == 2) return [self.dataArray count]+1;
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath section] == 0) {
        BannerMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:BannerMenuCellIdentifier];
        if(cell==nil){
            cell=[[BannerMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BannerMenuCellIdentifier];
        }
        return cell;
    }else if([indexPath section] == 1){
        RadioRankCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioRankCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"RadioRankCell" bundle:nil] forCellReuseIdentifier:RadioRankCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:RadioRankCellIdentifier];
        }
        [cell.rankImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
        return cell;
    }else if([indexPath section] == 2){
        if ([indexPath row] == 0) {
            RadioRecommendHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioRecomendHeadCellIdentifier];
            if(cell==nil){
                [tableView registerNib:[UINib nibWithNibName:@"RadioRecommendHeadCell" bundle:nil] forCellReuseIdentifier:RadioRecomendHeadCellIdentifier];
                cell=[tableView dequeueReusableCellWithIdentifier:RadioRecomendHeadCellIdentifier];
            }
            return cell;
        }else{
            RadioRecBean *bean = [self.dataArray objectAtIndex:[indexPath row]-1];
            RadioRecomendCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioRecomendCellIdentifier];
            if(cell==nil){
                [tableView registerNib:[UINib nibWithNibName:@"RadioRecomendCell" bundle:nil] forCellReuseIdentifier:RadioRecomendCellIdentifier];
                cell=[tableView dequeueReusableCellWithIdentifier:RadioRecomendCellIdentifier];
            }
            [cell.recImageView sd_setImageWithURL:[NSURL URLWithString:bean.imgUrl]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
            cell.title.text = bean.title;
            cell.describe.text = bean.describe;
            return cell;
        }
        
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSArray *)createCarouseUrls{
    RadioRecBean *bean1 = [[RadioRecBean alloc] init];
    bean1.imgUrl = @"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4b79c8ac3571ea9675bbb613d3325beb_0x0.jpg";
    bean1.describe = @"可爱的笑容";
    bean1.title = @"为何文人对杨贵妃褒贬不一？";
    
    
    RadioRecBean *bean2 = [[RadioRecBean alloc] init];
    bean2.imgUrl = @"http://img2.c.yinyuetai.com/others/frontPageRec/161219/0/-M-f83414f548534448281d8b453d85a403_0x0.jpg";
    bean2.describe = @"Billboard 2016年度单曲榜《上集》";
    bean2.title = @"上文是什么";
    
    
    RadioRecBean *bean3 = [[RadioRecBean alloc] init];
    bean3.imgUrl = @"http://img0.c.yinyuetai.com/others/frontPageRec/161214/0/-M-6a767298ca5ef25d1109bae1d40967e9_0x0.jpg";
    bean3.describe = @"BiHeartRadio Jingle Ball 2016";
    bean3.title = @"你喜欢就好，不要问";
    
    
    RadioRecBean *bean4 = [[RadioRecBean alloc] init];
    bean4.imgUrl = @"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg";
    bean4.describe = @"VEVO 2016年全球最热25支mv年榜";
    bean4.title = @"2016年全球最热25支";
    
    
    
    return @[bean1,bean2,bean3,bean4];
    
}


@end
