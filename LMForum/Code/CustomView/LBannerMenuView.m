//
//  LBannerMenuView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/26.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LBannerMenuView.h"
#import "LMenuGridView.h"
#import "GridViewPage.h"
#import "LPageControl.h"
@interface LBannerMenuView()<UIScrollViewDelegate,LPageControlDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)NSMutableArray *views;

@property(nonatomic, strong)NSMutableArray *gridBeans;

@property(nonatomic, strong)NSMutableArray *gridSortArray;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic)NSInteger currentPageIndex;

@property(nonatomic)NSInteger viewNumber;
@property(nonatomic)NSInteger gridNumber;


@property(nonatomic, strong)LPageControl *pageControl;

@end

#define GRIDVIEWNUM 8

#define LCarouselPageControlHeight 20

#define LCarouselPageIndicatorWidth 30

@implementation LBannerMenuView

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
        _gridBeans = [NSMutableArray array];
        _gridSortArray = [NSMutableArray array];
        
    }
    return self;
} 


-(void)reloadData{
    for (LMenuGridView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    NSInteger total = [self.dataSource numberOfItemsInBannerMenuView:self];
    if (total < 1) {
        return;
    }
    self.viewNumber = total%GRIDVIEWNUM==0?total/GRIDVIEWNUM:total/GRIDVIEWNUM+1;
    self.gridNumber = total;
    NSInteger totalViews = 0;
    
    if (total <= GRIDVIEWNUM) totalViews = 1;else totalViews = 3;
    
    NSMutableArray *currentSortArray = [NSMutableArray array];
    for (NSInteger index = 0; index < total; index++){
        GridViewBean *gridBean= [self.dataSource gridViewBean:self gridViewBeanForItemWithIndex:index];
        [self.gridBeans addObject:gridBean];
        
        
        if ((index+1)%GRIDVIEWNUM == 0||index+1 == self.gridNumber) {
        
            [currentSortArray addObject:gridBean];
            GridViewPage *page = [[GridViewPage alloc] init];
            page.gridArray = [currentSortArray copy];
            if ((index+1)%GRIDVIEWNUM!=0) {
                page.index = (index+1)/GRIDVIEWNUM;
            }else{
                page.index = (index+1)/GRIDVIEWNUM-1;
            }
            
            [_gridSortArray addObject:page];
            currentSortArray = [NSMutableArray array];
        }else{
            [currentSortArray addObject:gridBean];
        }
    }
    
    LMenuGridView *previousView;

    for (NSInteger index = 0; index < totalViews; index++){
        
        LMenuGridView *imageView = [[LMenuGridView alloc] init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.tag = index;
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
   if(totalViews == 3) [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
    if(self.showPageControl)[self addPageControltoView];
    
    [self reloadBannerPage];
    
    [self updateConstraintsIfNeeded];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!self.views.count) {
        [self reloadData];
    }
    
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[LPageControl alloc]init];
        _pageControl.delegate = self;
        _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _pageControl;
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



//初始化时
-(void)reloadBannerPage{
    if ([_gridSortArray count] > 1 ){
        GridViewPage *endUrl = [_gridSortArray lastObject];
        if ([_gridSortArray count]!=2) [_gridSortArray removeObject:endUrl];
        [_gridSortArray insertObject:endUrl atIndex:0];
    }
    [self setToMenuGridView];
    
}

//向左滑动
-(void)changeImagePageWithLeftSrcoll{
    if (self.viewNumber == 2){
        [_gridSortArray removeLastObject];
        GridViewPage *lastTwoUrl = [_gridSortArray lastObject];
        [_gridSortArray insertObject:lastTwoUrl atIndex:0];
        
    }else{
        GridViewPage *endUrl = [_gridSortArray lastObject];
        [_gridSortArray removeObject:endUrl];
        [_gridSortArray insertObject:endUrl atIndex:0];
        
    }
    [self setToMenuGridView];
}

//向右滑动
-(void)changeImagePageWithRightSrcoll{
    if (self.viewNumber == 2){
        [_gridSortArray removeObjectAtIndex:0];
        GridViewPage *secondUrl = [_gridSortArray firstObject];
        [_gridSortArray addObject:secondUrl];
    }else{
        GridViewPage *firstUrl = [_gridSortArray firstObject];
        [_gridSortArray removeObject:firstUrl];
        [_gridSortArray addObject:firstUrl];
    }
    [self setToMenuGridView];
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
    if(!(scrollView.contentOffset.x == 0)&&(scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width<-0.5){
        [self changeImagePageWithLeftSrcoll];
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    else if(!(scrollView.contentOffset.x == 2*scrollView.frame.size.width)&&(scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width>0.5){
        [self changeImagePageWithRightSrcoll];
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    }
    
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
//点击选择
-(void)changeImagePageWithRightTap:(NSInteger)index{
    if (self.viewNumber ==2 ) {
        if (self.currentPageIndex<index){
            [_gridSortArray removeObjectAtIndex:0];
            GridViewPage *secondUrl = [_gridSortArray firstObject];
            [_gridSortArray addObject:secondUrl];
        }else{
            [_gridSortArray removeLastObject];
            GridViewPage *lastTwoUrl = [_gridSortArray lastObject];
            [_gridSortArray insertObject:lastTwoUrl atIndex:0];
        }
        [self setToMenuGridView];
        return;
    }
    if ((self.currentPageIndex - index) == 1) {
        GridViewPage *endUrl = [_gridSortArray lastObject];
        [_gridSortArray removeObject:endUrl];
        [_gridSortArray insertObject:endUrl atIndex:0];
        [self setToMenuGridView];
    }else{
        NSInteger tapIndex = 0;
        if (self.currentPageIndex<index) {
            tapIndex = index-self.currentPageIndex+1;
        }else{
            tapIndex = [_gridSortArray count] - (self.currentPageIndex-index-1);
        }
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < tapIndex-1; i ++) {
            GridViewPage* url = [_gridSortArray objectAtIndex:i];
            [array addObject:url];
        }
        [_gridSortArray removeObjectsInArray:array];
        [_gridSortArray addObjectsFromArray:array];
        [self setToMenuGridView];
    }
}


#pragma mark - Private Methods
-(void)addPageControltoView{
    
    NSInteger total = self.viewNumber;
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


-(void)setToMenuGridView{
    for (LMenuGridView *view in self.views) {
        NSInteger index = view.tag;
        GridViewPage* page = [_gridSortArray objectAtIndex:index];
        if (index == 1){
            self.currentPageIndex = page.index;
            if (_pageControl) _pageControl.currentPage = page.index;
        }
        view.dataArray = page.gridArray;
        [view reloadData];
    }
}

@end
