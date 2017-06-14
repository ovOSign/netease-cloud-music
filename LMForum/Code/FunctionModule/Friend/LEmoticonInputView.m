//
//  LEmoticonInputView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/3.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LEmoticonInputView.h"
#import "LStatusHelper.h"
#import "LCGUtilities.h"
#define kViewHeight 216
#define kToolbarHeight 37
#define kOneEmoticonHeight 50
#define kOnePageCount 20
@interface WBEmoticonCell : UICollectionViewCell
@property (nonatomic, strong) LEmoticon *emoticon;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation WBEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _imageView = [UIImageView new];
    _imageView.bounds =CGRectMake(0, 0, 32, 32);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    return self;
}

- (void)setEmoticon:(LEmoticon *)emoticon {
    if (_emoticon == emoticon) return;
    _emoticon = emoticon;
    [self updateContent];
}

- (void)setIsDelete:(BOOL)isDelete {
    if (_isDelete == isDelete) return;
    _isDelete = isDelete;
    [self updateContent];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayout];
}

- (void)updateContent {
    _imageView.image = nil;
    
    if (_isDelete) {
        _imageView.image = [UIImage imageNamed:@"compose_emotion_delete"];
    } else if (_emoticon) {
        if (_emoticon.type == LEmoticonTypeEmoji) {
            NSNumber *num = [CommonUtils numberWithString:_emoticon.code];
            NSString *str = [CommonUtils stringWithUTF32Char:num.unsignedIntValue];
            if (_emoticon.code) {
                UIImage *img = [CommonUtils imageWithEmoji:str size:_imageView.frame.size.width];
                _imageView.image = img;
            }
        } else if (_emoticon.group.groupID && _emoticon.png){
            NSString *pngPath = [[LStatusHelper emoticonBundle] pathForResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupID];
            if (!pngPath) {
                NSString *addBundlePath = [[LStatusHelper emoticonBundle].bundlePath stringByAppendingPathComponent:@"additional"];
                NSBundle *addBundle = [NSBundle bundleWithPath:addBundlePath];
                pngPath = [addBundle pathForResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupID];
            }
            if (pngPath) {
                [_imageView sd_setImageWithURL:[NSURL fileURLWithPath:pngPath] placeholderImage:nil options:SDWebImageCacheMemoryOnly];
            }
        }
    }
}


