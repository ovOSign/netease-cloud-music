//
//  LSearchBar.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LSearchBar.h"
@interface LTextField:UITextField

@property(nonatomic)CGRect editorframe;

@end

@implementation LTextField

-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.frame = self.editorframe;
        }
    }
}

-(void)setEditorframe:(CGRect)editorframe{
    _editorframe = editorframe;
    [self setNeedsLayout];
}

@end

@interface LSearchBar()<UITextFieldDelegate>{
    CGRect orgSearchBarFm;
    CGRect orgTextFieldFm;
    CGRect orgPlaceholderLabelFm;
    CGRect orgSearchImageViewFm;
    CGRect orgEditorFm;
    UIButton *coveredButton;
    BOOL reLayoutFlag;
}

@property(nonatomic, strong)LTextField *textField;

@property(nonatomic, strong)UILabel *placeholderLabel;

@property(nonatomic, strong)UIImageView *searchImageView;

@property(nonatomic, strong)UIButton *dltImageView;

@property(nonatomic, strong)UIView *supView;

@property(nonatomic, strong)UIButton *cancelButton;

@end

#define LTextFieldPadding 8

#define buttonWith 50

#define buttonPadding 8

#define animateDuration 0.3

@implementation LSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //_textField
        _textField = [[LTextField alloc]init];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.cornerRadius = 3;
        _textField.textColor = colorBlack;
        _textField.delegate = self;
        _textField.font = Font(H3);
        _textField.tintColor = [UIColor colorWithPatternImage:MAINIMAGECOLOR];
        [_textField addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];

        
        //_placeholderLabel
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.textColor = colorGray2;
        [_placeholderLabel sizeToFit];
        CGFloat font = H3;
        _placeholderLabel.font = Font(font);
        [self.textField addSubview:_placeholderLabel];
        
    
        
        //_searchImageView
         UIImage *image = [UIImage imageNamed:@"cm2_topbar_icn_search"];
        _searchImageView = [[UIImageView alloc] init];
        [_searchImageView setImage:image];
        [self.textField addSubview:_searchImageView];
  

        reLayoutFlag = YES;
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (reLayoutFlag) {
       [self reloadSubViews];
    }
  
}


-(void)reloadSubViews{
    if (!CGRectEqualToRect(orgSearchBarFm, self.frame)) {
        int i = 0;
        self.supView = [self superview];
        for (UIView *view in  [self.supView subviews]) {
            if ([view isKindOfClass:[UIButton class]]) {
                i ++;
            }
        }
        
        CGRect rct = [self convertRect:self.frame toView:_supView];
        self.frame = (CGRect){self.frame.origin,CGSizeMake(rct.size.width, rct.size.height)};
        orgSearchBarFm = self.frame;
        
        _textField.frame = (CGRect){CGPointZero , self.frame.size.width, self.frame.size.height};
        orgTextFieldFm = _textField.frame;
        
        _placeholderLabel.center = _textField.center;
        CGRect rect = [self.placeholder boundingRectWithSize:_textField.bounds.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_placeholderLabel.font} context:nil];
        _placeholderLabel.bounds = rect;
        orgPlaceholderLabelFm = _placeholderLabel.frame;
        
        
        UIImage *image = _searchImageView.image;
        _searchImageView.frame = CGRectMake(_placeholderLabel.frame.origin.x-image.size.width-LTextFieldPadding, (_textField.frame.size.height-image.size.height)*0.5, image.size.width, image.size.height);
        orgSearchImageViewFm = _searchImageView.frame;
    }
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholderLabel.text = placeholder;
    _placeholder = placeholder;
}

