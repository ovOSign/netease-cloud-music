//
//  RankingView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/12.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RankingView.h"
#import "RankingHeaderCell.h"
#import "RankOfCloudCell.h"
#import "RankBean.h"
@interface RankingView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UIView *defaultFooterView;

@end


static NSString *RankingHeadCellIdentifier = @"RankingHeadCellIdentifier";

static NSString *RankOfCloudCellIdentifier = @"RankOfCloudCellIdentifier";

@implementation RankingView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _tableView = [[LTableView alloc] initWithFrame:CGRectMake(cellMargin, 0, self.frame.size.width-cellMargin, self.frame.size.height-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = self.defaultFooterView;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}
#pragma mark - getter
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

#pragma mark - getter
- (UIView *)defaultFooterView
{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
        _dataArray = [[self createCarouseUrls] mutableCopy];
    }
    
    return _defaultFooterView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  if ([indexPath row] == 0)
        return tableView.frame.size.width*55/400;
    else
        return tableView.frame.size.width*136/400;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row] == 0) {
        RankingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:RankingHeadCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"RankingHeaderCell" bundle:nil] forCellReuseIdentifier:RankingHeadCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:RankingHeadCellIdentifier];
        }
        return cell;
    }else{
        RankBean *bean = [self.dataArray objectAtIndex:[indexPath row]-1];
        RankOfCloudCell *cell = [tableView dequeueReusableCellWithIdentifier:RankOfCloudCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"RankOfCloudCell" bundle:nil] forCellReuseIdentifier:RankOfCloudCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:RankOfCloudCellIdentifier];
        }
        cell.bean = bean;
        return cell;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSArray *)createCarouseUrls{
    RankBean *bean1 = [[RankBean alloc] init];
    bean1.model = LRankTypeUp;
    bean1.firstItem = @"Green Light - Lorde";
    bean1.secondItem = @"I don't wanna Live Forever - zhou ";
    bean1.thirdItem = @"刚好遇见你 - 李玉刚";
    
    
    RankBean *bean2 = [[RankBean alloc] init];
    bean2.model = LRankTypeNew;
    bean2.firstItem = @"Green Light - Lorde";
    bean2.secondItem = @"I don't wanna Live Forever - zhou ";
    bean2.thirdItem = @"刚好遇见你 - 李玉刚";
    
    RankBean *bean3 = [[RankBean alloc] init];
    bean3.model = LRankTypeOriginal;
    bean3.firstItem = @"Green Light - Lorde";
    bean3.secondItem = @"I don't wanna Live Forever - zhou ";
    bean3.thirdItem = @"刚好遇见你 - 李玉刚";

    RankBean *bean4 = [[RankBean alloc] init];
    bean4.model = LRankTypeHot;
    bean4.firstItem = @"Green Light - Lorde";
    bean4.secondItem = @"I don't wanna Live Forever - zhou ";
    bean4.thirdItem = @"刚好遇见你 - 李玉刚";
    
    
    
    return @[bean1,bean2,bean3,bean4];
    
}


@end
