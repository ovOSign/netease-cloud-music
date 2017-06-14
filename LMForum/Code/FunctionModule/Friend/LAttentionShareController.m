//
//  LAttentionShareController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAttentionShareController.h"
#import "LShareOtherView.h"
#import "KITextView.h"
#import "LEmoticonInputView.h"
#import "LPicInputView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "TZImageManager.h"
#import "LPicCell.h"
#import "LSelectMusicController.h"
#import "LCGUtilities.h"
#import "LShareManager.h"
@interface LSelectMusicView:UIButton

@property(nonatomic, strong)UIImageView *sectMusicImgView;

@property(nonatomic, strong)UILabel *type;

@property(nonatomic, strong)UILabel *sectMusicLabel;


@end

@implementation LSelectMusicView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        
        _type =  [[UILabel alloc] initWithFrame:CGRectMake(cellMargin, cellMargin, frame.size.height-2*cellMargin, frame.size.height-2*cellMargin)];
        _type.textColor=RGB(103,104,104,1);
        _type.font=Font(H3);
        [self addSubview:_type];
        
        _sectMusicImgView = [[UIImageView alloc] initWithFrame:CGRectMake(cellMargin, cellMargin, frame.size.height-2*cellMargin, frame.size.height-2*cellMargin)];
        [_sectMusicImgView setImage:[UIImage imageNamed:@"cm2_lay_pic_buy_default"]];
        [self addSubview:_sectMusicImgView];
        
        _sectMusicLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellMargin+CGRectGetMaxY(_sectMusicImgView.frame), cellMargin, frame.size.width*0.7, frame.size.height-2*cellMargin)];
        _sectMusicLabel.text = @"没有音乐怎么行";
        _sectMusicLabel.textColor=RGB(103,104,104,1);
        _sectMusicLabel.font=Font(H3);
        [self addSubview:_sectMusicLabel];
        
        
        UIImage *img = [UIImage imageNamed:@"cm2_lists_icn_arr"];
        UIImageView *indicateView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-img.size.width-cellMargin, (frame.size.height-img.size.height)*.5, img.size.width, img.size.height)];
        [indicateView setImage:img];
        [self addSubview:indicateView];
        
        
    }
    return self;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint previous=[touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    if (fabs((location.x-previous.x)/(location.y-previous.y))<1) {
        [self.superview endEditing:YES];
    }
}
@end




@interface LAttentionShareController ()<UITextViewDelegate,UIGestureRecognizerDelegate,WBStatusComposeEmoticonViewDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>{
    CGFloat _itemWH;
    CGFloat _margin;
}

@property(nonatomic, strong)KITextView *textView;

@property(nonatomic, strong)UILabel *placeholder;

@property(nonatomic, strong)UIView *headView;

@property(nonatomic, strong)LShareOtherView *shareView;

@property(nonatomic, strong)LSelectMusicView *selectMusicView;

@property (nonatomic, strong) UIView *selectPicView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *toolbar;

@property (nonatomic, strong) UIView *toolbarBackground;

@property (nonatomic, strong) UIButton *toolbarPictureButton;
@property (nonatomic, strong) UIButton *toolbarAtButton;
@property (nonatomic, strong) UIButton *toolbarTopicButton;
@property (nonatomic, strong) UIButton *toolbarEmoticonButton;
@property (nonatomic, strong) UIButton *toolbarExtraButton;
@property (nonatomic, strong) UILabel  *ableFontNumLabel;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;

@end

