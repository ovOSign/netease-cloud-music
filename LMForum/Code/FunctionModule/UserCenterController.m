//
//  UserCenterController.m
//  LMForum
//
//  Created by 梁海军 on 2017/5/15.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "UserCenterController.h"
#import "UserHeadCell.h"
#import "LSongMenuCell.h"
#import "LSongMenuHeadView.h"
#import "UIImage+BoxBlur.h"
@interface UserCenterController ()<UITableViewDelegate,UITableViewDataSource,UserHeadCellDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic,strong) UIView *defaultFooterView;

@property (nonatomic,strong) UIImageView *headBackView;

@property (nonatomic,strong) UIImage *headImage;

@property (nonatomic, strong) NSMutableArray *createMenuArray;

@property (nonatomic, strong) NSMutableArray *colMenuArray;

@property (strong, nonatomic) LSongMenuHeadView* createHeader;

@property (strong, nonatomic) LSongMenuHeadView* colHeader;

@end

static NSString *HeadCellCellIdentifier = @"HeadCellCellIdentifier";

static NSString *SongMenuCellCellIdentifier = @"SongMenuCellCellIdentifier";

static const CGFloat headHeight = 250;

@implementation UserCenterController

- (instancetype)initWithUserCenterController:(id)user{
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINIBACKGROUNDCOLOR;
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:_user.name];
    customLab.font = Font(20);
    customLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = customLab;
    
    [self.view addSubview:self.headBackView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = self.defaultFooterView;
    [self.view addSubview:_tableView];
    
    
    if ([self.user.headImage isKindOfClass:[NSURL class]]) {
        [self.headBackView sd_setImageWithURL:self.user.headImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _headImage = image;
        }];
    }else if([self.user.headImage  isKindOfClass:[NSString class]]) {
        [self.headBackView setImage:[UIImage imageNamed:self.user.headImage]];
        _headImage = [UIImage imageNamed:self.user.headImage];
    }else{
        [self.headBackView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
        _headImage = [UIImage imageNamed:@"cm2_lay_pic_buy_default"];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //隐藏细线
    self.navigationController.navigationBar.layer.masksToBounds=YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_dismiss) _dismiss();
}

#pragma mark - getter
- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}


-(LSongMenuHeadView*)createHeader{
    if (!_createHeader) {
        _createHeader = [[[NSBundle mainBundle] loadNibNamed: @"LSongMenuHeadView"
                                                       owner: self
                                                     options: nil] lastObject];
        _createHeader.state = MenuHeadStateDown;
        _createHeader.title.text = @"歌单 (1)";
        _createHeader.backgroundColor = [UIColor clearColor];
    }
    return _createHeader;
}

-(LSongMenuHeadView*)colHeader{
    if (!_colHeader) {
        _colHeader = [[[NSBundle mainBundle] loadNibNamed: @"LSongMenuHeadView"
                                                    owner: self
                                                  options: nil] lastObject];
        _colHeader.state = MenuHeadStateDown;
        _colHeader.title.text = @"收藏的歌单 (3)";
        _colHeader.backgroundColor = [UIColor clearColor];
    }
    return _colHeader;
}

-(NSMutableArray *)colMenuArray{
    if (!_colMenuArray) {
        _colMenuArray = [NSMutableArray array];
        MyMusicColumMenuModel *model = [[MyMusicColumMenuModel alloc] init];
        model.image = @"http://img0.c.yinyuetai.com/others/frontPageRec/161201/0/-M-ff7222eaf4d8236bb9df0522980b6ee7_0x0.jpg";
        model.itemName = @"【欧美】有种爱好觉：列表循环";
        model.num = @"233首";
        model.person = @"by 樱花深木";
        MyMusicColumMenuModel *model1 = [[MyMusicColumMenuModel alloc] init];
        model1.image = @"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg";
        model1.itemName = @"北大图书馆闭馆音乐备选列表";
        model1.num = @"393首";
        model1.person = @"by 放假哦哦i哦i";
        
        MyMusicColumMenuModel *model2 = [[MyMusicColumMenuModel alloc] init];
        model2.image = @"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4b79c8ac3571ea9675bbb613d3325beb_0x0.jpg";
        model2.itemName = @"100首经典英文老歌。 （3）";
        model2.num = @"100首";
        model2.person = @"by 音乐分享达人";
        [_colMenuArray addObject:model];
        [_colMenuArray addObject:model1];
        [_colMenuArray addObject:model2];
    }
    return _colMenuArray;
}

