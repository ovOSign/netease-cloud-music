//
//  LAttentionPostController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAttentionPostController.h"
#import "KITextView.h"
#import "LEmoticonInputView.h"
#import "LCGUtilities.h"
#import "LShareManager.h"
@interface LAttentionPostController ()<UITextViewDelegate,WBStatusComposeEmoticonViewDelegate>

@property(nonatomic, strong)KITextView *textView;

@property(nonatomic, strong)UILabel *placeholder;

@property (nonatomic, strong) UIView *toolbar;

@property (nonatomic, strong) UIView *toolbarBackground;

@property (nonatomic, strong) UIButton *toolbarAtButton;
@property (nonatomic, strong) UIButton *toolbarTopicButton;
@property (nonatomic, strong) UIButton *toolbarEmoticonButton;
@property (nonatomic, strong) UIButton *toolbarExtraButton;
@property (nonatomic, strong) UILabel  *ableFontNumLabel;
@property (nonatomic, strong) UIButton *toolbarArrButton;

@property (nonatomic, strong) LStatusLayout *currentlayout;

@end

@implementation LAttentionPostController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationItem.title = @"转发";
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction:)];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardFrameWillChangeNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [_textView becomeFirstResponder];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor whiteColor];
    _toolbar.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolbar];
    
    _toolbarBackground = [UIView new];
    _toolbarBackground.backgroundColor = RGB(245, 245, 245, 1);
    _toolbarBackground.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    _toolbarBackground.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [_toolbar addSubview:_toolbarBackground];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    line.frame = CGRectMake(0, 0, _toolbar.frame.size.width, CGFloatFromPixel(1));
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [_toolbarBackground addSubview:line];
    
    
    _toolbarAtButton = [self _toolbarButtonWithImage:@"cm2_edit_at"
                                           highlight:@"cm2_edit_at_prs"];
    
    _toolbarTopicButton = [self _toolbarButtonWithImage:@"cm2_edit_topic"
                                              highlight:@"cm2_edit_topic_prs"];
    
    _toolbarEmoticonButton = [self _toolbarButtonWithImage:@"cm2_edit_emo"
                                                 highlight:@"cm2_edit_emo_prs"];
    
    _toolbarArrButton = [self _toolbarButtonWithImage:@"cm2_edit_arr"
                                                 highlight:@"cm2_edit_arr_prs"];
    
    CGFloat one = _toolbar.frame.size.width / 6;
    _toolbarAtButton.center = CGPointMake(one * 0.5, _toolbarAtButton.center.y);
    _toolbarTopicButton.center = CGPointMake(one * 1.5, _toolbarAtButton.center.y);
    _toolbarEmoticonButton.center = CGPointMake(one * 2.5, _toolbarAtButton.center.y);
    
    _toolbarArrButton.center = CGPointMake(one * 5.5, _toolbarAtButton.center.y);
    
    _ableFontNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_toolbar.frame.size.width-100*W_SCALE, (_toolbar.frame.size.height-46)*.5, 46,46)];
    _ableFontNumLabel.font=Font(H4);
    _ableFontNumLabel.textColor=RGB(103,104,104,1);
    _ableFontNumLabel.text=@"140";
    _ableFontNumLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [_toolbar addSubview:_ableFontNumLabel];
}

