//
//  CarouselView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/12.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LCarouselView.h"
#import "LPageControl.h"

@interface LCarouselView()<UIScrollViewDelegate,LPageControlDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)LPageControl *pageControl;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic)NSInteger currentPageIndex;

@property(nonatomic, strong)NSMutableArray *carouselUrls;

@property(nonatomic, strong)NSMutableArray *views;

@property(nonatomic)NSInteger urlNumber;

@end

#define LCarouselPageControlHeight 20

#define LCarouselPageIndicatorWidth 30

@implementation LCarouselView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        
        
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_contentView];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        _views = [NSMutableArray array];
        _carouselUrls = [NSMutableArray array];
        
    }
    return self;
}

#pragma mark - setter/getter
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
-(UIColor *)pageIndicatorTintColor{
    
    return _pageControl.pageIndicatorTintColor;

}

-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

-(UIColor *)currentPageIndicatorTintColor{

    return _pageControl.currentPageIndicatorTintColor;

}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[LPageControl alloc]init];
        _pageControl.delegate = self;
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    }
    return _pageControl;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= 2*scrollView.frame.size.width) {
        [self changeImagePageWithRightSrcoll];
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    if (scrollView.contentOffset.x <= 0) {
        [self changeImagePageWithLeftSrcoll];
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if(!(scrollView.contentOffset.x == 0)&&(scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width<-0.5){
//       [self changeImagePageWithLeftSrcoll];
//       [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
//    }
//    else if(!(scrollView.contentOffset.x == 2*scrollView.frame.size.width)&&(scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width>0.5){
//       [self changeImagePageWithRightSrcoll];
//       [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
//    }
    
      [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];   
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}

#pragma mark - LPageControlDelegate

-(void)pageControl:(LPageControl *)pageControl didSelectPageIndex:(NSInteger)index{
    if (self.currentPageIndex == index) {
        return;
    }
    [self changeImagePageWithRightTap:index];
}

#pragma mark - public
-(void)next{
    
}

-(void)reloadData{
    for (LCarouseImageView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    NSInteger total = [self.dataSource numberOfItemsInCarouselView:self];
    if (total < 1) {
        return;
    }
    self.urlNumber = total;
    NSInteger totalViews = 0;
    
    if (total == 1) totalViews = 1;else totalViews = 3;
    
    for (NSInteger index = 0; index < total; index++){
       CarouselUrl *url= [self.dataSource carouselView:self carouseUrlForItemWithIndex:index];
        url.index = index;
        [self.carouselUrls addObject:url];
    }
    
    LCarouseImageView *previousView;
    
    for (NSInteger index = 0; index < totalViews; index++){
        LCarouseImageView *imageView = [self imageViewWithTag:index];
        [self.contentView addSubview:imageView];
        if (previousView) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]-0-[imageView]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(previousView, imageView)]];
        }else {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:nil
                                                                                       views:NSDictionaryOfVariableBindings(imageView)]];
        }
        
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.frame.size.height]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:self.frame.size.width]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeCenterY
                                                                    multiplier:1.0
                                                                      constant:0.0]];
        
        previousView = imageView;
        
        [self.views addObject:imageView];
        
        
    }
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousView]|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(previousView)]];
    if(totalViews ==3 )[_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
    if(self.showPageControl)[self addPageControltoView];
    
    [self reloadImagePage];
   
    [self updateConstraintsIfNeeded];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.views.count) {
        [self reloadData];
    }
  
}
#pragma mark - Private Methods
-(void)addPageControltoView{
   
    NSInteger total = [self.carouselUrls count];
    self.pageControl.numberOfPages = total;
    self.pageControl.currentPage = 0;
    [self addSubview:_pageControl];
        
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl(height)]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"height" : @(LCarouselPageControlHeight)}
                                                                       views:NSDictionaryOfVariableBindings(_pageControl)]];
        
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:total*LCarouselPageIndicatorWidth]];
        
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1.0
                                                          constant:0.0]];
        
    [self bringSubviewToFront:_pageControl];
 
}

