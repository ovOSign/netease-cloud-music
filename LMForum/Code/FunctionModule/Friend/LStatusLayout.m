//
//  LStatusLayout.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LStatusLayout.h"
#import "LCGUtilities.h"
@implementation LStatusLayout

- (instancetype)initWithStatus:(LAttentionModel *)status style:(WBLayoutStyle)style {
    //if (!status || !status.userID) return nil;
    self = [super init];
    _status = status;
    _style = style;
    [self layout];
    return self;
}
- (void)layout {
    [self _layout];
}
- (void)updateDate{
    
}

- (void)_layout {
    _marginTop = kWBCellTopMargin;
    _profileHeight = 0;
    _textHeight = 0;
    _retweetHeight = 0;
    _retweetTextHeight = 0;
    _retweetPicHeight = 0;
    _picHeight = 0;
    _toolbarHeight = kWBCellToolbarHeight;
    _cardHeight = kWBCellCarHeight;
    [self _layoutProfile];
    
    
    
    [self _layoutText];
    
    [self _layoutRetweet];
    
    if (_retweetHeight == 0) {
        [self _layoutPics];
        if (_picHeight == 0) {
            // [self _layoutCard];
        }
    }

    // 计算高度
    _height = 0;
    _height += _profileHeight;
    _height += _textHeight;
    if (_retweetHeight > 0) {
        _height += _retweetHeight - kWBCellPadding-kWBCellPaddingPic-_cardHeight;
    } else if (_picHeight > 0) {
        _height += _picHeight + kWBCellPaddingPic;
    }
    _height += _toolbarHeight;
    _height += _cardHeight;
    _height += 2*kWBCellPadding+ kWBCellPaddingPic;
}


- (void)_layoutProfile {
    [self _layoutName];
    _profileHeight = kWBCellProfileHeight;
}

/// 名字
- (void)_layoutName {
    _nameSize = CGSizeZero;
    NSString *nameStr = _status.name;
    CGSize size = [CommonUtils sizeForString:nameStr Font:Font(kWBCellNameFontSize) ConstrainedToSize:CGSizeMake(S_WIDTH,kWBCellProfileHeight ) LineBreakMode:NSLineBreakByWordWrapping];
    _nameSize = size;
}


/// 文本
- (void)_layoutText {
    _textHeight = 0;
    if (_status.text.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = kWBCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(kWBCellTextFontSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(31,31,31,1)};
        
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:_status.text attributes:dic];
        
         CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(kWBCellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _textAttribute = dic;
        
        _textHeight = size.height+LCellPadding + 1;
    }
}
//转发
- (void)_layoutRetweet {
    _retweetHeight = 0;
    [self _layoutRetweetedText];
    [self _layoutRetweetPics];
    
    _retweetHeight = _retweetTextHeight;
    if (_retweetPicHeight > 0) {
        _retweetHeight += _retweetPicHeight;
    }
    if (_retweetHeight > 0) {
        _retweetHeight += _cardHeight;
        _retweetHeight +=kWBCellPadding+ kWBCellPaddingPic;
    }

}
- (void)_layoutRetweetedText {
    _retweetTextHeight = 0;
    if (_status.retweetedStatus.text.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = kWBCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(kWBCellTextFontRetweetSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(83,83,83,1)};
        
        NSString *retweetedText = [NSString stringWithFormat:@"@%@ 分享单曲：%@",_status.retweetedStatus.name,_status.retweetedStatus.text];
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:retweetedText attributes:dic];
        
        CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(kWBRetweetCellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _retweetAttribute = dic;
        
        _retweetTextHeight = size.height+LCellPadding;
    }

}


- (void)_layoutPics {
    [self _layoutPicsWithStatus:_status isRetweet:NO];
}

- (void)_layoutRetweetPics {
    [self _layoutPicsWithStatus:_status.retweetedStatus isRetweet:YES];
}


