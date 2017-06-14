//
//  FriendController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "FriendController.h"
#import "LAttentionDetailView.h"
#import "LAttentionShareController.h"
#import "LNavigationController.h"
#import "LStatusCell.h"
#import "TZImagePickerController.h"
#import "YYPhotoGroupView.h"
#import "LAttentionDetailController.h"
#import "LShareManager.h"
#import "LAttentionPostController.h"
#import "LNearModel.h"
#import "LNearTableViewCell.h"
#import "UserCenterController.h"
@interface FriendController ()<LAttentionViewDelegate,LStatusCellDelegate,LNearViewDelegate,LNearTableViewCellDelegate>{
    CGFloat currentPlayMusicX;
}

@property(nonatomic, strong) LAttentionModel *orginalListModel;

@end

#define AnimationDuration 0.2////动画持续时间
#define playOriginalFrame  CGRectMake(S_WIDTH, 0, S_WIDTH, S_HEIGHT)

#define playChangedFrame  CGRectMake(0,0, S_WIDTH, S_HEIGHT)

@implementation FriendController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.attentionView;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        LAttentionModel *model = [[LAttentionModel alloc] init];
        LAttentionModel *model1 = [[LAttentionModel alloc] init];
        LAttentionModel *model2 = [[LAttentionModel alloc] init];
        LAttentionModel *model3 = [[LAttentionModel alloc] init];
        model.name = @"彗星0307";
        model.text = @"不懂爱恨情愁煎熬的我们 都以为相爱就像风云的善变 相信爱一天 抵过永远 在这一刹那冻结了时间 不懂怎么表现温柔的我们 还以为殉情只是古老的传言 离愁能有多痛 痛有多浓 当梦被埋在江南烟雨中 心碎了才懂";
        model.profileImageURL = [NSURL URLWithString:@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1079521111,2489227629&fm=23&gp=0.jpg"];
        WBPicture *p = [[WBPicture alloc] init];
        WBPicture *p1 = [[WBPicture alloc] init];
        WBPicture *p2 = [[WBPicture alloc] init];
        WBPictureMetadata *pd = [[WBPictureMetadata alloc] init];
        pd.url = [NSURL URLWithString:@"http://n1.itc.cn/img8/wb/recom/2015/11/28/144869250393816930.jpeg"];
        p.bmiddle = pd;
        WBPictureMetadata *pd1 = [[WBPictureMetadata alloc] init];
        pd1.url = [NSURL URLWithString:@"http://photocdn.sohu.com/20141111/Img405941780.jpg"];
        p1.bmiddle = pd1;
        WBPictureMetadata *pd2 = [[WBPictureMetadata alloc] init];
        pd2.url = [NSURL URLWithString:@"http://images.vrbeing.com/2016/1103/20161103120635457.jpg"];
        p2.bmiddle = pd2;
        model.retweetedStatus = model1;
        model.commentsCount = 0;
        model.attitudesCount = 3;
        model.repostsCount = 1;
        model.createdTime = @"3月28日";
        
        User *u = [[User alloc] init];
        u.avatar = [NSURL URLWithString:@"http://photocdn.sohu.com/20141111/Img405941780.jpg"];
        User *u1 = [[User alloc] init];
        u1.avatar = [NSURL URLWithString:@"http://images.vrbeing.com/2016/1103/20161103120635457.jpg"];
        User *u2 = [[User alloc] init];
        u2.avatar = [NSURL URLWithString:@"http://n1.itc.cn/img8/wb/recom/2015/11/28/144869250393816930.jpeg"];
        
        [model.linkPicIds addObject:u];
        [model.linkPicIds addObject:u1];
        [model.linkPicIds addObject:u2];
        
        model1.text = @"《一千年以后》是新加坡歌手林俊杰演唱的一首歌曲，由林俊杰作曲，李瑞洵，陈少琪填词";
        model1.name = @"Joeng";
        model1.profileImageURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494621274310&di=86e3c246a92b159df81389740cb00574&imgtype=0&src=http%3A%2F%2Fwww.yhxpt.com%2Fbook_cover%2Fbd19658567.jpg"];
        model1.pics = @[p,p1,p2];
        MusicModel *music = [[MusicModel alloc] init];
        music.name = @"一千年以后";
        music.icon = @"jj.jpg";
        music.singer = @"林俊杰";
        model1.shareMusic = music;
        model1.createdTime = @"3月28日";
        
        
        
        
        model2.text = @"《人间》讲述的是正在发生的进行时事件，有着独特的形式，结构和节目流程。";
        model2.name = @"和泉纱雾o_O";
        model2.profileImageURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494654219898&di=12d3de7f867b76b7eae66ceeca6fcb8e&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201512%2F19%2F20151219190821_MjGHm.thumb.224_0.jpeg"];
        MusicModel *music1 = [[MusicModel alloc] init];
        music1.name = @"传奇";
        music1.icon = @"wf.jpg";
        music1.singer = @"王菲";
        model2.shareMusic = music1;
        WBPicture *p3 = [[WBPicture alloc] init];
        WBPictureMetadata *pd3 = [[WBPictureMetadata alloc] init];
        pd3.url = [NSURL URLWithString:@"http://n1.itc.cn/img8/wb/recom/2015/11/28/144869250319383231.jpeg"];
        p3.bmiddle = pd3;
        p3.bmiddle.width = 632;
        p3.bmiddle.height = 388;
        p3.keepSize = false;
        model2.pics = @[p3];
        model2.createdTime = @"3月28日";
        
        
        model3.text = @"相爱难恨亦难 我的心碎了无痕！！！！";
        model3.name = @"小小团_";
        model3.profileImageURL = [NSURL URLWithString:@"https://b-ssl.duitang.com/uploads/item/201510/18/20151018102245_tSmE8.thumb.700_0.jpeg"];
        MusicModel *music2 = [[MusicModel alloc] init];
        music2.name = @"心碎了无痕";
        music2.icon = @"zxy.jpg";
        music2.singer = @"张学友";
        model3.shareMusic = music2;
        model3.createdTime = @"3月28日";
        
        
        LStatusLayout *layout = [[LStatusLayout alloc] initWithStatus:model style:WBLayoutStyleTimeline];
        LStatusLayout *layout1 = [[LStatusLayout alloc] initWithStatus:model1 style:WBLayoutStyleTimeline];
        LStatusLayout *layout2 = [[LStatusLayout alloc] initWithStatus:model2 style:WBLayoutStyleTimeline];
        LStatusLayout *layout3 = [[LStatusLayout alloc] initWithStatus:model3 style:WBLayoutStyleTimeline];
        [_attentionView.layouts addObject:layout];
        [_attentionView.layouts addObject:layout1];
        [_attentionView.layouts addObject:layout2];
        [_attentionView.layouts addObject:layout3];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_attentionView.tableView reloadData];
        });
        
        [LShareManager sharedInstance].friendC = self;
    });

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LAttentionView*)attentionView{
    if (!_attentionView) {
        _attentionView = [[LAttentionView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-64)];
        _attentionView.delegate = self;
    }
    return _attentionView;
}

