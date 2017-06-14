//
//  LAttentionDetailController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAttentionDetailController.h"
#import "LStatusCell.h"
#import "LCommentCell.h"
#import "LCGUtilities.h"
#import "LEmoticonInputView.h"
#import "KITextView.h"
#import "LAttentionPostController.h"
#import "YYPhotoGroupView.h"
#import "LCommentEmptCell.h"
#import "UserCenterController.h"
@interface LAttentionDetailController()<UITableViewDelegate,UITableViewDataSource,WBStatusComposeEmoticonViewDelegate,LStatusCellDelegate,UITextViewDelegate,LCommentCellDelegate>

@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIView *defaultFooterView;

@property (nonatomic, strong) LStatusLayout *currentlayout;

@property (nonatomic, strong)UIView *toolBar;

@property(nonatomic, strong)NSMutableArray *hotLayouts;

@property(nonatomic, strong)NSMutableArray *newestLayouts;

@property (nonatomic, strong) UIView *toolComtbar;

@property (nonatomic, strong) UIView *toolbarBackground;

@property (nonatomic, strong) KITextView *toolbarTextView;

@property (nonatomic, strong) UIButton *toolbarAtButton;

@property (nonatomic, strong) UIButton *toolbarEmoticonButton;

@property (nonatomic, strong) UILabel *placeholder;


@end

static NSString *StatusCellCellIdentifier = @"StatusCellCellIdentifier";

static NSString *HeadCellCellIdentifier = @"HeadCellCellIdentifier";

static NSString *CommentCellIdentifier = @"CommentCellIdentifier";

@implementation LAttentionDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardFrameWillChangeNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:[UIColor whiteColor]];
    [customLab setText:@"动态"];
    customLab.font = Font(20);
    customLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = customLab;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.allowsSelection = NO;
    _tableView.tableFooterView = self.defaultFooterView;
    [self.view addSubview:_tableView];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        LCommentModel *model = [[LCommentModel alloc] init];
//        model.name = @"grifftth";
//        model.text = @"3月28日,视频中多名男生暴力围殴一名学生。3月31日，澎湃新闻（www.thepaper.cn）从福建省龙岩市武平县公安局证实，事发武平县十方中学。";
//        model.linkText = @"@辽宁: @浙江 河南、湖北、重庆、四川、陕西等自由贸易试验区，是党中央、国务院作出的重大决策，是新形势下全面深化改革和扩大开放的一项战略举措，对加快政府职能转变、积极探索管理模式创新、促进贸易投资便利化、深化金融开放创新，为全面深化改革和扩大开放探索新途径、积累新经验，具有重要意义。";
//        LCommentLayout *layout = [[LCommentLayout alloc] initWithStatus:model ];
//        [_hotLayouts addObject:layout];
//        [_newestLayouts addObject:layout];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_tableView reloadData];
//        });
//    });
    
    _hotLayouts = [NSMutableArray new];
    
    _newestLayouts = [NSMutableArray new];
    
    _toolComtbar = [UIView new];
    _toolComtbar.backgroundColor = [UIColor whiteColor];
    _toolComtbar.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    _toolComtbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolComtbar];
    
    _toolbarBackground = [UIView new];
    _toolbarBackground.backgroundColor = RGB(245, 245, 245, 1);
    _toolbarBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    _toolbarBackground.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [_toolComtbar addSubview:_toolbarBackground];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    line.frame = CGRectMake(0, 0, _toolComtbar.frame.size.width, CGFloatFromPixel(1));
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_toolbarBackground addSubview:line];
    
    
    _toolbarAtButton = [self _toolbarButtonWithImage:@"cm2_edit_at"
                                           highlight:@"cm2_edit_at_prs"];
    
    _toolbarEmoticonButton = [self _toolbarButtonWithImage:@"cm2_edit_emo"
                                                 highlight:@"cm2_edit_emo_prs"];
    CGFloat one = _toolComtbar.frame.size.width / 6;
    _toolbarAtButton.center = CGPointMake(one * 4.8, _toolbarAtButton.center.y);
    _toolbarEmoticonButton.center = CGPointMake(one * 5.5, _toolbarAtButton.center.y);
    
    _toolbarTextView = [[KITextView alloc] initWithFrame:CGRectMake(cellMargin, 10,one * 4 , 29)];
    _toolbarTextView.backgroundColor = [UIColor whiteColor];
    _toolbarTextView.layer.borderWidth = 1;
    _toolbarTextView.layer.cornerRadius = 5;
    _toolbarTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.2].CGColor;
    _toolbarTextView.font = Font(H4);
    _toolbarTextView.delegate = self;
    _toolbarTextView.returnKeyType = UIReturnKeySend;
    [_toolComtbar addSubview:_toolbarTextView];
    
    CGSize size=[CommonUtils sizeForString:@"发布评论" Font: _toolbarTextView.font ConstrainedToSize:CGSizeMake(S_WIDTH, CGFLOAT_MAX) LineBreakMode:NSLineBreakByWordWrapping];
    _placeholder=[[UILabel alloc] initWithFrame:CGRectMake(10, 8, size.width,size.height)];
    _placeholder.font=_toolbarTextView.font;
    _placeholder.textColor=RGB(103,104,104,1);
    _placeholder.text=@"发布评论";
    [_toolbarTextView addSubview:_placeholder];
    
    
    [self.view addSubview:self.toolBar];
    

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_dismiss) _dismiss();
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (_upToBottom) {
       [self _scrollViewToTop:NO];
    }
}


