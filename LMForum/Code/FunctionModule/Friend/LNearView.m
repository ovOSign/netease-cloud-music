//
//  LNearView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LNearView.h"
#import "LNearTableViewCell.h"
@interface LNearView()<UITableViewDelegate,UITableViewDataSource,LNearTableViewCellDelegate>

@property(nonatomic, strong)UIView *defaultFooterView;

@end

@implementation LNearView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = self.defaultFooterView;
        _tableView.allowsSelection = NO;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_tableView];
        _layouts = [NSMutableArray new];
        User *u = [[User alloc] init];
        u.avatar = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201510/30/20151030221030_xSkWe.thumb.700_0.png"];
        u.name = @"sunnshy";
        u.sex = 1;
        LNearModel *model = [[LNearModel alloc] init];
        model.user = u;
        model.song = @"传奇";
        model.singer = @"王菲";
        model.distance = @"0.02km";
        model.time = @"昨天 07:21";
        
        
        User *u1 = [[User alloc] init];
        u1.avatar = [NSURL URLWithString:@"https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D600%2C800/sign=2b613ffd043b5bb5be8228f806e3f901/b21c8701a18b87d6242a9549000828381f30fd7f.jpg"];
        u1.name = @"睹物思人";
        u1.sex = 0;
        LNearModel *model1 = [[LNearModel alloc] init];
        model1.user = u1;
        model1.song = @"简单爱";
        model1.singer = @"周杰伦";
        model1.distance = @"0.05km";
        model1.time = @"5月9日";
        
        
        User *u2 = [[User alloc] init];
        u2.avatar = [NSURL URLWithString:@"https://gss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D600%2C800/sign=61d7e138d6ca7bcb7d2ecf298e39475b/42a98226cffc1e17995b54ca4b90f603728de961.jpg"];
        u2.name = @"稀有的响指";
        u2.sex = 0;
        LNearModel *model2 = [[LNearModel alloc] init];
        model2.user = u2;
        model2.song = @"泡沫";
        model2.singer = @"G.E.M.邓紫棋";
        model2.distance = @"0.02km";
        model2.time = @"5月8日";
        
        User *u3 = [[User alloc] init];
        u3.avatar = [NSURL URLWithString:@"http://v1.qzone.cc/avatar/201401/11/12/17/52d0c5d03ad7b387.jpg!200x200.jpg"];
        u3.name = @"梦亦如年";
        u3.sex = 0;
        LNearModel *model3 = [[LNearModel alloc] init];
        model3.user = u3;
        model3.song = @"小苹果";
        model3.singer = @"筷子兄弟";
        model3.distance = @"0.02km";
        model3.time = @"5月8日";
        
        
        User *u4 = [[User alloc] init];
        u4.avatar = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201510/30/20151030220955_38rvd.thumb.700_0.png"];
        u4.name = @"Myseital";
        u4.sex = 1;
        LNearModel *model4 = [[LNearModel alloc] init];
        model4.user = u4;
        model4.song = @"瓦解";
        model4.singer = @"南拳妈妈";
        model4.distance = @"0.01km";
        model4.time = @"5月6日";
        
        
        User *u5 = [[User alloc] init];
        u5.avatar = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201405/11/20140511205027_jLfBP.thumb.700_0.jpeg"];
        u5.name = @"haojianlou";
        u5.sex = 0;
        LNearModel *model5 = [[LNearModel alloc] init];
        model5.user = u5;
        model5.song = @"暧昧";
        model5.singer = @"薛之谦";
        model5.distance = @"0.01km";
        model5.time = @"昨天 20:38";
        
        User *u6 = [[User alloc] init];
        u6.avatar = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201504/28/20150428105428_SNFaZ.thumb.700_0.jpeg"];
        u6.name = @"绿菜菜";
        u6.sex = 1;
        LNearModel *model6 = [[LNearModel alloc] init];
        model6.user = u6;
        model6.song = @"Wisdom";
        model6.singer = @"The Guggenheim";
        model6.distance = @"0.01km";
        model6.time = @"5月10日";
       
        User *u7 = [[User alloc] init];
        u7.avatar = [NSURL URLWithString:@"https://a-ssl.duitang.com/uploads/item/201504/24/20150424H4340_Gi2Ax.thumb.700_0.jpeg"];
        u7.name = @"Myseital";
        u7.sex = 1;
        LNearModel *model7 = [[LNearModel alloc] init];
        model7.user = u7;
        model7.song = @"你";
        model7.singer = @"尚雯婕";
        model7.distance = @"0.01km";
        model7.time = @"5月6日";
        
        [_layouts addObject:model];
        [_layouts addObject:model1];
        [_layouts addObject:model2];
        [_layouts addObject:model3];
        [_layouts addObject:model4];
        [_layouts addObject:model5];
        [_layouts addObject:model6];
        [_layouts addObject:model7];
    }
    return self;
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
    return [_layouts count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = @"LNearTableViewCell";
    LNearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"LNearTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    }
    //xib if语句只调用一次。
    cell.delegate = (id<LNearTableViewCellDelegate>)_delegate;
    [cell setModel:_layouts[indexPath.row]];
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.frame.size.width*135/400;
}


@end