- (void)setLayout:(LStatusLayout *)layout{
    _currentlayout = layout;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)backAction:(UIButton *)button{
    [super backAction:button];
    if (_dismiss) _dismiss();
}
-(void)sendAction:(UIButton *)button{
    if (_textView.text.length == 0) {
        [MBProgressHUD showError:@"请输入文字" toView:self.view];
    }else if (_textView.text.length > 140) {
        [MBProgressHUD showError:@"字数超过限制" toView:self.view];
    }else{
        [self.view endEditing:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [[LShareManager sharedInstance] createPostModel:_textView.text :_currentlayout.status];
        [[LShareManager sharedInstance] deleteSelect];
        [super backAction:button];
        _currentlayout.status.repostsCount += 1;
        if (_dismiss) _dismiss();
    }
}
#pragma mark - UITextViewDelegate
- (void) textViewDidChange:(UITextView *)textView{
    NSInteger ableNum =  140 - textView.text.length;
    _ableFontNumLabel.text = [NSString stringWithFormat:@"%ld",(long)ableNum];
    if ([textView.text length] == 0) {
        [_placeholder setHidden:NO];
    }else{
        [_placeholder setHidden:YES];
    }
}


#pragma mark - getting
-(UITextView*)textView{
    if (!_textView) {
        _textView = [[KITextView alloc] initWithFrame:CGRectMake(cellMargin, cellMargin, self.view.frame.size.width-2*cellMargin, self.view.frame.size.height-cellMargin-49)];
        _textView.delegate=self;
        _textView.font=Font(H3);
        _textView.tintColor = RGB(21,85,149,1);
        CGSize size=[CommonUtils sizeForString:@"一起聊聊音乐吧～" Font: _textView.font ConstrainedToSize:CGSizeMake(S_WIDTH, CGFLOAT_MAX) LineBreakMode:NSLineBreakByWordWrapping];
        _placeholder=[[UILabel alloc] initWithFrame:CGRectMake(10, 8, size.width,size.height)];
        _placeholder.font=_textView.font;
        _placeholder.textColor=RGB(103,104,104,1);
        _placeholder.text=@"一起聊聊音乐吧～";
        [_textView addSubview:_placeholder];
    }
    
    return _textView;
}

- (void)_buttonClicked:(UIButton *)button{
   if (button == _toolbarAtButton) {
        NSArray *atArray = @[@"@姚晨 ", @"@陈坤 ", @"@赵薇 ", @"@Angelababy " , @"@TimCook ", @"@我的印象笔记 "];
        NSString *atString = atArray[arc4random_uniform((u_int32_t)atArray.count)];
        [_textView replaceRange:_textView.selectedTextRange withText:atString];
        
    } else if (button == _toolbarTopicButton) {
        NSArray *topic = @[@"#冰雪奇缘[电影]# ", @"#Let It Go[音乐]# ", @"#纸牌屋[图书]# ", @"#北京·理想国际大厦[地点]# " , @"#腾讯控股 kh00700[股票]# ", @"#WWDC# "];
        NSString *topicString = topic[arc4random_uniform((u_int32_t)topic.count)];
        [_textView replaceRange:_textView.selectedTextRange withText:topicString];
        
    } else if (button == _toolbarEmoticonButton) {
        if (_textView.inputView) {
            _textView.inputView = nil;
            [_textView reloadInputViews];
            [_textView becomeFirstResponder];
            
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_emo"] forState:UIControlStateNormal];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_emo_prs"] forState:UIControlStateHighlighted];
        } else {
            LEmoticonInputView *v = [LEmoticonInputView sharedView];
            v.delegate = self;
            _textView.inputView = v;
            [_textView reloadInputViews];
            [_textView becomeFirstResponder];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_keyboard"] forState:UIControlStateNormal];
            [_toolbarEmoticonButton setImage:[UIImage imageNamed:@"cm2_edit_keyboard_prs"] forState:UIControlStateHighlighted];
        }
        
        
    } else if (button == _toolbarArrButton) {
        [_textView resignFirstResponder];
    }
}

#pragma mark - UIKeyboardNotification

- (void)_keyboardFrameWillChangeNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //   CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if (duration == 0) {
        _toolbar.frame = CGRectMake(0, CGRectGetMinY(endFrame)-_toolbar.frame.size.height, _toolbar.frame.size.width, _toolbar.frame.size.height);
        _textView.frame = CGRectMake(cellMargin, cellMargin, self.view.frame.size.width-2*cellMargin, CGRectGetMinY(_toolbar.frame));
    } else {
        [UIView animateWithDuration:duration delay:0 options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            _toolbar.frame = CGRectMake(0, endFrame.origin.y-_toolbar.frame.size.height, _toolbar.frame.size.width, _toolbar.frame.size.height);
            _textView.frame = CGRectMake(cellMargin, cellMargin, self.view.frame.size.width-2*cellMargin, CGRectGetMinY(_toolbar.frame));
        } completion:NULL];
    }
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


#pragma mark @protocol WBStatusComposeEmoticonView
- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [_textView replaceRange:_textView.selectedTextRange withText:text];
    }
}

- (void)emoticonInputDidTapBackspace {
    [_textView deleteBackward];
}


@end