@implementation LAttentionShareController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *name = [[LShareManager sharedInstance] getSelectSongName];
    if (name.length > 0) {
        _selectMusicView.sectMusicImgView.hidden = YES;
        [_selectMusicView.type setText:@"单曲:"];
        [_selectMusicView.sectMusicLabel setText:name];
    }else{
        [_selectMusicView.type setText:@""];
        _selectMusicView.sectMusicImgView.hidden = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_keyboardFrameWillChangeNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    self.view.backgroundColor = RGB(234, 235, 236, 1);
    [self setNavigationBar];
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, S_WIDTH, S_WIDTH*.54)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_headView];


    
    [_headView addSubview:self.textView];
    
    [_headView addSubview:self.selectMusicView];
    
    [self.view addSubview:self.selectPicView];
    
    [self.view addSubview:self.shareView];
    
    _toolbar = [UIView new];
    _toolbar.backgroundColor = [UIColor whiteColor];
    _toolbar.frame = CGRectMake(0, self.view.frame.size.height-49-64, self.view.frame.size.width, 49);
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
    
    
    _toolbarPictureButton = [self _toolbarButtonWithImage:@"cm2_edit_pic"
                                                highlight:@"cm2_edit_pic_prs"];
    
    _toolbarAtButton = [self _toolbarButtonWithImage:@"cm2_edit_at"
                                                highlight:@"cm2_edit_at_prs"];
    
    _toolbarTopicButton = [self _toolbarButtonWithImage:@"cm2_edit_topic"
                                           highlight:@"cm2_edit_topic_prs"];
    
    _toolbarEmoticonButton = [self _toolbarButtonWithImage:@"cm2_edit_emo"
                                           highlight:@"cm2_edit_emo_prs"];
    
    CGFloat one = _toolbar.frame.size.width / 6;
    _toolbarPictureButton.center = CGPointMake(one * 0.5, _toolbarPictureButton.center.y);
    _toolbarAtButton.center = CGPointMake(one * 1.5, _toolbarPictureButton.center.y);
    _toolbarTopicButton.center = CGPointMake(one * 2.5, _toolbarPictureButton.center.y);
    _toolbarEmoticonButton.center = CGPointMake(one * 3.5, _toolbarPictureButton.center.y);
    
    _ableFontNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(_toolbar.frame.size.width-46, (_toolbar.frame.size.height-46)*.5, 46,46)];
    _ableFontNumLabel.font=Font(H4);
    _ableFontNumLabel.textColor=RGB(103,104,104,1);
    _ableFontNumLabel.text=@"140";
    _ableFontNumLabel.textAlignment = NSTextAlignmentCenter;
    [_toolbar addSubview:_ableFontNumLabel];
    
    _selectedAssets = [NSMutableArray array];
    _selectedPhotos = [NSMutableArray array];

    
}

-(void)setNavigationBar{
    UIBarButtonItem *spaceL = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceL.width = -10.0f;
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cm2_topbar_icn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    UIBarButtonItem *sendBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendAction)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceL, button, nil];
    self.navigationItem.rightBarButtonItem = sendBtnItem;
    self.navigationItem.title = @"分享";
}