-(LCarouseImageView *)imageViewWithTag:(NSInteger )tag{
    LCarouseImageView *imageView = [[LCarouseImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.tag = tag;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageActon:)]];
    return imageView;
}
-(void)tagViewWithTitle:(NSString*)title{
    UIView *tagView = [[UIView alloc] init];
    tagView.translatesAutoresizingMaskIntoConstraints = NO;
    
}

//初始化时
-(void)reloadImagePage{
    if ([_carouselUrls count] > 1 ){
        CarouselUrl *endUrl = [_carouselUrls lastObject];
        if ([_carouselUrls count]!=2) [_carouselUrls removeObject:endUrl];
        [_carouselUrls insertObject:endUrl atIndex:0];
    }
    [self setImageToImageViews];

}
//向左滑动
-(void)changeImagePageWithLeftSrcoll{
    if (self.urlNumber == 2){
        [_carouselUrls removeLastObject];
        CarouselUrl *lastTwoUrl = [_carouselUrls lastObject];
        [_carouselUrls insertObject:lastTwoUrl atIndex:0];
        
    }else{
        CarouselUrl *endUrl = [_carouselUrls lastObject];
        [_carouselUrls removeObject:endUrl];
        [_carouselUrls insertObject:endUrl atIndex:0];
        
    }
    [self setImageToImageViews];
}

//向右滑动
-(void)changeImagePageWithRightSrcoll{
    if (self.urlNumber == 2){
        [_carouselUrls removeObjectAtIndex:0];
        CarouselUrl *secondUrl = [_carouselUrls firstObject];
        [_carouselUrls addObject:secondUrl];
    }else{
       CarouselUrl *firstUrl = [_carouselUrls firstObject];
       [_carouselUrls removeObject:firstUrl];
       [_carouselUrls addObject:firstUrl];
    }
    [self setImageToImageViews];
}
//点击选择
-(void)changeImagePageWithRightTap:(NSInteger)index{
    if (self.urlNumber ==2 ) {
        if (self.currentPageIndex<index){
            [_carouselUrls removeObjectAtIndex:0];
            CarouselUrl *secondUrl = [_carouselUrls firstObject];
            [_carouselUrls addObject:secondUrl];
        }else{
            [_carouselUrls removeLastObject];
            CarouselUrl *lastTwoUrl = [_carouselUrls lastObject];
            [_carouselUrls insertObject:lastTwoUrl atIndex:0];
        }
        [self setImageToImageViews];
        return;
    }
    if ((self.currentPageIndex - index) == 1) {
        CarouselUrl *endUrl = [_carouselUrls lastObject];
        [_carouselUrls removeObject:endUrl];
        [_carouselUrls insertObject:endUrl atIndex:0];
        [self setImageToImageViews];
    }else{
        NSInteger tapIndex = 0;
        if (self.currentPageIndex<index) {
            tapIndex = index-self.currentPageIndex+1;
        }else{
            tapIndex = [_carouselUrls count] - (self.currentPageIndex-index-1);
        }
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < tapIndex-1; i ++) {
            CarouselUrl* url = [_carouselUrls objectAtIndex:i];
            [array addObject:url];
        }
        [_carouselUrls removeObjectsInArray:array];
        [_carouselUrls addObjectsFromArray:array];
        [self setImageToImageViews];
    }
}

-(void)setImageToImageViews{
    for (LCarouseImageView *view in self.views) {
        NSInteger index = view.tag;
        CarouselUrl* url = [_carouselUrls objectAtIndex:index];
        if (index == 1){
         self.currentPageIndex = url.index;
         if (_pageControl) _pageControl.currentPage = url.index;
        }
       [view sd_setImageWithURL:[NSURL URLWithString:url.url] placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_banner"]];
        if (url.tagName.length>0) [view setTagName:url.tagName model:url.model];
    }
}
#pragma mark - action
-(void)pageActon:(LCarouseImageView* )imageView{
    if ([self.delegate respondsToSelector:@selector(carouselView:didSelectPageWithIndex:)]) {
        [self.delegate carouselView:self didSelectPageWithIndex:self.currentPageIndex];
    }
}


@end