-(void)_scrollViewToTop:(BOOL)animated{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height){
        __weak LAttentionDetailController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:animated];
        });
    }
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

- (UIButton *)_toolbarButtonWithImage:(NSString *)imageName highlight:(NSString *)highlightImageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.exclusiveTouch = YES;
    button.bounds = CGRectMake(0, 0, 46, 46);
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    button.center = CGPointMake(button.center.x, 46 / 2);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [button addTarget:self action:@selector(_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_toolbarBackground addSubview:button];
    return button;
}

- (UIView *)toolBar{
    if (_toolBar == nil) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49,self.view.frame.size.width, 49)];
        _toolBar.backgroundColor = MAINIBACKGROUNDCOLOR;
        UIButton *comButton = [UIButton buttonWithType:UIButtonTypeCustom];
        comButton.frame = CGRectMake(0, 0, _toolBar.frame.size.width*.5, _toolBar.frame.size.height);
        [comButton setImage:[UIImage imageNamed:@"cm2_btm_icn_cmt"] forState:UIControlStateNormal];
        [comButton setTitle:@"评论" forState:UIControlStateNormal];
        [comButton setTitleColor:RGB(134,133,133,1) forState:UIControlStateNormal];
        comButton.titleLabel.font = Font(H3);
        comButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4*W_SCALE);
        comButton.imageEdgeInsets = UIEdgeInsetsMake(0, -4*W_SCALE, 0, 0);
        [comButton addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        postButton.frame = CGRectMake(_toolBar.frame.size.width*.5, 0, _toolBar.frame.size.width*.5, _toolBar.frame.size.height);
        [postButton setImage:[UIImage imageNamed:@"cm2_btm_icn_share"] forState:UIControlStateNormal];
        [postButton setTitle:@"转发" forState:UIControlStateNormal];
        [postButton setTitleColor:RGB(134,133,133,1) forState:UIControlStateNormal];
        postButton.titleLabel.font = Font(H3);
        postButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4*W_SCALE);
        postButton.imageEdgeInsets = UIEdgeInsetsMake(0, -4*W_SCALE, 0, 0);
        [postButton addTarget:self action:@selector(postAction) forControlEvents:UIControlEventTouchUpInside];
        UIColor *dark = [UIColor colorWithWhite:0 alpha:0.2];
        CAGradientLayer *line1 = [CAGradientLayer layer];
        line1.backgroundColor = dark.CGColor;
        line1.frame = CGRectMake(_toolBar.frame.size.width*.5, _toolBar.frame.size.height*0.15, 1, _toolBar.frame.size.height*0.7);
        
        CAGradientLayer *line2 = [CAGradientLayer layer];
        line2.backgroundColor = dark.CGColor;
        line2.frame = CGRectMake(0, 0, _toolBar.frame.size.width, 1);
        
        [_toolBar.layer addSublayer:line1];
        [_toolBar.layer addSublayer:line2];
        
        [_toolBar addSubview:comButton];
        [_toolBar addSubview:postButton];
    }
    
    return _toolBar;
}

//-(void)backAction:(UIButton *)button{
//    [self.view endEditing:YES];
//}

#pragma mark - UIKeyboardNotification

- (void)_keyboardFrameWillChangeNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //   CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if (duration == 0) {
        _toolComtbar.frame = CGRectMake(0, CGRectGetMinY(endFrame)-_toolComtbar.frame.size.height, _toolComtbar.frame.size.width, _toolComtbar.frame.size.height);
    } else {
        [UIView animateWithDuration:duration delay:0 options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            _toolComtbar.frame = CGRectMake(0, endFrame.origin.y-_toolComtbar.frame.size.height, _toolComtbar.frame.size.width, _toolComtbar.frame.size.height);
        } completion:NULL];
    }
}