-(UIButton *)dltImageView{
    if (!_dltImageView) {
        UIImage *dltImage = [UIImage imageNamed:@"cm2_search_icn_dlt"];
        UIImage *dltPrsImage = [UIImage imageNamed:@"cm2_search_icn_dlt_prs"];
        _dltImageView = [[UIButton alloc] initWithFrame:CGRectMake(_textField.frame.size.width-dltImage.size.width-LTextFieldPadding, (_textField.frame.size.height-dltImage.size.height)*0.5, dltImage.size.width, dltImage.size.height)];
        [_dltImageView setImage:dltImage forState:UIControlStateNormal];
        [_dltImageView setImage:dltPrsImage forState:UIControlStateHighlighted];
        [_dltImageView addTarget:self action:@selector(dltAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dltImageView;
}

-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_cancelButton sizeToFit];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    reLayoutFlag = NO;
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        if ([self.delegate searchBarShouldBeginEditing:self]) {
            [self textFieldBeginEdit];
        }
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return  ([self.delegate searchBarShouldEndEditing:self]);
    }
    return true;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

-(void)textFieldValueChanged:(UITextField *)textField{
    if (_placeholderLabel.alpha == 1 && textField.text.length>0){
        _placeholderLabel.alpha = 0;
        [_textField addSubview:self.dltImageView];
    }
    if (_placeholderLabel.alpha == 0 && textField.text.length == 0){
        _placeholderLabel.alpha = 1;
        [self.dltImageView removeFromSuperview];
    }
    if ([self.delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]) {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
    
}

-(void)dltAction:(UIButton *)button{
    _textField.text = @"";
    [self textFieldValueChanged:_textField];
}


-(void)cancelAction:(UIButton *)button{
     [_textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
        [self textFieldEndEdit];
    }
}

#pragma mark - public
-(void)cancelTextEdit{
    [self textFieldEndEdit];
}

-(void)layoutSearchBar{
    
}

#pragma mark - private

-(void)textFieldBeginEdit{
    int i = 0;
    UIButton *button = nil;
    for (UIView *view in  [self.supView subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            i ++;
            button = (UIButton*)view;
        }
    }
    //取消按钮
    coveredButton = button;
    CGRect playBtnFram = CGRectZero;
    CGRect toFiedFrame = CGRectZero;
    CGRect searchFram = [self convertRect:self.bounds toView:_supView];
    UIImage *image = _searchImageView.image;
    CGRect oldRect = self.textField.frame;
    if (coveredButton != nil) {
        playBtnFram = [button convertRect:button.bounds toView:_supView];
        toFiedFrame = (CGRect){_textField.frame.origin,CGSizeMake(searchFram.size.width,_textField.frame.size.height )};
        _textField.frame = (CGRect){CGPointMake(searchFram.size.width-oldRect.size.width, 0) , oldRect.size};
    }else{
        playBtnFram = CGRectMake(_supView.frame.size.width-50, searchFram.origin.y, 50, 30);
        toFiedFrame = (CGRect){_textField.frame.origin,_textField.frame.size};
        _textField.frame = (CGRect){CGPointMake(searchFram.size.width-oldRect.size.width, 0) , oldRect.size};
    }
    self.cancelButton.frame = CGRectMake(CGRectGetMaxX(_supView.frame), playBtnFram.origin.y, playBtnFram.size.width, playBtnFram.size.height);
    [_supView addSubview:_cancelButton];
    coveredButton.alpha = 0;
    [UIView animateWithDuration:animateDuration animations:^{
        self.playButton.alpha = 0;
        _textField.frame = toFiedFrame;
        _searchImageView.frame = (CGRect){CGPointMake(LTextFieldPadding, _searchImageView.frame.origin.y),_searchImageView.frame.size};
        _placeholderLabel.frame =(CGRect){CGPointMake(LTextFieldPadding+image.size.width+LTextFieldPadding, _placeholderLabel.frame.origin.y),_placeholderLabel.frame.size};
        _cancelButton.frame = playBtnFram;
    } completion:^(BOOL finished) {
        if (coveredButton != nil){
            _textField.editorframe = CGRectMake(CGRectGetMinX(_placeholderLabel.frame), 0, (searchFram.size.width)*0.8, searchFram.size.height);
        }
        else{
            _textField.editorframe = CGRectMake(CGRectGetMinX(_placeholderLabel.frame), 0, (searchFram.size.width-50)*0.8, searchFram.size.height);
        }
        self.playButton.enabled = NO;
    }];

}

-(void)textFieldEndEdit{
    if (_textField.text.length > 0) {
        _textField.text = @"";
        _placeholderLabel.alpha = 1;
        [self.dltImageView removeFromSuperview];
    }
     coveredButton.alpha = 0;
   CGRect toCancelframe = CGRectMake(CGRectGetMaxX(_supView.frame), _cancelButton.frame.origin.y, _cancelButton.frame.size.width, _cancelButton.frame.size.height);
    CGRect searchFram = [self convertRect:self.bounds toView:_supView];
    CGRect oppositeTextFrame = (CGRect){CGPointMake(searchFram.size.width-_textField.frame.size.width, _textField.frame.origin.y) ,_textField.frame.size};
    _textField.frame = oppositeTextFrame;
     self.playButton.enabled = YES;
    [UIView animateWithDuration:animateDuration animations:^{
        _cancelButton.frame = toCancelframe;
        _searchImageView.frame = orgSearchImageViewFm;
        _placeholderLabel.frame = orgPlaceholderLabelFm;
        _textField.frame = orgTextFieldFm;
    } completion:^(BOOL finished) {
        [_cancelButton removeFromSuperview];
        self.playButton.alpha = 1;
    }];
}

@end
