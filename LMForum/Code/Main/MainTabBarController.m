//
//  MainTabBarController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "MainTabBarController.h"
#import "FindMusicController.h"
#import "MyMusicController.h"
#import "FriendController.h"
#import "AccountController.h"
#import "LSearchBar.h"

@interface MainTabBarController ()<LSearchBarDelegate,LPlayMusicViewDelegate>{
    //playbutton在bar上的frame;
    CGRect playBtnFram;
    
    CGFloat currentPlayMusicX;
}

@property(nonatomic , strong)FindMusicController *fdMusicC;

@property(nonatomic , strong)MyMusicController *myMusicC;

@property(nonatomic , strong)FriendController *friendC;

@property(nonatomic , strong)AccountController *accountC;

@property(nonatomic , strong)UISegmentedControl *segC;

//BarButtonItem
@property(nonatomic , strong)UIBarButtonItem *playBtnItem;
@property(nonatomic , strong)UIBarButtonItem *micBtnItem;
@property(nonatomic , strong)UIBarButtonItem *moreBtnItem;
@property(nonatomic , strong)UIBarButtonItem *inviteBtnItem;

//spaceButton
@property(nonatomic , strong)UIBarButtonItem *spaceL;
@property(nonatomic , strong)UIBarButtonItem *spaceR;

//BarButton
@property(nonatomic , strong)UIButton *playButton;
@property(nonatomic , strong)UIButton *micButton;
@property(nonatomic , strong)UIButton *inviteButton;

//search
@property(nonatomic , strong)LSearchBar *searL;

//playingButton
@property(nonatomic , strong)UIButton *playingButton;

@property(nonatomic , strong)LPlayMusicView *playMusicView;


@end



#define AnimationDuration 0.2////动画持续时间

#define playOriginalFrame  CGRectMake(S_WIDTH, 0, S_WIDTH, S_HEIGHT)

#define playChangedFrame  CGRectMake(0,0, S_WIDTH, S_HEIGHT)



