//
//  BannerMenuCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/2.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "BannerMenuCell.h"
#import "LBannerMenuView.h"

@interface BannerMenuCell()<LBannerMenuDataSource,LBannerMenuDataDelegate>

@property(nonatomic, strong)LBannerMenuView *bannerlV;

@end

@implementation BannerMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
    }
    return self;
}
-(void)setupSubviews{
    _bannerlV = [[LBannerMenuView alloc] init];
    _bannerlV.dataSource = self;
    _bannerlV.delegate = self;
    _bannerlV.showPageControl = YES;
    _bannerlV.translatesAutoresizingMaskIntoConstraints = NO;
    _bannerlV.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:MAINIMAGECOLOR];
    _bannerlV.pageIndicatorTintColor = RGB(218, 219, 220, 1);
    [self addSubview:_bannerlV];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bannerlV]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_bannerlV)]];
    

    
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bannerlV]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_bannerlV)]];
    _carouseMakes = [self createCarouseUrls];
}
- (NSInteger)numberOfItemsInBannerMenuView:(LBannerMenuView *)bannerMenuView{
    return [_carouseMakes count];
}

- (GridViewBean *)gridViewBean:(LBannerMenuView *)bannerMenuView gridViewBeanForItemWithIndex:(NSInteger)index{
    return _carouseMakes[index];
}

-(NSArray *)createCarouseUrls{
    GridViewBean *bean1 = [[GridViewBean alloc] init];
    bean1.imageName = @"cm2_discover_icn_dj";
    bean1.tagName = @"明星做主播";
    bean1.index = 0;
    
    GridViewBean *bean2 = [[GridViewBean alloc] init];
    bean2.imageName = @"cm2_discover_icn_mic";
    bean2.tagName = @"创造|翻唱";
    bean2.index = 1;
    
    GridViewBean *bean3 = [[GridViewBean alloc] init];
    bean3.imageName = @"cm2_discover_icn_taklshow";
    bean3.tagName = @"脱口秀";
    bean3.index = 2;
    
    GridViewBean *bean4 = [[GridViewBean alloc] init];
    bean4.imageName = @"cm2_discover_icn_emotion";
    bean4.tagName = @"情感调频";
    bean4.index = 3;
    
    GridViewBean *bean5 = [[GridViewBean alloc] init];
    bean5.imageName = @"cm2_discover_icn_music";
    bean5.tagName = @"音乐故事";
    bean5.index = 4;
    
    GridViewBean *bean6 = [[GridViewBean alloc] init];
    bean6.imageName = @"cm2_discover_icn_drama";
    bean6.tagName = @"广播剧";
    bean6.index = 5;
    
    GridViewBean *bean7 = [[GridViewBean alloc] init];
    bean7.imageName = @"cm2_discover_icn_history";
    bean7.tagName = @"人文历史";
    bean7.index = 6;
    
    GridViewBean *bean8 = [[GridViewBean alloc] init];
    bean8.imageName = @"cm2_discover_icn_baby";
    bean8.tagName = @"亲子宝贝";
    bean8.index = 7;
    
    GridViewBean *bean9 = [[GridViewBean alloc] init];
    bean9.imageName = @"cm2_discover_icn_voicebook";
    bean9.tagName = @"美文读物";
    bean9.index = 8;
    
    GridViewBean *bean10 = [[GridViewBean alloc] init];
    bean10.imageName = @"cm2_discover_icn_abc";
    bean10.tagName = @"外语世界";
    bean10.index = 9;
    
    GridViewBean *bean11 = [[GridViewBean alloc] init];
    bean11.imageName = @"cm2_discover_icn_drama";
    bean11.tagName = @"广播剧";
    bean11.index = 10;
    
    GridViewBean *bean12 = [[GridViewBean alloc] init];
    bean12.imageName = @"cm2_discover_icn_comic";
    bean12.tagName = @"二次元";
    bean12.index = 11;
    
    GridViewBean *bean13 = [[GridViewBean alloc] init];
    bean13.imageName = @"cm2_discover_icn_trip";
    bean13.tagName = @"旅途|城市";
    bean13.index = 12;
    
    
    GridViewBean *bean14 = [[GridViewBean alloc] init];
    bean14.imageName = @"cm2_discover_icn_school";
    bean14.tagName = @"校园|教育";
    bean14.index = 13;
    
    GridViewBean *bean15 = [[GridViewBean alloc] init];
    bean15.imageName = @"cm2_discover_icn_variety";
    bean15.tagName = @"娱乐影视";
    bean15.index = 14;
    
    GridViewBean *bean16 = [[GridViewBean alloc] init];
    bean16.imageName = @"cm2_discover_icn_drama";
    bean16.tagName = @"广播剧";
    bean16.index = 15;
    
    GridViewBean *bean17 = [[GridViewBean alloc] init];
    bean17.imageName = @"cm2_discover_icn_opera";
    bean17.tagName = @"相声曲艺";
    bean17.index = 16;
    
    GridViewBean *bean18 = [[GridViewBean alloc] init];
    bean18.imageName = @"cm2_discover_icn_apply";
    bean18.tagName = @"我要当主播";
    bean18.index = 0;
    
 
    return @[bean1,bean2,bean3,bean4,bean5,bean6,bean7,bean8,bean9,bean10,bean11,
             bean12,bean13,bean14,bean15,bean16,bean17,bean18];
    
}
#pragma mark - setter
-(void)setCarouseMakes:(NSArray *)carouseMakes{
    _carouseMakes = carouseMakes;
}


+ (CGFloat)cellHeight{
    return S_WIDTH*0.5;
}
@end
