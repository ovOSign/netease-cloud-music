//
//  RecommendViewHeaderCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/18.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommendViewHeaderCell.h"
#import "LCarouselView.h"
#import "CarouselUrl.h"

@interface RecommendViewHeaderCell()<LCarouselDataSource,LCarouselDataDelegate>

@property(nonatomic, strong)LCarouselView *carouselV;

@end

@implementation RecommendViewHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.backgroundColor = [UIColor clearColor];
       [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews{
    _carouselV = [[LCarouselView alloc] init];
    _carouselV.dataSource = self;
    _carouselV.delegate = self;
    _carouselV.showPageControl = YES;
    _carouselV.translatesAutoresizingMaskIntoConstraints = NO;
    _carouselV.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:MAINIMAGECOLOR];
    [self addSubview:_carouselV];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_carouselV]|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_carouselV)]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:_carouselV attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_carouselV attribute:NSLayoutAttributeWidth multiplier:0.35 constant:0]];
    

    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_carouselV]"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_carouselV)]];
    
   // _carouseMakes = [self createCarouseUrls];
}


-(NSArray *)createCarouseUrls{
    CarouselUrl *url0 = [[CarouselUrl alloc] init];
    url0.url = @"http://img1.c.yinyuetai.com/others/admin/161213/0/9a27155032001ce981f9fff995ffdd75_0x0.jpg";
    url0.tagName = @"专栏";
    url0.model = LTagViewModelNormal;
    CarouselUrl *url1 = [[CarouselUrl alloc] init];
    url1.url = @"http://img3.c.yinyuetai.com/others/admin/161212/0/9a47308c2f13c31fa7790097cac28d16_0x0.jpg";
    url1.tagName = @"话题";
    url1.model = LTagViewModelHot;
    CarouselUrl *url2 = [[CarouselUrl alloc] init];
    url2.url = @"http://img3.c.yinyuetai.com/others/admin/161209/0/b7d84da50d620ceee4722e6301be397a_0x0.jpg";
    url2.tagName = @"活动";
    url2.model = LTagViewModelNormal;
    CarouselUrl *url3 = [[CarouselUrl alloc] init];
    url3.url = @"http://img4.c.yinyuetai.com/others/admin/161212/0/4a0bb90aed270122347308a66999e14f_0x0.jpg";
    url3.tagName = @"独家首发";
    url3.model = LTagViewModelNormal;
    CarouselUrl *url4 = [[CarouselUrl alloc] init];
    url4.url = @"http://img1.c.yinyuetai.com/others/admin/161210/0/8e516487c0d8dedc529946138ad99022_0x0.jpg";
    url4.tagName = @"明星访谈";
    url4.model = LTagViewModelHot;
    CarouselUrl *url5 = [[CarouselUrl alloc] init];
    url5.url = @"http://img1.c.yinyuetai.com/others/admin/161210/0/8e516487c0d8dedc529946138ad99022_0x0.jpg";
    url5.tagName = @"明星访谈";
    url5.model = LTagViewModelHot;
    return @[url0,url1,url2,url3,url4];
}

#pragma mark - setter 
-(void)setCarouseMakes:(NSArray *)carouseMakes{
    _carouseMakes = carouseMakes;
}

#pragma mark - LCarouselDataSource
- (NSInteger)numberOfItemsInCarouselView:(LCarouselView *)carouselView{
    return [_carouseMakes count];
}

- (CarouselUrl *)carouselView:(LCarouselView *)carouselView carouseUrlForItemWithIndex:(NSInteger)index{
    return _carouseMakes[index];
}

#pragma mark - LCarouselDataDelegate
- (void)carouselView:(LCarouselView *)carouselView didSelectPageWithIndex:(NSInteger)index{

}

+ (CGFloat)cellHeight{
    return S_WIDTH*0.35;
}
@end