@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    [self initTabViews];
    
    currentPlayMusicX = 0;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    if (_playingButton) {
//        [_playingButton removeFromSuperview];
//    }
    self.playBtnItem.customView.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.playingButton];
    self.searL.playButton = _playingButton;
    self.friendC.playingButton = self.playingButton;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playAction:) name:SHOWPLAYMUSICVIEW object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)initTabViews{
    //设置tabBar
   // self.tabBar.barTintColor = RGB(7, 7, 7, 1);
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"cm2_btm_bg"]];
    //选中之后不会出现蓝色
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor whiteColor];

    
    //BarButton
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing"] forState:UIControlStateNormal];
    _playButton.bounds = CGRectMake(0, 0, 50, 30);
    self.playBtnItem =  [[UIBarButtonItem alloc]initWithCustomView:_playButton];
    [_playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    _micButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_micButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_mic"] forState:UIControlStateNormal];
    _micButton.bounds = CGRectMake(0, 0, 50, 30);
    self.micBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_micButton];
    
    
    self.moreBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction:)];
    
    
    _inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_inviteButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_invite"] forState:UIControlStateNormal];
    _inviteButton.bounds = CGRectMake(0, 0, 50, 30);
    self.inviteBtnItem = [[UIBarButtonItem alloc]initWithCustomView:_inviteButton];

    
    //space
    self.spaceR = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.spaceL = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.spaceL.width = -20.0f;
    self.spaceR.width = -20.0f;
    
 
    

    //发现音乐
    self.fdMusicC = [[FindMusicController alloc] init];
    self.fdMusicC.tabBarItem.title = NSLocalizedString(@"findmusic",@"");
    self.fdMusicC.tabBarItem.tag = 0;
    //设置未选中时的字体颜色
    [self unSelectedTapTabBarItems:self.fdMusicC.tabBarItem];
    //设置未选中时的字体颜色
    [self selectedTapTabBarItems:self.fdMusicC.tabBarItem];
    //设置选中和未选中时的图片
    self.fdMusicC.tabBarItem.image = [UIImage imageNamed:@"cm2_btm_icn_discovery"];
    self.fdMusicC.tabBarItem.selectedImage = [UIImage imageNamed:@"cm2_btm_icn_discovery_prs"];

    
    
    //我的音乐
    self.myMusicC = [[MyMusicController alloc] init];
    self.myMusicC.tabBarItem.title = NSLocalizedString(@"mymusic",@"");
    self.myMusicC.tabBarItem.tag = 1;
    //设置未选中时的字体颜色
    [self unSelectedTapTabBarItems:self.myMusicC.tabBarItem];
    //设置未选中时的字体颜色
    [self selectedTapTabBarItems:self.myMusicC.tabBarItem];
    self.myMusicC.tabBarItem.image = [UIImage imageNamed:@"cm2_btm_icn_music"];
    self.myMusicC.tabBarItem.selectedImage = [UIImage imageNamed:@"cm2_btm_icn_music_prs"];

    
    //朋友
    self.friendC = [[FriendController alloc] init];
    self.friendC.tabBarItem.title = NSLocalizedString(@"friend",@"");
    self.friendC.tabBarItem.tag = 2;
    
    //设置未选中时的字体颜色
    [self unSelectedTapTabBarItems:self.friendC.tabBarItem];
    //设置未选中时的字体颜色
    [self selectedTapTabBarItems:self.friendC.tabBarItem];
    self.friendC.tabBarItem.image = [UIImage imageNamed:@"cm2_btm_icn_friend"];
    self.friendC.tabBarItem.selectedImage = [UIImage imageNamed:@"cm2_btm_icn_friend_prs"];

    
    //账号
    self.accountC = [[AccountController alloc] init];
    self.accountC.tabBarItem.title = NSLocalizedString(@"account",@"");
    self.accountC.tabBarItem.tag = 3;
    //设置未选中时的字体颜色
    [self unSelectedTapTabBarItems:self.accountC.tabBarItem];
    //设置未选中时的字体颜色
    [self selectedTapTabBarItems:self.accountC.tabBarItem];
    self.accountC.tabBarItem.image = [UIImage imageNamed:@"cm2_btm_icn_account"];
    self.accountC.tabBarItem.selectedImage = [UIImage imageNamed:@"cm2_btm_icn_account_prs"];
    
    
    //添加到控制器
    [self addChildViewController:self.fdMusicC];
    [self addChildViewController:self.myMusicC];
    [self addChildViewController:self.friendC];
    [self addChildViewController:self.accountC];
    
    //默认首页
    [self initFirtItem];
 
}
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem {
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont systemFontOfSize:H5], NSFontAttributeName,
                                            nil] forState:UIControlStateNormal];
}
-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem {
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIFont fontWithName:@"Helvetica" size:H5], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]
                                                    forState:UIControlStateHighlighted];

}
#pragma mark - UITabBarDelegate
    
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
        if (item.tag == 0) {
            self.navigationItem.titleView = self.searL;
            self.navigationItem.leftBarButtonItem = nil;
            self.title = NSLocalizedString(@"findmusic",@"");
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.spaceL, self.micBtnItem, nil];
        }else if (item.tag == 1){
            self.navigationItem.titleView = nil;
            self.navigationItem.leftBarButtonItems = nil;
            self.navigationItem.leftBarButtonItem = self.moreBtnItem;
            self.title = NSLocalizedString(@"title.mymusic",@"");
        }else if (item.tag == 2){
            self.navigationItem.titleView = self.segC;
            self.navigationItem.leftBarButtonItem = nil;
            self.title = NSLocalizedString(@"friend",@"");
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.spaceL, self.inviteBtnItem, nil];
        }else if (item.tag == 3){
            self.navigationItem.titleView = nil;
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.leftBarButtonItems = nil;
            self.title = NSLocalizedString(@"title.account", @"");
        }
        self.playBtnItem.customView.alpha = 0;
}


#pragma mark - LSearchBarDelegate
//点击搜索框编辑文字时
-(BOOL)searchBarShouldBeginEditing:(LSearchBar *)searchBar{

    CGRect toRect = (CGRect) {{searchBar.frame.origin.x-44, searchBar.frame.origin.y},
        {searchBar.frame.size.width+44, searchBar.frame.size.height}};
    self.navigationItem.leftBarButtonItems = nil;
    searchBar.frame = toRect;
    return true;
}

-(void)searchBarCancelButtonClicked:(LSearchBar *)searchBar{
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.spaceL, self.micBtnItem, nil];
}

#pragma mark - LPlayMusicViewDelegate

- (void)playMusicView:(LPlayMusicView *)playMusicView returnToPrevious:(BOOL)back{
    if (back == true){
        [self hidePlayMusic];
    }
}

-(void)playMusicView:(LPlayMusicView *)playMusicView translateX:(CGFloat)translateX{
    CGFloat ratio = (translateX+currentPlayMusicX) / S_WIDTH;
    if (translateX>=0) {
        self.navigationController.view.frame = [self changingFrameByTranslateX:ratio];
        self.playMusicView.frame = CGRectMake(S_WIDTH*ratio, 0, S_WIDTH, S_HEIGHT);
    }else{
        if (currentPlayMusicX+translateX>=0){
          self.playMusicView.frame = CGRectMake(currentPlayMusicX+translateX, 0, S_WIDTH, S_HEIGHT);
           self.navigationController.view.frame = [self changingFrameByTranslateX:ratio];
        }else{
            self.playMusicView.frame = CGRectMake(0, 0, S_WIDTH, S_HEIGHT);
            self.playMusicView.frame = playChangedFrame;
        }
    }
    
}

