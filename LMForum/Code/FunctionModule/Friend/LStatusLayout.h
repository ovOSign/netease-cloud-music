//
//  LStatusLayout.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>


// 宽高
#define kWBCellTopMargin 8      // cell 顶部灰色留白
#define kWBCellTitleHeight 36   // cell 标题高度 (例如"仅自己可见")
#define kWBCellPadding 12*W_SCALE       // cell 内边距
#define kWBCellPaddingText 10   // cell 文本与其他元素间留白
#define kWBCellPaddingPic 4     // cell 多张图片中间留白
#define kWBCellProfileHeight 60*W_SCALE // cell 名片高度
#define kWBCellCardHeight 70    // cell card 视图高度
#define kWBCellNamePaddingLeft 12*W_SCALE // cell 名字和 avatar 之间留白

#define kWBCellContentWidth (S_WIDTH -40*W_SCALE-kWBCellNamePaddingLeft*2-kWBCellPadding) // cell 内容宽度

#define kWBCellDetailContentWidth (S_WIDTH -kWBCellNamePaddingLeft*2) // 详细cell 内容宽度

#define kWBCellNameWidth (S_WIDTH - 110) // cell 名字最宽限制

#define LCellPadding 10      // cell 内边距

#define LRetweetCellPadding 5      // cell 内边距

#define kWBRetweetCellContentWidth kWBCellContentWidth-2*LRetweetCellPadding // 详细retcell 内容宽度

#define kWBRetweetCellDetailContentWidth kWBCellDetailContentWidth-2*LRetweetCellPadding //详细ret cell 内容宽度


#define kWBCellTagPadding 8         // tag 上下留白
#define kWBCellTagNormalHeight 16   // 一般 tag 高度
#define kWBCellTagPlaceHeight 24    // 地理位置 tag 高度

#define kWBCellCarHeight 60*W_SCALE     // cell 下方工具栏高度

#define kWBCellCarPadding 10*W_SCALE 

#define kWBCellToolbarHeight 45*W_SCALE     // cell 下方工具栏高度
#define kWBCellLinkToolbarHeight 50*W_SCALE     // cell 下方工具栏高度
#define kWBCellToolbarBottomMargin 2 // cell 下方灰色留白

#define kWBCellToolbarButtonWidth  80// cell 下方灰色留白

// 字体 应该做成动态的，这里只是 Demo，临时写死了。
#define kWBCellNameFontSize H3      // 名字字体大小
#define kWBCellSourceFontSize 12    // 来源字体大小
#define kWBCellTextFontSize H3      // 文本字体大小
#define kWBCellTextFontRetweetSize H3 // 转发字体大小
#define kWBCellCardTitleFontSize 16 // 卡片标题文本字体大小
#define kWBCellCardDescFontSize 12 // 卡片描述文本字体大小
#define kWBCellTitlebarFontSize 14 // 标题栏字体大小
#define kWBCellToolbarFontSize 14 // 工具栏字体大小


#define kWBCellTextFontRetweetLineSpace 5 // 转发字体大小

// 颜色
#define kWBCellNameNormalColor UIColorHex(333333) // 名字颜色
#define kWBCellNameOrangeColor UIColorHex(f26220) // 橙名颜色 (VIP)
#define kWBCellTimeNormalColor UIColorHex(828282) // 时间颜色
#define kWBCellTimeOrangeColor UIColorHex(f28824) // 橙色时间 (最新刷出)

#define kWBCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kWBCellBackgroundColor UIColorHex(f2f2f2)    // Cell背景灰色
#define kWBCellHighlightColor UIColorHex(f0f0f0)     // Cell高亮时灰色
#define kWBCellInnerViewColor UIColorHex(f7f7f7)   // Cell内部卡片灰色
#define kWBCellInnerViewHighlightColor  UIColorHex(f0f0f0) // Cell内部卡片高亮时灰色
#define kWBCellLineColor [UIColor colorWithWhite:0.000 alpha:0.09] //线条颜色

#define kWBLinkHrefName @"href" //NSString
#define kWBLinkURLName @"url" //WBURL
#define kWBLinkTagName @"tag" //WBTag
#define kWBLinkTopicName @"topic" //WBTopic
#define kWBLinkAtName @"at" //NSString



/// 风格
typedef NS_ENUM(NSUInteger, WBLayoutStyle) {
    WBLayoutStyleTimeline = 0, ///< 时间线 (目前只支持这一种)
    WBLayoutStyleDetail,       ///< 详情页
};


@interface LStatusLayout : NSObject

- (instancetype)initWithStatus:(LAttentionModel *)status style:(WBLayoutStyle)style;

- (void)layout; ///< 计算布局
- (void)layoutDetail; ///计算详细布局
- (void)updateDate; ///< 更新时间字符串

// 以下是数据
@property (nonatomic, strong) LAttentionModel *status;
@property (nonatomic, assign) WBLayoutStyle style;

//以下是布局结果

// 顶部留白
@property (nonatomic, assign) CGFloat marginTop; //顶部灰色留白

@property (nonatomic, assign) CGSize nameSize; //昵称

@property (nonatomic, assign) CGFloat profileHeight; //个人资料高度(包括留白)


@property (nonatomic, assign) CGFloat textHeight; //文本高度(包括下方留白)

@property (nonatomic, assign) CGFloat dtextHeight; //文本高度(包括下方留白)


// 转发
@property (nonatomic, assign) CGFloat retweetHeight; //转发高度，0为没转发
@property (nonatomic, assign) CGFloat retweetTextHeight;

@property (nonatomic, assign) CGFloat retweetPicHeight;

@property (nonatomic, assign) CGSize retweetPicSize;

// 图片
@property (nonatomic, assign) CGFloat picHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize picSize;

// 图片
@property (nonatomic, assign) CGFloat dpicHeight; //图片高度，0为没图片
@property (nonatomic, assign) CGSize dpicSize;

// 转发
@property (nonatomic, assign) CGFloat dretweetHeight; //转发高度，0为没转发
@property (nonatomic, assign) CGFloat dretweetTextHeight;

@property (nonatomic, assign) CGFloat dretweetPicHeight;

@property (nonatomic, assign) CGSize dretweetPicSize;




@property (nonatomic, strong) NSDictionary *retweetAttribute ; //字体样式

@property (nonatomic, strong) NSDictionary *textAttribute ; //字体样式

// 卡片
@property (nonatomic, assign) CGFloat cardHeight; //卡片高度，0为没卡片

// 工具栏
@property (nonatomic, assign) CGFloat toolbarHeight; // 工具栏
@property (nonatomic, assign) CGFloat dtoolbarHeight; // 工具栏
@property (nonatomic, assign) CGFloat toolbarRepostTextWidth;
@property (nonatomic, assign) CGFloat toolbarCommentTextWidth;
@property (nonatomic, assign) CGFloat toolbarLikeTextWidth;


// 总高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat dheight;

@end