-(LNearView*)nearView{
    if (!_nearView) {
        _nearView = [[LNearView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-64)];
        _nearView.delegate = self;
    }
    return _nearView;
}





#pragma mark - LAttentionViewDelegate

- (void)attentionView:(LAttentionView *)attentionView didSelectDetailModel:(LStatusLayout *)layout{
    LAttentionDetailController *dc = [[LAttentionDetailController alloc] init];
    dc.playingButton = self.playingButton;
    dc.dismiss = ^{;
        [self.attentionView.tableView reloadRowsAtIndexPaths:[self.attentionView.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    };
    [dc setLayout:layout];
    [self.rt_navigationController pushViewController:dc animated:YES complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}

- (void)attentionView:(LAttentionView *)attentionView didShareAction:(UIButton*)button{
    LAttentionShareController *shareController = [[LAttentionShareController alloc] init];
    LNavigationController *nav = [[LNavigationController alloc] initWithRootViewController:shareController];
    shareController.dismiss = ^{
        self.playingButton.alpha = 1;
        [nav dismissViewControllerAnimated:YES completion:NULL];
    };
    [self presentViewController:nav animated:YES completion:NULL];
    [UIView animateWithDuration:0.5 animations:^{
      self.playingButton.alpha = 0;
    } completion:nil];
 
    
}

#pragma mark - LStatusCellDelegate
/// 点击了图片
- (void)cell:(LStatusCell *)cell didClickImageAtIndex:(NSUInteger)index {
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray new];
    LAttentionModel *status = cell.statusView.layout.status;
    NSArray<WBPicture *> *pics = status.retweetedStatus ? status.retweetedStatus.pics : status.pics;
    
    for (NSUInteger i = 0, max = pics.count; i < max; i++) {
        UIView *imgView = cell.statusView.picViews[i];
        id pic = pics[i];
        if ([pic isKindOfClass:[WBPicture class]]) {
            WBPicture *pic;
            WBPictureMetadata *meta = pic.largest.badgeType == WBPictureBadgeTypeGIF ? pic.largest : pic.large;
            YYPhotoGroupItem *item = [YYPhotoGroupItem new];
            item.thumbView = imgView;
            item.largeImageURL = meta.url;
            item.largeImageSize = CGSizeMake(meta.width, meta.height);
            [items addObject:item];
            if (i == index) {
                fromView = imgView;
            }
        }else if([pic isKindOfClass:[UIImage class]]){
            YYPhotoGroupItem *item = [YYPhotoGroupItem new];
            item.thumbView = imgView;
            [items addObject:item];
            if (i == index) {
                fromView = imgView;
            };
        }
    }
    
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:self.navigationController.view animated:YES completion:nil];
}

-(void)cell:(LStatusCell *)cell didClickMusicCard:(LStatusCardView *)cardView{
    cardView.button.selected = !cardView.button.selected;
    LAttentionModel *status = cell.statusView.layout.status;
    self.orginalListModel.playing = false;
    self.orginalListModel.retweetedStatus.playing = false;
    if (cardView.button.selected) {
        LAttentionModel *status = cell.statusView.layout.status;
        NSString *name = status.retweetedStatus.shareMusic ? status.retweetedStatus.shareMusic.name:status.shareMusic.name;
        if ([name isEqualToString:[LAVPlayer sharedInstance].currentMusic.name]) {
            [[LAVPlayer sharedInstance] play];
        }else{
             [[LAVPlayer sharedInstance] playSongWithSongName:name listButton:cardView.button];
        }
        if (status.retweetedStatus) {
            status.retweetedStatus.playing = true;
        }else{
            status.playing = true;
        }
       
    }else{
        if (status.retweetedStatus) {
            status.retweetedStatus.playing = false;
        }else{
            status.playing = false;
        }
        [[LAVPlayer sharedInstance] pause];
    }
    //记录之前播放的
    self.orginalListModel = status;
}


- (void)cell:(LStatusCell *)cell didClickrepostButton:(UIButton *)button{
    LAttentionPostController *post = [[LAttentionPostController alloc] init];
    [post setLayout:cell.statusView.layout];
    post.dismiss = ^{
        self.playingButton.alpha = 1;
        [self.view endEditing:YES];
        [self.attentionView.tableView reloadRowsAtIndexPaths:[self.attentionView.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:post animated:YES ];
    [UIView animateWithDuration:0.5 animations:^{
        self.playingButton.alpha = 0;
    } completion:nil];
}


- (void)cell:(LStatusCell *)cell didClickcommentButton:(UIButton *)button{
    LAttentionDetailController *dc = [[LAttentionDetailController alloc] init];
    dc.upToBottom = true;
    dc.playingButton = self.playingButton;
    [dc setLayout:cell.statusView.layout];
    [self.rt_navigationController pushViewController:dc animated:YES complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}

- (void)cell:(LStatusCell *)cell didClickzanButton:(UIButton *)button{
    button.selected =! button.selected;
    LAttentionModel *status = cell.statusView.layout.status;
    int32_t count = status.attitudesCount;
    if (button.selected) {
        UIImageView *imgView1 = button.imageView;
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView setImage:[button imageForState:UIControlStateSelected]];
        imgView.center = imgView1.center;
        imgView.bounds = CGRectMake(0, 0, imgView1.frame.size.width, imgView1.frame.size.height);
        [button addSubview:imgView];
        [UIView animateWithDuration:0.5 animations:^{
            imgView.bounds = CGRectMake(0, 0, imgView1.frame.size.width*2, imgView1.frame.size.height*2);
            imgView.alpha = 0.5;
        } completion:^(BOOL finished) {
            [imgView removeFromSuperview];
        }];
        status.attitudesStatus = 1;
        count += 1;
        status.attitudesCount += 1;
        [status.linkPicIds addObject:[UserManager sharedInstance].user];
        
    }else{
        status.attitudesStatus = 0;
        count -= 1;
        status.attitudesCount -= 1;
        [status.linkPicIds removeObject:[UserManager sharedInstance].user];
    }
    [button setTitle:count <= 0 ? @"点赞" : [NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
}



-(void)showAttentionView{
    self.view = self.attentionView;
}

-(void)showNearView{
     self.view = self.nearView;
}


-(void)didClickMusicButtonOfCell:(LNearTableViewCell *)cell{
    if ([cell.model.song isEqualToString:[LAVPlayer sharedInstance].currentMusic.name]) {
        [[LAVPlayer sharedInstance] play];
    }else{
        [[LAVPlayer sharedInstance] playSongWithSongName:cell.model.song];
        [MBProgressHUD showSuccess:@"已添加到播放列表" toView:nil];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWPLAYMUSICVIEW object:nil];
}


- (void)didClicUserButtonOfCell:(LNearTableViewCell *)cell{
    LNearModel *model = cell.model;
    User *u = [[User alloc] init];
    u.avatar = model.user.avatar;
    u.name = model.user.name;
    u.dongtaiCount = 1;
    u.fansCount = 1;
    u.guanzhuCount = 1;
    u.lv = 5;
    u.sex = 1;
    u.headImage = [NSURL URLWithString:@"http://images.haiwainet.cn/2016/1025/20161025025455538.jpg"];
    u.jieshao = @"M01。";
    u.dizhi = @"上海";
    u.niandai = @"90后";
    u.xingzuo = @"双鱼座";
    [self _pushUserCenterControllerWithUser:u];
}

- (void)cell:(LStatusCell *)cell didClickAtName:(UIView*)view{
    LAttentionModel *model = cell.statusView.layout.status;
    User *u = [[User alloc] init];
    u.avatar = model.profileImageURL;
    u.name = model.name;
    u.dongtaiCount = 1;
    u.fansCount = 1;
    u.guanzhuCount = 1;
    u.lv = 5;
    u.sex = 1;
    u.headImage = [NSURL URLWithString:@"http://images.haiwainet.cn/2016/1025/20161025025455538.jpg"];
    u.jieshao = @"M01。";
    u.dizhi = @"上海";
    u.niandai = @"90后";
    u.xingzuo = @"双鱼座";
    [self _pushUserCenterControllerWithUser:u];
}

- (void)cell:(LStatusCell *)cell didClickProfileView:(UIView*)view{
    LAttentionModel *model = cell.statusView.layout.status;
    User *u = [[User alloc] init];
    u.avatar = model.profileImageURL;
    u.name = model.name;
    u.dongtaiCount = 1;
    u.fansCount = 1;
    u.guanzhuCount = 1;
    u.lv = 5;
    u.sex = 1;
    u.headImage = [NSURL URLWithString:@"http://images.haiwainet.cn/2016/1025/20161025025455538.jpg"];
    u.jieshao = @"M01。";
    u.dizhi = @"上海";
    u.niandai = @"90后";
    u.xingzuo = @"双鱼座";
    [self _pushUserCenterControllerWithUser:u];
}

-(void)_pushUserCenterControllerWithUser:(User*)user{
    //哈哈！！！！！
    UserCenterController *uc = [[UserCenterController alloc] initWithUserCenterController:user];
    [self.tabBarController addChildViewController:uc];
    CGRect rect = self.tabBarController.tabBar.frame;
    self.tabBarController.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y+64, rect.size.width, rect.size.height);
    self.tabBarController.delegate = uc;
    uc.dismiss = ^{
        self.tabBarController.tabBar.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        [self.navigationController.visibleViewController.view addSubview:self.tabBarController.tabBar];
    };
    [[[UIApplication sharedApplication] keyWindow] insertSubview:self.tabBarController.tabBar atIndex:1];
    [self.rt_navigationController pushViewController:uc animated:YES complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}

@end