- (void)_layoutPicsWithStatus:(LAttentionModel *)status isRetweet:(BOOL)isRetweet {
    if (isRetweet) {
        _retweetPicSize = CGSizeZero;
        _retweetPicHeight = 0;
    } else {
        _picSize = CGSizeZero;
        _picHeight = 0;
    }
    if (status.pics.count == 0) return;
    
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    
    CGFloat len1_3;
    if (isRetweet) {
        len1_3 = (kWBRetweetCellContentWidth + kWBCellPaddingPic) / 2 - kWBCellPaddingPic;
    }else{
        len1_3 = (kWBCellContentWidth + kWBCellPaddingPic) / 2 - kWBCellPaddingPic;
    }
    len1_3 = CGFloatPixelRound(len1_3);
    switch (status.pics.count) {
        case 1: {
            id pic1 = _status.pics.firstObject;
            if ([pic1 isKindOfClass:[WBPicture class]]) {
                WBPicture* pic = pic1;
                WBPictureMetadata *bmiddle = pic.bmiddle;
                if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
                    CGFloat maxLen = kWBCellContentWidth / 2.0;
                    maxLen = CGFloatPixelRound(maxLen);
                    picSize = CGSizeMake(maxLen, maxLen);
                    picHeight = maxLen;
                } else {
                    CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
                    if (bmiddle.width < bmiddle.height) {
                        picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxLen;
                        picSize.height = maxLen;
                    } else {
                        picSize.width = maxLen;
                        picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxLen;
                    }
                    picSize = CGSizePixelRound(picSize);
                    picHeight = picSize.height;
                }
            }else if ([pic1 isKindOfClass:[UIImage class]]){
                UIImage* pic = pic1;
                if ( pic.size.width < 1 || pic.size.height < 1) {
                    CGFloat maxLen = kWBCellContentWidth / 2.0;
                    maxLen = CGFloatPixelRound(maxLen);
                    picSize = CGSizeMake(maxLen, maxLen);
                    picHeight = maxLen;
                } else {
                    CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
                    if (pic.size.width < pic.size.height) {
                        picSize.width = (float)pic.size.width / (float)pic.size.height * maxLen;
                        picSize.height = maxLen;
                    } else {
                        picSize.width = maxLen;
                        picSize.height = (float)pic.size.height / (float)pic.size.width * maxLen;
                    }
                    picSize = CGSizePixelRound(picSize);
                    picHeight = picSize.height;
                }
            }
            
           // WBPicture *pic = _status.pics.firstObject;
      

        } break;
        case 2:  {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        } break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kWBCellPaddingPic * 1;
        } break;
    }
    
    if (isRetweet) {
        _retweetPicSize = picSize;
        _retweetPicHeight = picHeight;
    } else {
        _picSize = picSize;
        _picHeight = picHeight;
    }
}


-(void)layoutDetail{
    _dtextHeight = 0;
    _dretweetHeight = 0;
    _dretweetTextHeight = 0;
    _dretweetPicHeight = 0;
    _dpicHeight = 0;
    _dtoolbarHeight = kWBCellLinkToolbarHeight;
    [self _layoutProfile];
    
    
    
    [self _layoutDetailText];
    
    [self _layoutDetailRetweet];
    
    if (_dretweetHeight == 0) {
        [self _layoutDetailPics];
        if (_dpicHeight == 0) {
            // [self _layoutCard];
        }
    }
    
    // 计算高度
    _dheight = 0;
    _dheight += _profileHeight;
    _dheight += _dtextHeight;
    if (_dretweetHeight > 0) {
        _dheight += _dretweetHeight - kWBCellPadding-kWBCellPaddingPic-_cardHeight;
    } else if (_picHeight > 0) {
        _dheight += _dpicHeight + kWBCellPaddingPic;
    }
    _dheight += _dtoolbarHeight;
    _dheight += _cardHeight;
    _dheight += 2*kWBCellPadding+ kWBCellPaddingPic;
}

/// 文本
- (void)_layoutDetailText {
    _dtextHeight = 0;
    if (_status.text.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = kWBCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(kWBCellTextFontSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(31,31,31,1)};
        
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:_status.text attributes:dic];
        
        CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(kWBCellDetailContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _textAttribute = dic;
        
        _dtextHeight = size.height+LCellPadding + 1;
    }
}
//转发
- (void)_layoutDetailRetweet {
    _dretweetHeight = 0;
    [self _layoutDetailRetweetedText];
    [self _layoutDetailRetweetPics];
    
    _dretweetHeight = _dretweetTextHeight;
    if (_dretweetPicHeight > 0) {
        _dretweetHeight += _dretweetPicHeight;
    }
    if (_dretweetHeight > 0) {
        _dretweetHeight += _cardHeight;
        _dretweetHeight +=kWBCellPadding+ kWBCellPaddingPic;
    }
    
}
- (void)_layoutDetailRetweetedText {
    _dretweetTextHeight = 0;
    if (_status.retweetedStatus.text.length>0) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.lineSpacing = kWBCellTextFontRetweetLineSpace; //设置行间距
        paraStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *dic = @{NSFontAttributeName:Font(kWBCellTextFontRetweetSize), NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(83,83,83,1)};
        
        NSString *retweetedText = [NSString stringWithFormat:@"@%@ 分享单曲：%@",_status.retweetedStatus.name,_status.retweetedStatus.text];
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:retweetedText attributes:dic];
        
        CGSize size =  [attributeText boundingRectWithSize:CGSizeMake(kWBRetweetCellDetailContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
        _retweetAttribute = dic;
        
        _dretweetTextHeight = size.height+LCellPadding;
    }
    
}


