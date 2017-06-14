//
//  ColumSetController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "ColumSetController.h"
#import "ColumSetHeaderView.h"
#import "ColumSetFootView.h"
#import "ColumSetContentCell.h"
@interface ColumSetController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) NSMutableArray *columIdArray;

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIView *defaultFooterView;

@end

static NSString *ColumSetCellIdentifier = @"ColumSetCellIdentifier";

static NSString *ColumSetHeadIdentifier = @"ColumSetHeadIdentifier";

static NSString *ColumSetFootIdentifier = @"ColumSetFootIdentifier";



@implementation ColumSetController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"调整栏目顺序";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //数据加载
    [self initColumSetList];
    
    self.view.backgroundColor = MAINIBACKGROUNDCOLOR;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = self.defaultFooterView;
    _tableView.scrollEnabled = NO;
    [_tableView setEditing:YES animated:YES];
    [self.view addSubview:_tableView];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - getter
- (UIView *)defaultFooterView
{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _dataArray;
}
- (NSMutableArray *)columIdArray{
    if (!_columIdArray) {
        _columIdArray = [NSMutableArray arrayWithCapacity:5];
    }
    return _columIdArray;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath row] == 0) {
        return 50*H_SCALE;
    }
    return 60*H_SCALE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:
(NSIndexPath *)indexPath{
    if ([indexPath section] == 0 || [indexPath section] == 2) {
        return false;
    }
    return true;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return [self.dataArray count];
    }else if(section == 2){
        return 1;
    }else{
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0) {
        ColumSetHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:ColumSetCellIdentifier];
        if(cell==nil){
            cell = [[ColumSetHeaderView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColumSetCellIdentifier];
        }
        return cell;
    }else if([indexPath section] == 2 ){
        ColumSetFootView *cell = [tableView dequeueReusableCellWithIdentifier:ColumSetFootIdentifier];
        if(cell==nil){
            cell = [[ColumSetFootView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColumSetFootIdentifier];
        }
        return cell;
    }else{
        NSString *text =  [self.dataArray objectAtIndex:[indexPath row]];
        ColumSetContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ColumSetCellIdentifier];
        if(cell==nil){
            cell = [[ColumSetContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ColumSetCellIdentifier];
        }
        cell.label.text = text;
        return cell;
        
    }

}



- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if ([proposedDestinationIndexPath section] == 0 ) {
        if ([sourceIndexPath row] == 0) {
             return sourceIndexPath;
        }else{
            return [NSIndexPath indexPathForRow:0 inSection:1];
        }
    }else if([proposedDestinationIndexPath section] == 2){
        if ([sourceIndexPath row] == [self.dataArray count]-1) {
            return sourceIndexPath;
        }else{

            return [NSIndexPath indexPathForRow:[self.dataArray count]-1 inSection:1];
        }
    }else{
        return proposedDestinationIndexPath;
    }
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSInteger fromIndex = [sourceIndexPath row];
    NSInteger toIndex = [destinationIndexPath row];
    id obj = [self.columIdArray objectAtIndex:fromIndex];
    [self.columIdArray removeObjectAtIndex:fromIndex];
    [self.columIdArray insertObject:obj atIndex:toIndex];
    [self saveColumSetList:self.columIdArray];
}


#pragma  mark - handleDate

-(void)initColumSetList{
    NSArray *list = [UserDefaults getColumSetList];
    for (NSNumber *i in list) {
        [self.columIdArray addObject:i];
        switch ([i integerValue]) {
            case RecommendColumnCellTypeRecommend:
                [self.dataArray addObject:@"推荐歌单"];
                break;
            case RecommendColumnCellTypeExclusive:
                [self.dataArray addObject:@"独家放送"];
                break;
            case RecommendColumnCellTypeNewest:
                [self.dataArray addObject:@"最新音乐"];
                break;
            case RecommendColumnCellTypeMv:
                [self.dataArray addObject:@"推荐MV"];
                break;
            case RecommendColumnCellTypeRadio:
                [self.dataArray addObject:@"主播电台"];
                break;
                
            default:
                break;
        }
    }
}

-(void)saveColumSetList:(NSArray*)array{
    [UserDefaults setColumSetListArray:array];
}


@end