- (void)_buttonClicked:(UIButton *)button{
    if (button == _toolbarAtButton) {
        NSArray *atArray = @[@"@姚晨 ", @"@陈坤 ", @"@赵薇 ", @"@Angelababy " , @"@TimCook ", @"@我的印象笔记 "];
        NSString *atString = atArray[arc4random_uniform((u_int32_t)atArray.count)];
        [_toolbarTextView replaceRange:_toolbarTextView.selectedTextRange withText:atString];
        
    } else if (button == _toolbarEmoticonButton) {
        if (_toolbarTextView.inputView) {
            _toolbarTextView.inputView = nil;
            [_toolbarTextView reloadInputViews];
            [_toolbarTextView becomeFirstResponder];
            
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_emo"] forState:UIControlStateNormal];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_emo_prs"] forState:UIControlStateHighlighted];
        } else {
            LEmoticonInputView *v = [LEmoticonInputView sharedView];
            v.delegate = self;
            _toolbarTextView.inputView = v;
            [_toolbarTextView reloadInputViews];
            [_toolbarTextView becomeFirstResponder];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_keyboard"] forState:UIControlStateNormal];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_keyboard_prs"] forState:UIControlStateHighlighted];
        }
        
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if((scrollView == _tableView) && [_toolbarTextView isFirstResponder]){
        [_toolbarTextView resignFirstResponder];
    }
}


//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    if([_toolbarTextView isFirstResponder]){
//          [_toolbarTextView resignFirstResponder];
//    }
//}