- (void)_layoutDetailPics {
    [self _layoutDetailPicsWithStatus:_status isRetweet:NO];
}

- (void)_layoutDetailRetweetPics {
    [self _layoutDetailPicsWithStatus:_status.retweetedStatus isRetweet:YES];
}


- (void)_layoutDetailPicsWithStatus:(LAttentionModel *)status isRetweet:(BOOL)isRetweet {
    if (isRetweet) {
        _dretweetPicSize = CGSizeZero;
        _dretweetPicHeight = 0;
    } else {
        _dpicSize = CGSizeZero;
        _dpicHeight = 0;
    }
    if (status.pics.count == 0) return;
    
    CGSize picSize = CGSizeZero;
    CGFloat picHeight = 0;
    
    CGFloat len1_3;
    if (isRetweet) {
        len1_3 = (kWBRetweetCellDetailContentWidth + kWBCellPaddingPic) / 2 - kWBCellPaddingPic;
    }else{
        len1_3 = (kWBCellDetailContentWidth + kWBCellPaddingPic) / 2 - kWBCellPaddingPic;
    }
    len1_3 = CGFloatPixelRound(len1_3);
    switch (status.pics.count) {
        case 1: {
            id pic1 = _status.pics.firstObject;
            if ([pic1 isKindOfClass:[WBPicture class]]) {
                WBPicture* pic = pic1;
                WBPictureMetadata *bmiddle = pic.bmiddle;
                if (pic.keepSize || bmiddle.width < 1 || bmiddle.height < 1) {
                    CGFloat maxLen = kWBCellContentWidth / 2.0;
                    maxLen = CGFloatPixelRound(maxLen);
                    picSize = CGSizeMake(maxLen, maxLen);
                    picHeight = maxLen;
                } else {
                    CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
                    if (bmiddle.width < bmiddle.height) {
                        picSize.width = (float)bmiddle.width / (float)bmiddle.height * maxLen;
                        picSize.height = maxLen;
                    } else {
                        picSize.width = maxLen;
                        picSize.height = (float)bmiddle.height / (float)bmiddle.width * maxLen;
                    }
                    picSize = CGSizePixelRound(picSize);
                    picHeight = picSize.height;
                }
            }else if ([pic1 isKindOfClass:[UIImage class]]){
                UIImage* pic = pic1;
                if ( pic.size.width < 1 || pic.size.height < 1) {
                    CGFloat maxLen = kWBCellContentWidth / 2.0;
                    maxLen = CGFloatPixelRound(maxLen);
                    picSize = CGSizeMake(maxLen, maxLen);
                    picHeight = maxLen;
                } else {
                    CGFloat maxLen = len1_3 * 2 + kWBCellPaddingPic;
                    if (pic.size.width < pic.size.height) {
                        picSize.width = (float)pic.size.width / (float)pic.size.height * maxLen;
                        picSize.height = maxLen;
                    } else {
                        picSize.width = maxLen;
                        picSize.height = (float)pic.size.height / (float)pic.size.width * maxLen;
                    }
                    picSize = CGSizePixelRound(picSize);
                    picHeight = picSize.height;
                }
            }
        } break;
        case 2:  {
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3;
        } break;
        default: { // 7, 8, 9
            picSize = CGSizeMake(len1_3, len1_3);
            picHeight = len1_3 * 2 + kWBCellPaddingPic * 1;
        } break;
    }
    
    if (isRetweet) {
        _dretweetPicSize = picSize;
        _dretweetPicHeight = picHeight;
    } else {
        _dpicSize = picSize;
        _dpicHeight = picHeight;
    }
}


@end