- (void)updateLayout {
    _imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

@end









@protocol WBEmoticonScrollViewDelegate <UICollectionViewDelegate>
- (void)emoticonScrollViewDidTapCell:(WBEmoticonCell *)cell;
@end

@interface WBEmoticonScrollView : UICollectionView
@end

@implementation WBEmoticonScrollView {
    NSTimeInterval *_touchBeganTime;
    BOOL _touchMoved;
    __weak WBEmoticonCell *_currentMagnifierCell;
    NSTimer *_backspaceTimer;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.canCancelContentTouches = NO;
    self.multipleTouchEnabled = NO;
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = NO;
    WBEmoticonCell *cell = [self cellForTouches:touches];
    _currentMagnifierCell = cell;
    if (cell.imageView.image && !cell.isDelete) {
        [[UIDevice currentDevice] playInputClick];
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = YES;
    if (_currentMagnifierCell && _currentMagnifierCell.isDelete) return;
    
    WBEmoticonCell *cell = [self cellForTouches:touches];
    if (cell != _currentMagnifierCell) {
        if (!_currentMagnifierCell.isDelete && !cell.isDelete) {
            _currentMagnifierCell = cell;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WBEmoticonCell *cell = [self cellForTouches:touches];
    if ((!_currentMagnifierCell.isDelete && cell.emoticon) || (!_touchMoved && cell.isDelete)) {
        if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
            [((id<WBEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
        }
    }
}


- (WBEmoticonCell *)cellForTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        WBEmoticonCell *cell = (id)[self cellForItemAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

@end

@interface LEmoticonInputView()<UICollectionViewDelegate, UICollectionViewDataSource, UIInputViewAudioFeedback,WBEmoticonScrollViewDelegate>
@property (nonatomic, strong) NSArray<UIButton *> *toolbarButtons;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<LEmoticonGroup *> *emoticonGroups;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageIndexs;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageCounts;
@property (nonatomic, assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, strong) UIView *pageControl;

@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation LEmoticonInputView

+ (instancetype)sharedView {
    static LEmoticonInputView *v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [self new];
    });
    return v;
}

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, S_WIDTH, kViewHeight);
    self.backgroundColor = RGB(245, 245, 245, 1);
    [self _initGroups];
    [self _initTopLine];
    [self _initCollectionView];
    [self _initToolbar];
    
    _currentPageIndex = NSNotFound;
    [self _toolbarBtnDidTapped:_toolbarButtons.firstObject];
    return self;
}

- (void)_initGroups {
    _emoticonGroups = [LStatusHelper emoticonGroups];
    NSMutableArray *indexs = [NSMutableArray new];
    NSUInteger index = 0;
    for (LEmoticonGroup *group in _emoticonGroups) {
        [indexs addObject:@(index)];
        NSUInteger count = ceil(group.emoticons.count / (float)kOnePageCount);
        if (count == 0) count = 1;
        index += count;
    }
    _emoticonGroupPageIndexs = indexs;
    
    NSMutableArray *pageCounts = [NSMutableArray new];
    _emoticonGroupTotalPageCount = 0;
    for (LEmoticonGroup *group in _emoticonGroups) {
        NSUInteger pageCount = ceil(group.emoticons.count / (float)kOnePageCount);
        if (pageCount == 0) pageCount = 1;
        [pageCounts addObject:@(pageCount)];
        _emoticonGroupTotalPageCount += pageCount;
    }
    _emoticonGroupPageCounts = pageCounts;
}

- (void)_initTopLine {
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    line.frame = CGRectMake(0, 0, self.frame.size.width, CGFloatFromPixel(1));
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:line];
}

- (void)_initCollectionView {
    CGFloat itemWidth = (S_WIDTH - 10 * 2) / 7.0;
    itemWidth = CGFloatPixelRound(itemWidth);
    CGFloat padding = (S_WIDTH - 7 * itemWidth) / 2.0;
    CGFloat paddingLeft = CGFloatPixelRound(padding);
    CGFloat paddingRight = S_WIDTH - paddingLeft - itemWidth * 7;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, kOneEmoticonHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight);
    
    _collectionView = [[WBEmoticonScrollView alloc] initWithFrame:CGRectMake(0, 5, S_WIDTH, kOneEmoticonHeight * 3) collectionViewLayout:layout];
    [_collectionView registerClass:[WBEmoticonCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = NO;
    [self addSubview:_collectionView];
    
    _pageControl = [UIView new];
    _pageControl.frame = CGRectMake(0, CGRectGetMaxY(_collectionView.frame)-5, S_WIDTH, 20);
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}
- (void)_initToolbar {
    UIView *toolbar = [UIView new];
    toolbar.bounds = CGRectMake(0, 0, S_WIDTH, kToolbarHeight);
    
    UIImageView *bg = [[UIImageView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    bg.frame = CGRectMake(0, 0, toolbar.frame.size.width, toolbar.frame.size.height);
    [toolbar addSubview:bg];
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.frame = CGRectMake(0, 0, toolbar.frame.size.width, toolbar.frame.size.height);
    scroll.contentSize = CGSizeMake(toolbar.frame.size.width, toolbar.frame.size.height);
    [toolbar addSubview:scroll];
    
    NSMutableArray *btns = [NSMutableArray new];
    UIButton *btn;
    for (NSUInteger i = 0; i < _emoticonGroups.count; i++) {
        LEmoticonGroup *group = _emoticonGroups[i];
        btn = [self _createToolbarButton];
        [btn setTitle:group.nameCN forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height);
        btn.tag = i;
        [scroll addSubview:btn];
        [btns addObject:btn];
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
        line.frame = CGRectMake(btn.frame.size.width, 0, CGFloatFromPixel(1), btn.frame.size.height);
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [btn addSubview:line];
    }
    toolbar.frame = CGRectMake(0, self.frame.size.height-kToolbarHeight, toolbar.frame.size.width, kToolbarHeight);
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];;
    line.frame = CGRectMake(0, 0, toolbar.frame.size.width, CGFloatFromPixel(1));
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [toolbar addSubview:line];
    
    _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendButton.exclusiveTouch = YES;
    _sendButton.frame = CGRectMake(S_WIDTH - kToolbarHeight*1.8, 0, kToolbarHeight*1.8, kToolbarHeight);
    
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendButton.backgroundColor = [UIColor colorWithRed:30 / 255.0 green:167 / 255.0 blue:252 / 255.0 alpha:1.0];
    [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:_sendButton];
    
    [self addSubview:toolbar];

    _toolbarButtons = btns;
}

- (UIButton *)_createToolbarButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.bounds = CGRectMake(0, 0, S_WIDTH / 4, kToolbarHeight);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:RGB(75,74,73,1) forState:UIControlStateNormal];
//    [btn setTitleColor:RGB(75,74,73,1) forState:UIControlStateSelected];
    btn.backgroundColor = RGB(239,236,237,1);
    
    [btn addTarget:self action:@selector(_toolbarBtnDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)_toolbarBtnDidTapped:(UIButton *)btn {
    NSInteger groupIndex = btn.tag;
    NSInteger page = ((NSNumber *)_emoticonGroupPageIndexs[groupIndex]).integerValue;
    CGRect rect = CGRectMake(page * _collectionView.frame.size.width, 0, _collectionView.frame.size.width, _collectionView.frame.size.height);
    [_collectionView scrollRectToVisible:rect animated:NO];
    [self scrollViewDidScroll:_collectionView];
}

- (LEmoticon *)_emoticonForIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i];
        if (section >= pageIndex.unsignedIntegerValue) {
            LEmoticonGroup *group = _emoticonGroups[i];
            NSUInteger page = section - pageIndex.unsignedIntegerValue;
            NSUInteger index = page * kOnePageCount + indexPath.row;
            
            // transpose line/row
            NSUInteger ip = index / kOnePageCount;
            NSUInteger ii = index % kOnePageCount;
            NSUInteger reIndex = (ii % 3) * 7 + (ii / 3);
            index = reIndex + ip * kOnePageCount;
            if (index < group.emoticons.count) {
                return group.emoticons[index];
            } else {
                return nil;
            }
        }
    }
    return nil;
}


#pragma mark WBEmoticonScrollViewDelegate

- (void)emoticonScrollViewDidTapCell:(WBEmoticonCell *)cell {
    if (!cell) return;
    if (cell.isDelete) {
        if ([self.delegate respondsToSelector:@selector(emoticonInputDidTapBackspace)]) {
            [[UIDevice currentDevice] playInputClick];
            [self.delegate emoticonInputDidTapBackspace];
        }
    } else if (cell.emoticon) {
        NSString *text = nil;
        switch (cell.emoticon.type) {
            case LEmoticonTypeImage: {
                text = cell.emoticon.chs;
            } break;
            case LEmoticonTypeEmoji: {
                NSNumber *num = [CommonUtils numberWithString:cell.emoticon.code];
                text = [CommonUtils stringWithUTF32Char:num.unsignedIntValue];
            } break;
            default:break;
        }
        if (text && [self.delegate respondsToSelector:@selector(emoticonInputDidTapText:)]) {
            [self.delegate emoticonInputDidTapText:text];
        }
    }
}

#pragma mark UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (page < 0) page = 0;
    else if (page >= _emoticonGroupTotalPageCount) page = _emoticonGroupTotalPageCount - 1;
    if (page == _currentPageIndex) return;
    _currentPageIndex = page;
    NSInteger curGroupIndex = 0, curGroupPageIndex = 0, curGroupPageCount = 0;
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) {
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i];
        if (page >= pageIndex.unsignedIntegerValue) {
            curGroupIndex = i;
            curGroupPageIndex = ((NSNumber *)_emoticonGroupPageIndexs[i]).integerValue;
            curGroupPageCount = ((NSNumber *)_emoticonGroupPageCounts[i]).integerValue;
            break;
        }
    }
    while (_pageControl.layer.sublayers.count) {
        [_pageControl.layer.sublayers.lastObject removeFromSuperlayer];
    }
    CGFloat padding = 5, width = 6, height = 6;
    CGFloat pageControlWidth = (width + 2 * padding) * curGroupPageCount;
    for (NSInteger i = 0; i < curGroupPageCount; i++) {
        CALayer *layer = [CALayer layer];
        layer.bounds = CGRectMake(0, 0, width, height);
        layer.cornerRadius = 3;
        if (page - curGroupPageIndex == i) {
            layer.backgroundColor = RGB(164,164,164,1).CGColor;;
        } else {
            layer.backgroundColor = RGB(214,214,214,1).CGColor;
        }
        layer.frame = (CGRect){CGPointMake((_pageControl.frame.size.width - pageControlWidth) / 2 + i * (width + 2 * padding) + padding, _pageControl.frame.size.height / 2),layer.bounds.size.width,layer.bounds.size.height};
        [_pageControl.layer addSublayer:layer];
    }
    [_toolbarButtons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.selected = (idx == curGroupIndex);
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _emoticonGroupTotalPageCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kOnePageCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WBEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == kOnePageCount) {
        cell.isDelete = YES;
        cell.emoticon = nil;
    } else {
        cell.isDelete = NO;
        cell.emoticon = [self _emoticonForIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}





-(void)sendAction:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(emotionconInputDidSend:)]) {
        [self.delegate emotionconInputDidSend:button];
    }
}

@end
