//
//  LCommentLayout.h
//  LMForum
//
//  Created by 梁海军 on 2017/4/1.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>


#define LComCellAvatar 30*W_SCALE     // 名字字体大小

#define LComCellTopMargin 20*W_SCALE     // cell 顶部灰色留白

#define LComCellPadding 12*W_SCALE       // cell 内边距

#define LComProfileHeight 54*W_SCALE // cell 名片高度

#define LCellPadding 10      // cell 内边距

#define LRetweetCellPadding 5      // cell 内边距

#define LComCellNameWidth (S_WIDTH - 110)

#define LComCellNameFontSize H4      // 名字字体大小

#define LComCellTextFontRetweetLineSpace 8 // 转发字体大小

#define LComCellTextFontSize H4      // 文本字体大小
#define LComCellRetweetTextFontSize H4      // 文本字体大小





#define LComCellContentWidth (S_WIDTH -LComCellAvatar-LComCellPadding*3) // cell 内容宽度

#define LComRetweetCellContentWidth  LComCellContentWidth-2*LRetweetCellPadding // cell 引用内容宽度



@interface LCommentLayout : NSObject

@property (nonatomic, strong) LCommentModel *status;

@property (nonatomic, assign) CGFloat profileHeight; //个人资料高度(包括留白)

@property (nonatomic, assign) CGSize nameSize; //昵称

@property (nonatomic, assign) CGFloat textHeight; //文本高度(包括下方留白)

@property (nonatomic, assign) CGFloat retweetHeight; //转发高度，0为没转发

@property (nonatomic, assign) CGFloat retweetTextHeight;

@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

@property (nonatomic, assign) CGFloat marginBottom; //底部灰色留白

@property (nonatomic, strong) NSDictionary *retweetAttribute ; //字体样式

@property (nonatomic, strong) NSDictionary *textAttribute ; //字体样式

// 总高度
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithStatus:(LCommentModel *)status;

- (void)updateDate; ///< 更新时间字符串

@end
