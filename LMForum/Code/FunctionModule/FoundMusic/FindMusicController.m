//
//  FoundMusicController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "FindMusicController.h"
#import "LHorizontalSelection.h"
#import "RecommendController.h"
#import "SingMenuController.h"
#import "RadioController.h"
#import "RankingController.h"
#import "ColumSetController.h"

@interface FindMusicController ()<LHorizontalSelectionDelegate,LHorizontalSelectionDataSource,UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)LHorizontalSelection *htSelection;

@property(nonatomic, strong)RecommendController *recC;

@property(nonatomic, strong)SingMenuController *singMC;

@property(nonatomic, strong)RadioController *radioC;

@property(nonatomic, strong)RankingController *rankC;


@end

@implementation FindMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    NSArray *itemNameArry = @[@"个性推荐",
                               @"歌单",
                               @"主播电台",
                               @"排行榜"];
    _htSelection = [[LHorizontalSelection alloc] initWithFrame:CGRectMake(0,0, S_WIDTH, ceilf(S_HEIGHT*0.07))itemNameArry:itemNameArry];
    _htSelection.delegate = self;
    _htSelection.selectionIndicatorColor = [UIColor colorWithPatternImage:MAINIMAGECOLOR];
    _htSelection.bottomTrimColor = RGB(186, 186, 186, 1);
    _htSelection.backgroundColor = RGB(245, 245, 245, 1);
    _htSelection.tintColor = [UIColor colorWithPatternImage:MAINIMAGECOLOR];
    [_htSelection setTitleColor:RGB(38, 38, 38, 1) forState:UIControlStateNormal];
    [self.view addSubview:_htSelection];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _htSelection.frame.size.height,S_WIDTH, self.view.frame.size.height-_htSelection.frame.size.height)];
    _scrollView.contentSize = CGSizeMake([itemNameArry count]*S_WIDTH,self.view.frame.size.height-_htSelection.frame.size.height-64);
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    [self initViewList];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initViewList{
    _recC = [[RecommendController alloc] init];
    _recC.view.frame = CGRectMake(0,0,_scrollView.frame.size.width,_scrollView.frame.size.height);
    
    _singMC = [[SingMenuController alloc] init];
    _singMC.view.frame = CGRectMake(S_WIDTH,0,_scrollView.frame.size.width,_scrollView.frame.size.height);
    
    _radioC = [[RadioController alloc] init];
    _radioC.view.frame = CGRectMake(S_WIDTH*2,0, _scrollView.frame.size.width,_scrollView.frame.size.height);
    
    _rankC = [[RankingController alloc] init];
    _rankC.view.frame = CGRectMake(S_WIDTH*3,0, _scrollView.frame.size.width,_scrollView.frame.size.height);
    
    
    [self addChildViewController:_recC];
    [self addChildViewController:_singMC];
    [self addChildViewController:_radioC];
    [self addChildViewController:_rankC];
    
    [_scrollView addSubview:_recC.view];
    [_scrollView addSubview:_singMC.view];
    [_scrollView addSubview:_radioC.view];
    [_scrollView addSubview:_rankC.view];
    
}

#pragma mark - LHorizontalSelectionDelegate
- (void)selectionList:(LHorizontalSelection *)selection didSelectButtonWithIndex:(NSInteger)index{
    
    [_scrollView scrollRectToVisible:CGRectMake(index*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)animated:NO];
}

#pragma mark - UICollectionViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSUInteger pageBeforeIndex = _htSelection.selectedButtonIndex;
    
    CGFloat oldPointX=pageBeforeIndex*scrollView.frame.size.width;
    
    CGFloat ratio=(scrollView.contentOffset.x-oldPointX)/scrollView.frame.size.width;
 
    [_htSelection selectionIndicatorBarScrollRatio:ratio pageWidth:scrollView.frame.size.width currentScrollWidth:scrollView.contentOffset.x];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView* )scrollView{
    
}
@end