#pragma mark - getting
-(UITextView*)textView{
    if (!_textView) {
        _textView = [[KITextView alloc] initWithFrame:CGRectMake(cellMargin, cellMargin, S_WIDTH-2*cellMargin, (S_WIDTH-2*cellMargin)/3)];
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

-(UIView*)selectMusicView{
    if (!_selectMusicView) {
        _selectMusicView = [[LSelectMusicView alloc] initWithFrame:CGRectMake(cellMargin, cellMargin+CGRectGetMaxY(self.textView.frame), S_WIDTH-2*cellMargin, self.headView.frame.size.height-2*cellMargin-CGRectGetMaxY(self.textView.frame))];
        _selectMusicView.layer.borderWidth = 1;
        _selectMusicView.layer.borderColor = RGB(211, 210, 213, 1).CGColor;
        _selectMusicView.backgroundColor  = RGB(244, 245, 246, 1);
        [_selectMusicView setBackgroundImage:[CommonUtils ImageWithColor:[UIColor lightGrayColor] width:1 height:1] forState:UIControlStateHighlighted];
        [_selectMusicView addTarget:self action:@selector(selectMusicAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectMusicView;
}


-(UIView*)selectPicView{
    if (!_selectPicView) {
        UIImage *image = [UIImage imageNamed:@"cm2_act_addmusic"];
        _itemWH = image.size.width ;
        _selectPicView = [[UIView alloc] initWithFrame:CGRectMake(0, cellMargin+CGRectGetMaxY(self.headView.frame), S_WIDTH,_itemWH+2*cellMargin)];
         _selectPicView.backgroundColor = [UIColor whiteColor];
        // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _margin  = (S_WIDTH-4*image.size.width-2*cellMargin)/3;
        _itemWH = image.size.width ;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(cellMargin, cellMargin, _selectPicView.frame.size.width-cellMargin*2, _selectPicView.frame.size.height-cellMargin*2)collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _collectionView.scrollEnabled = NO;
        _collectionView.clipsToBounds = NO;
        [_collectionView registerClass:[LPicCell class] forCellWithReuseIdentifier:@"LPicCell"];
        [_selectPicView addSubview:_collectionView];
    }
    return _selectPicView;
}

-(UIView*)shareView{
    if (!_shareView) {
        _shareView = [[[NSBundle mainBundle] loadNibNamed: @"LShareOtherView"
                                       owner: self
                                     options: nil] lastObject];
        _shareView.frame = CGRectMake(cellMargin, cellMargin+CGRectGetMaxY(self.selectPicView.frame), S_WIDTH-2*cellMargin, S_WIDTH*300/400);
    }
    return _shareView;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action

-(void)selectMusicAction{
    [self.view endEditing:YES];
    LSelectMusicController *selectMController = [[LSelectMusicController alloc] init];
    [self.navigationController pushViewController:selectMController animated:YES ];
}

-(void)backAction{
    [self.view endEditing:YES];
    [[LShareManager sharedInstance] deleteSelect];
    if (_dismiss) _dismiss();
}

-(void)sendAction{
    if (_textView.text.length == 0) {
        [MBProgressHUD showError:@"请输入文字" toView:nil];
    }else if (_textView.text.length > 140) {
        [MBProgressHUD showError:@"字数超过限制" toView:nil];
    }else if (![[LShareManager sharedInstance] getCurrentSelectMusic]) {
        [UIView animateWithDuration:0.5 animations:^{
            _selectMusicView.backgroundColor = RGB(228,52,50, 0.3);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _selectMusicView.backgroundColor = RGB(244, 245, 246, 1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    _selectMusicView.backgroundColor = RGB(228,52,50, 0.3);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 animations:^{
                        _selectMusicView.backgroundColor = RGB(244, 245, 246, 1);
                    } completion:^(BOOL finished) {
                        
                    }];
                }];
            }];
        }];
    }else{
        [self.view endEditing:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        [[LShareManager sharedInstance] createShareModel:_textView.text :_selectedPhotos];
        [[LShareManager sharedInstance] deleteSelect];
        if (_dismiss) _dismiss();
    }
}

- (void)_buttonClicked:(UIButton *)button{
    if (button == _toolbarPictureButton) {
         [self pushImagePickerController];
    } else if (button == _toolbarAtButton) {
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
        
        
    } else if (button == _toolbarExtraButton) {
        
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
        _toolbar.frame = CGRectMake(0, CGRectGetMinY(endFrame)-_toolbar.frame.size.height-64, _toolbar.frame.size.width, _toolbar.frame.size.height);
    } else {
        [UIView animateWithDuration:duration delay:0 options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:^{
            _toolbar.frame = CGRectMake(0, endFrame.origin.y-_toolbar.frame.size.height-64, _toolbar.frame.size.width, _toolbar.frame.size.height);
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


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint previous=[touch previousLocationInView:self.view];
    CGPoint location = [touch locationInView:self.view];
    
    if (fabs((location.x-previous.x)/(location.y-previous.y))<1) {
        [self.view endEditing:YES];
    }
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

- (void)emotionconInputDidSend:(UIButton *)button{
    [_textView resignFirstResponder];
}


#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPicCell" forIndexPath:indexPath];
    cell.clipsToBounds = NO;
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"cm2_act_addmusic"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = false;
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
//        id asset = _selectedAssets[indexPath.row];
//        BOOL isVideo = NO;
//        if ([asset isKindOfClass:[PHAsset class]]) {
//            PHAsset *phAsset = asset;
//            isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
//        } else if ([asset isKindOfClass:[ALAsset class]]) {
//            ALAsset *alAsset = asset;
//            isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
//        }
//        if ([[asset valueForKey:@"filename"] containsString:@"GIF"]) {
//            TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
//            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
//            vc.model = model;
//            [self presentViewController:vc animated:YES completion:nil];
//        } else if (isVideo) { // perview video / 预览视频
//            TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
//            TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
//            vc.model = model;
//            [self presentViewController:vc animated:YES completion:nil];
//        } else { // preview photos / 预览照片
//            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
//            imagePickerVc.maxImagesCount = 4;
//            imagePickerVc.allowPickingOriginalPhoto = false;
//            imagePickerVc.isSelectOriginalPhoto = false;
//            imagePickerVc.oKButtonTitleColorDisabled = RGB(196,36,37, 1);
//            imagePickerVc.oKButtonTitleColorNormal =RGB(196,36,37, 1);
//            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                _selectedPhotos = [NSMutableArray arrayWithArray:photos];
//                _selectedAssets = [NSMutableArray arrayWithArray:assets];
//                [_collectionView reloadData];
//                _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
//            }];
//            [self presentViewController:imagePickerVc animated:YES completion:nil];
//        }
        [self pushImagePickerController];
    }
}



#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = false;
    
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    [imagePickerVc.navigationBar setBackgroundImage:MAINIMAGECOLOR forBarMetrics:UIBarMetricsDefault] ;
    imagePickerVc.oKButtonTitleColorDisabled = RGB(196,36,37, 1);
    imagePickerVc.oKButtonTitleColorNormal =RGB(196,36,37, 1);
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif =  NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = false;
    imagePickerVc.needCircleCrop = false;
    imagePickerVc.circleCropRadius = 100;
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        if (false) { // 允许裁剪,去裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                [self refreshCollectionViewWithAddedAsset:asset image:cropImage];
                            }];
                           // imagePicker.needCircleCrop = self.needCircleCropSwitch.isOn;
                            imagePicker.circleCropRadius = 100;
                            [self presentViewController:imagePicker animated:YES completion:nil];
                        } else {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                        }
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
}


#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    // open this code to send video / 打开这段代码发送视频
    // [[TZImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
    // NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
    // Export completed, send video here, send by outputPath or NSData
    // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    
    // }];
    [_collectionView reloadData];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
}

// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
}

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}


- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}


@end