-(void)playMusicView:(LPlayMusicView *)playMusicView translateEnd:(BOOL)end{
    if (end) {
        if (self.playMusicView.frame.origin.x > S_WIDTH*.5) {
            [self hidePlayMusic];
        }else{
            [self showPlayMusic];
        }
        currentPlayMusicX = self.playMusicView.frame.origin.x;
    }
}

#pragma mark - getter
-(LSearchBar * )searL{
    if(!_searL){
        _searL = [[LSearchBar alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, 30)];
        _searL.placeholder = NSLocalizedString(@"title.search", @"Search");
        _searL.delegate = self;
        
    }
    return _searL;
}

-(UISegmentedControl*)segC{
    if (!_segC) {
        _segC = [[UISegmentedControl alloc] initWithItems:@[@"关注",@"附近"]];
        _segC.bounds = CGRectMake(0, 0, S_WIDTH*0.45,64*0.45);
        [_segC setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"Helvetica" size:16.0], NSFontAttributeName,nil] forState:UIControlStateNormal];
        _segC.selectedSegmentIndex = 0;
        _segC.tintColor = [UIColor whiteColor];
        [_segC addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    }
    return _segC;
}

-(UIButton*)playingButton{
    if (!_playingButton) {
        CGRect playBtnFm = [self.playButton convertRect:self.playButton.bounds toView:[[UIApplication sharedApplication] keyWindow]];
        _playingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playingButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_playing"] forState:UIControlStateNormal];
        _playingButton.imageView.animationImages = @[[UIImage imageNamed:@"cm2_topbar_icn_playing"],[UIImage imageNamed:@"cm2_topbar_icn_playing2"],[UIImage imageNamed:@"cm2_topbar_icn_playing3"],[UIImage imageNamed:@"cm2_topbar_icn_playing4"],[UIImage imageNamed:@"cm2_topbar_icn_playing5"],[UIImage imageNamed:@"cm2_topbar_icn_playing6"],[UIImage imageNamed:@"cm2_topbar_icn_playing5"],[UIImage imageNamed:@"cm2_topbar_icn_playing4"],[UIImage imageNamed:@"cm2_topbar_icn_playing3"],[UIImage imageNamed:@"cm2_topbar_icn_playing2"]];
        _playingButton.imageView.animationDuration = 1;
        _playingButton.imageView.animationRepeatCount = 0;
        _playingButton.frame = playBtnFm;
        [_playingButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
        [LAVPlayer sharedInstance].playStatBtn = _playingButton;
    }
    return _playingButton;
}


-(LPlayMusicView*)playMusicView{
    if (!_playMusicView) {
        _playMusicView = [[LPlayMusicView alloc] initWithFrame:playOriginalFrame];
        _playMusicView.delegate = self;
    }
    return _playMusicView;
}

-(CGRect)originalFrame{
    return CGRectMake(0, 0, S_WIDTH, S_HEIGHT);
}
-(CGRect)changedFrame{
    return CGRectMake(-S_WIDTH*0.25, 0, S_WIDTH, S_HEIGHT);
}

-(CGRect)changingFrameByTranslateX:(CGFloat)ratio{
    if (ratio>0) {
        return CGRectMake(S_WIDTH*0.25*(ratio-1), 0, S_WIDTH, S_HEIGHT);
    }else{
        return CGRectMake(-S_WIDTH*0.25*(1+ratio), 0, S_WIDTH, S_HEIGHT);
    }
    
}
#pragma mark - private
-(void)initFirtItem{
    self.selectedIndex = 0;
    self.navigationItem.titleView = self.searL;
    self.navigationItem.title = NSLocalizedString(@"findmusic",@"");
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.spaceL, self.micBtnItem, nil];
    //添加playBtnItem
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.spaceR, self.playBtnItem, nil];
    
}

-(void)showPlayMusic{
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.playMusicView.frame = playChangedFrame;
        self.navigationController.view.frame = [self changedFrame];
    } completion:^(BOOL finished) {
        [_playMusicView startScrollLabel];
        _playingButton.alpha = 0;
    }];
}
-(void)hidePlayMusic{
    [UIView animateWithDuration:AnimationDuration animations:^{
        _playMusicView.frame = playOriginalFrame;
        self.navigationController.view.frame = [self originalFrame];
    } completion:^(BOOL finished) {
        [_playMusicView resetScroll];
        _playingButton.alpha = 1;
    }];
}



#pragma mark - action

-(void)segmentAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [_friendC showAttentionView];
            break;
        case 1:
            [_friendC showNearView];
            break;
        default:  
            break;  
    }

}
- (void)playAction:(id)sender{
    
   [[[UIApplication sharedApplication] keyWindow] insertSubview:self.playMusicView belowSubview:self.playingButton];
   [self showPlayMusic];
    
    currentPlayMusicX = 0;
}

- (void)micAction:(UIButton *)button{
    
}
- (void)moreAction:(UIButton *)button{
    
}
- (void)invite:(UIButton *)button{
    
}
@end
