//
//  LLrcScrollView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LLrcScrollView.h"
#import "LLrcCell.h"
@interface LLrcScrollView()<UITableViewDelegate,UITableViewDataSource>{
    BOOL dragging;
    BOOL btnPreFlag;
}

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIView *defaultFooterView;

@property(nonatomic, strong)UIView *indicateView;

@property(nonatomic, strong)UIButton *timeButton;

@property(nonatomic, strong)UILabel *timeLabel;

@property(nonatomic, strong)UIView *indicateContentView;

@property(nonatomic, strong)NSIndexPath *originalIndex;

/** 当前播放歌词的下标 */
@property (nonatomic,assign) NSInteger currentIndex;

@property (nonatomic,assign) NSTimeInterval currentIndicateTime;

@end

#define lrcPadding 10

static NSString *LLrcScrollViewCellIdentifier = @"LLrcScrollViewCellIdentifier";

@implementation LLrcScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
        _tableView.tableFooterView = self.defaultFooterView;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:_tableView];
        [self addSubview:self.indicateContentView];
        
        _tableView.contentInset=UIEdgeInsetsMake(self.frame.size.height*0.5, 0, self.frame.size.height*0.5, 0);
        
        dragging = false;
        btnPreFlag = false;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if ([self.dataArray count] > 0 ) {
       [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

#pragma mark - getter

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    return _defaultFooterView;
}


- (UIView *)indicateContentView{
    if (_indicateContentView == nil) {
        CGFloat height = [self lrcTimeImageSize].height;
        _indicateContentView = [[UIView alloc] initWithFrame:CGRectMake(0,(self.frame.size.height-height)*.5, self.frame.size.width, height)];
        [_indicateContentView addSubview:self.timeButton];
        [_indicateContentView addSubview:self.indicateView];
        [_indicateContentView addSubview:self.timeLabel];
        _indicateContentView.alpha = 0;
       
    }
    return _indicateContentView;
}


- (UIView *)indicateView{
    if (_indicateView == nil) {
        CGFloat padding = CGRectGetMaxX(_timeButton.frame);
        CGFloat height = 1;
        _indicateView = [[UIView alloc] initWithFrame:CGRectMake(padding,(_indicateContentView.frame.size.height-height)*.5, _indicateContentView.frame.size.width-2*padding, height)];
        _indicateView.backgroundColor = RGB(230, 230, 230, 1);
    }
    return _indicateView;
}

- (UIButton *)timeButton{
    if (_timeButton == nil) {
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setImage:[UIImage imageNamed:@"cm2_lrc_time_btn_play"] forState:UIControlStateNormal];
        [_timeButton setImage:[UIImage imageNamed:@"cm2_lrc_time_btn_play"] forState:UIControlStateHighlighted];
        _timeButton.frame = (CGRect){CGPointZero,[self lrcTimeImageSize]};
        [_timeButton addTarget:self action:@selector(timeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeButton;
}

-(CGSize)lrcTimeImageSize{
    return [UIImage imageNamed:@"cm2_lrc_time_btn_play"].size;
}

- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
         CGSize size  = [self lrcTimeImageSize];
        _timeLabel.font = Font(size.height*.3);
        _timeLabel.text = @"00:00";
        _timeLabel.textColor = RGB(230, 230, 230, 1);
        _timeLabel.frame = CGRectMake(CGRectGetMaxX(_indicateView.frame), 0, size.width, size.height);
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}



- (IBAction)timeButtonAction:(UIButton *)button{
 
    if ([self.delegate respondsToSelector:@selector(lrcScrollView:currentIndicateTime:)]) {
        btnPreFlag = true;
        [self.delegate lrcScrollView:self currentIndicateTime:self.currentIndicateTime];
    }
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:LLrcScrollViewCellIdentifier];
    if(cell==nil){
        cell=[[LLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LLrcScrollViewCellIdentifier];
        cell.lrcLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:[self lrcTimeImageSize].height*.5];
        
    }
    LMusicLrcModel *lrcModel = self.dataArray[indexPath.row];
    cell.lrcLabel.text = lrcModel.text;
    cell.lrcLabel.textColor=RGB(210, 210, 210, 0.8);
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self lrcTimeImageSize].height+lrcPadding;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if(scrollView.contentOffset.y < 0)
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    else{
        CGRect rect=[_indicateView convertRect:_indicateView.bounds toView:_tableView];
        NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:rect.origin];
        
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGRect rect=[_indicateView convertRect:_indicateView.bounds toView:_tableView];
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:rect.origin];
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideIndicateContentView) withObject:nil afterDelay:5];
    [self performSelector:@selector(DraggingCancel) withObject:nil afterDelay:5];
   
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    dragging = true;
    _indicateContentView.alpha = 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect rect=[_indicateView convertRect:_indicateView.bounds toView:_tableView];
    NSIndexPath *indexPath=[_tableView indexPathForRowAtPoint:rect.origin];
    if ([self.dataArray count]>0&& indexPath) {
        LMusicLrcModel *lrcModel = self.dataArray[indexPath.row];
        self.timeLabel.text =  [self getCurrentTime:lrcModel.time];
        self.currentIndicateTime = lrcModel.time;
    }else if([self.dataArray count]>0&& !indexPath && scrollView.contentOffset.y > 0){
        LMusicLrcModel *lrcModel = [self.dataArray lastObject];
        self.timeLabel.text =  [self getCurrentTime:lrcModel.time];
        self.currentIndicateTime = lrcModel.time;
    }else if([self.dataArray count]>0&& !indexPath && scrollView.contentOffset.y < 0){
        LMusicLrcModel *lrcModel = [self.dataArray firstObject];
        self.timeLabel.text =  [self getCurrentTime:lrcModel.time];
        self.currentIndicateTime = lrcModel.time;
    }
    LLrcCell *selectedCell=[_tableView cellForRowAtIndexPath:indexPath];
    
    LLrcCell *originalCell=[_tableView cellForRowAtIndexPath:self.originalIndex];
    
    if (self.originalIndex!=indexPath) {
        originalCell.lrcLabel.textColor=RGB(210, 210, 210, 0.8);
    }
    selectedCell.lrcLabel.textColor=[UIColor whiteColor];
    self.originalIndex=indexPath;
    
}

-(NSString *)getCurrentTime:(NSTimeInterval)time{
    NSInteger totalT = time;
    NSInteger proMin = totalT / 60;//当前秒
    NSInteger proSec = totalT % 60;//当前分钟

    return [NSString stringWithFormat:@"%02zd:%02zd", proMin, proSec];
}


-(void)DraggingCancel{
    dragging = false;
}

-(void)hideIndicateContentView{
    _indicateContentView.alpha = 0;
}

-(void)reloadData{
    [_tableView reloadData];
}







-(void)setCurrentTime:(NSTimeInterval)currentTime{
    
    _currentTime = currentTime;
    
    [self.dataArray enumerateObjectsUsingBlock:^(LMusicLrcModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSInteger count = self.dataArray.count;
        
        NSInteger nextIndex = idx + 1;
        
        LMusicLrcModel *nextLrcLine = nil;
        
        if (nextIndex < count) {
            
            nextLrcLine = self.dataArray[nextIndex];
            
        }
        
        if (self.currentIndex != idx && currentTime >= obj.time && currentTime < nextLrcLine.time) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            if (dragging == false && btnPreFlag == false) {
                [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            }
            
            self.currentIndex = idx;
            btnPreFlag = false;
            *stop = YES;
            
        }
        
    }];
    
}




@end