#pragma mark - UITextViewDelegate
- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [_placeholder setHidden:NO];
    }else{
        [_placeholder setHidden:YES];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        if (_toolbarTextView.text.length > 0){
            LCommentModel *commentModel = [[LCommentModel alloc] init];
            commentModel.text = textView.text;
            commentModel.name = [UserManager sharedInstance].user.name;
            commentModel.profileImageURL = [UserManager sharedInstance].user.avatar;
            commentModel.createdTime = [CommonUtils stringWithTimelineDate:[NSDate date]];
            LCommentLayout *layout = [[LCommentLayout alloc] initWithStatus:commentModel];
            [_newestLayouts insertObject:layout atIndex:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            [textView resignFirstResponder];
             _toolbarTextView.text = nil;
            return NO;
        }else{
            return NO;
        }
    }
    return YES;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_hotLayouts count] == 0) {
        if ( section == 0) {
            return 1;
        }else{
            if ([_newestLayouts count] == 0) {
               return 1;
            }else{
              return [_newestLayouts count];
            }
        }
    }
    if ( section == 0) {
        return 1;
    }else if ( section == 1) {
        return [_hotLayouts count];
    }else if ( section == 2){
        return [_newestLayouts count];
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_hotLayouts count] == 0) {
        if ( [indexPath section] == 0) {
            LStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusCellCellIdentifier];
            if (!cell) {
                cell = [[LStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatusCellCellIdentifier];
                cell.delegate = self;
            }
            [cell setDetailLayout:_currentlayout];
            return cell;
        }else{
            if ([_newestLayouts count] == 0) {
                LCommentEmptCell *cell = [tableView dequeueReusableCellWithIdentifier:HeadCellCellIdentifier];
                if (!cell) {
                    cell = [[LCommentEmptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeadCellCellIdentifier];
                    cell.separatorInset = UIEdgeInsetsMake(0, S_WIDTH, 0, 0);
                }
                return cell;
            }else{
                LCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
                if (!cell) {
                    cell = [[LCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellIdentifier];
                    cell.delegate = self;
                }
                [cell setLayout:_newestLayouts[indexPath.row]];
                return cell;
            }

        }
    }
    if ([indexPath section] == 0) {
        LStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:StatusCellCellIdentifier];
        if (!cell) {
            cell = [[LStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StatusCellCellIdentifier];
            cell.delegate = self;
        }
        [cell setDetailLayout:_currentlayout];
        return cell;
    }else if([indexPath section] == 1){
        LCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
        if (!cell) {
            cell = [[LCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellIdentifier];
            cell.delegate = self;
        }
        [cell setLayout:_hotLayouts[indexPath.row]];
        return cell;
    }if([indexPath section] == 2){
        LCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
        if (!cell) {
            cell = [[LCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellIdentifier];
            cell.delegate = self;
        }
        [cell setLayout:_newestLayouts[indexPath.row]];
        return cell;
    }else{
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_hotLayouts count] == 0) {
        return 2;
    }else{
        return 3;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_hotLayouts count] == 0) {
        if ([indexPath section]== 0) {
            return _currentlayout.dheight;
        }else {
            if ([_newestLayouts count] == 0){
               return 120;
            }else{
               return ((LCommentLayout *)_newestLayouts[indexPath.row]).height;
            }
        }
    }
    if ([indexPath section]== 0) {
        return _currentlayout.dheight;
    }else if([indexPath section]== 1) {
        return ((LCommentLayout *)_hotLayouts[indexPath.row]).height;
    }else if([indexPath section]== 2) {
        return ((LCommentLayout *)_newestLayouts[indexPath.row]).height;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0;
    }
    else{
        return 25;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([_hotLayouts count] == 0) {
        if ( section == 1) {
            UIView *view=[[UIView alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWBCellPadding, 0, 100, 25)];
            label.text = [NSString stringWithFormat:@"最新评论(%lu)",(unsigned long)[_newestLayouts count]];
            label.textColor = RGB(103,104,104,1);
            label.font = Font(H5);
            view.backgroundColor = RGB(234, 235, 236, 1);
            [view addSubview:label];
            return view;
        }else{
            return nil;
        }
    }
    if (section == 1) {
        UIView *view=[[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWBCellPadding, 0, 100, 25)];
        label.text = @"精彩评论";
        label.textColor = RGB(103,104,104,1);
        label.font = Font(H5);
        view.backgroundColor = RGB(234, 235, 236, 1);
        [view addSubview:label];
        return view;
    }else if (section == 2) {
        UIView *view=[[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWBCellPadding, 0, 100, 25)];
        label.text = [NSString stringWithFormat:@"最新评论(%lu)",(unsigned long)[_newestLayouts count]];
        label.textColor = RGB(103,104,104,1);
        label.font = Font(H5);
        view.backgroundColor = RGB(234, 235, 236, 1);
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
    
}

#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [_toolbarTextView replaceRange:_toolbarTextView.selectedTextRange withText:text];
    }
}

- (void)emoticonInputDidTapBackspace {
    [_toolbarTextView deleteBackward];
}

- (void)emotionconInputDidSend:(UIButton *)button{
    if (_toolbarTextView.text.length > 0) {
        LCommentModel *commentModel = [[LCommentModel alloc] init];
        commentModel.text = _toolbarTextView.text;
        commentModel.name = [UserManager sharedInstance].user.name;
        commentModel.profileImageURL = [UserManager sharedInstance].user.avatar;
        commentModel.createdTime = [CommonUtils stringWithTimelineDate:[NSDate date]];
        LCommentLayout *layout = [[LCommentLayout alloc] initWithStatus:commentModel];
        [_newestLayouts insertObject:layout atIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
        [_toolbarTextView resignFirstResponder];
        _toolbarTextView.text = nil;
    }

}

- (void)setLayout:(LStatusLayout *)layout {
    _currentlayout = layout;
}


#pragma mark - Action

-(void)commentAction{
    [_toolbarTextView becomeFirstResponder];
}

-(void)postAction{
    LAttentionPostController *pc = [[LAttentionPostController alloc] init];
    [pc setLayout:_currentlayout];
    pc.dismiss = ^{
        self.playingButton.alpha = 1;
        [self.view endEditing:YES];
    };
    [self.navigationController pushViewController:pc animated:YES ];
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
    if (cardView.button.selected) {
        LAttentionModel *status = cell.statusView.layout.status;
        NSString *name = status.retweetedStatus.shareMusic ? status.retweetedStatus.shareMusic.name:status.shareMusic.name;
        if ([name isEqualToString:[LAVPlayer sharedInstance].currentMusic.name]) {
            [[LAVPlayer sharedInstance] play];
        }else{
            [[LAVPlayer sharedInstance] playSongWithSongName:name listButton:cardView.button];
        }
        status.playing = true;
        
    }else{
        status.playing = false;
        [[LAVPlayer sharedInstance] pause];
    }
}

- (void)cell:(LStatusCell *)cell didClickzanButton:(UIButton *)button{
    button.selected =! button.selected;
    LAttentionModel *status = cell.statusView.layout.status;
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
        status.attitudesCount += 1;
        [status.linkPicIds addObject:[UserManager sharedInstance].user];

    }else{
        status.attitudesStatus = 0;
        status.attitudesCount -= 1;
        [status.linkPicIds removeObject:[UserManager sharedInstance].user];
    }
    
    [self.tableView reloadSections:[NSIndexSet  indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)commentCell:(LCommentCell *)cell didClickzanButton:(UIButton *)button{
    button.selected =! button.selected;
    LCommentModel *status = cell.statusView.layout.status;
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
        
    }else{
        status.attitudesStatus = 0;
        count -= 1;
        status.attitudesCount -= 1;
    }
    [cell.statusView.linkLabel setText:count <= 0 ? @"" : [NSString stringWithFormat:@"%d",count]];
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
