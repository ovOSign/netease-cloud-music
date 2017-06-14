//
//  LCommentLayout.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LCommentLayout.h"

@implementation LCommentLayout

- (instancetype)initWithStatus:(LCommentModel *)status  {
    //if (!status || !status.userID) return nil;
    self = [super init];
    _status = status;
    [self layout];
    return self;
}

- (void)updateDate{
    
}


- (void)layout {
    [self _layout];
}


- (void)_layout {
    _marginTop = LComCellTopMargin;
    _profileHeight = 0;
    _textHeight = 0;
    _retweetHeight = 0;
    _retweetTextHeight = 0;
    [self _layoutProfile];
    
    [self _layoutText];
    
    [self _layoutRetweet];
    
    
    // 计算高度
    _height = 0;
    _height += _profileHeight;
    _height += _textHeight;
    if (_retweetHeight > 0) {
        _height += _retweetHeight;
    }
    _height += LComCellTopMargin;
}

- (void)_layoutProfile {
    [self _layoutName];
    _profileHeight = LComProfileHeight;
}

/// 名字
- (void)_layoutName {
    _nameSize = CGSizeZero;
    NSString *nameStr = _status.name;
    CGSize size = [CommonUtils sizeForString:nameStr Font:Font(LComCellNameFontSize) ConstrainedToSize:CGSizeMake(S_WIDTH,LComProfileHeight) LineBreakMode:NSLineBreakByWordWrapping];
    _nameSize = size;
}
/// 文本
- (void)_layoutText {
    _textHeight = 0;
    if (_status.text.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = LComCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(LComCellTextFontSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(31,31,31,1)};
        
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:_status.text attributes:dic];
        
        CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(LComCellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _textAttribute = dic;
        
        _textHeight = size.height+LCellPadding + 1;
    }
}

//转发
- (void)_layoutRetweet {
    _retweetHeight = 0;
    
    [self _layoutRetweetedText];
    
    _retweetHeight = _retweetTextHeight;
    
}

- (void)_layoutRetweetedText {
    _retweetTextHeight = 0;
    if (_status.linkText.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = LComCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(LComCellRetweetTextFontSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(83,83,83,1)};
        
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:_status.linkText attributes:dic];
        
        CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(LComRetweetCellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _retweetAttribute = dic;
        
        _retweetTextHeight = size.height+LCellPadding;
    }
    
}

@end