-(NSMutableArray *)createMenuArray{
    if (!_createMenuArray) {
        _createMenuArray = [NSMutableArray array];
        MyMusicColumMenuModel *model = [[MyMusicColumMenuModel alloc] init];
        model.image = @"http://img1.c.yinyuetai.com/others/frontPageRec/161213/0/-M-cc41300165c0162ae48aa878bbe3d04a_0x0.jpg";
        model.itemName = [NSString stringWithFormat:@"%@的喜欢的音乐",_user.name] ;
        model.num = @"3首";
        [_createMenuArray addObject:model];
        
    }
    return _createMenuArray;
}



- (UIImageView*)headBackView{
    if (!_headBackView) {
        _headBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width*headHeight/400+64)];
        _headBackView.contentMode = UIViewContentModeScaleAspectFill;
        _headBackView.layer.masksToBounds = YES;
        
    }
    return _headBackView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else  if (section == 1) {
        return [self.createMenuArray count];
    }else  if (section == 2) {
        return [self.colMenuArray count];
    }else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([indexPath section] == 0){
        UserHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadCellCellIdentifier];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"UserHeadCell" bundle:nil] forCellReuseIdentifier:HeadCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:HeadCellCellIdentifier];
            cell.delegate = self;
            [cell setUser:self.user];
        }
        return cell;
    }else if ([indexPath section] == 1) {
        LSongMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        MyMusicColumMenuModel *menuModel = [self.createMenuArray objectAtIndex:[indexPath row]];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LSongMenuCell" bundle:nil] forCellReuseIdentifier:SongMenuCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        }
        if ([indexPath row] == [self.createMenuArray count]-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        cell.model = menuModel;
        return cell;
        
    }else if ([indexPath section] == 2) {
        LSongMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        MyMusicColumMenuModel *menuModel = [self.colMenuArray objectAtIndex:[indexPath row]];
        if(cell==nil){
            [tableView registerNib:[UINib nibWithNibName:@"LSongMenuCell" bundle:nil] forCellReuseIdentifier:SongMenuCellCellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:SongMenuCellCellIdentifier];
        }
        if ([indexPath row] == [self.colMenuArray count]-1) {
            cell.separatorInset = UIEdgeInsetsMake(0, tableView.frame.size.width, 0, 0);
        }
        cell.model = menuModel;
        return cell;
    }else{
        return nil;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0) {
        return tableView.frame.size.width*headHeight/400;
    }else{
        return tableView.frame.size.width*60/400;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        
        return self.createHeader;
        
    }if(section == 2){
        
        return self.colHeader;
        
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1||section == 2){
        return tableView.frame.size.width*20/400;
    }
    else{
        return 0;
    }
}

#pragma mark - userheaddelegate
-(void)cell:(UserHeadCell *)cell scroll:(CGFloat)ratio{
    [self.headBackView setImage:[_headImage drn_boxblurImageWithBlur:ratio*0.3 withTintColor:RGB(75, 75, 75, fabs(ratio)*0.3)]];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect rect = self.headBackView.frame;
    self.headBackView.frame = CGRectMake(0, 0, rect.size.width, self.view.frame.size.width*headHeight/400+64-scrollView.contentOffset.y);
   
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (viewController == tabBarController.viewControllers[2]) {
         [self.rt_navigationController popViewControllerAnimated:true complete:nil];
    }else{
        [self.rt_navigationController popViewControllerAnimated:false complete:nil];
    }
}




@end
