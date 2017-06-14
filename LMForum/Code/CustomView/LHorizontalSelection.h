//
//  LNavigationList.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/9.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LHorizontalSelectionDelegate;
@protocol LHorizontalSelectionDataSource;

@interface LHorizontalSelection : UIView

@property(nonatomic,weak) id<LHorizontalSelectionDelegate> delegate;
@property(nonatomic,weak) id<LHorizontalSelectionDataSource> dataSource;

@property(nonatomic, strong)NSArray *itemNameArry;

@property(nonatomic) NSInteger selectedButtonIndex;
//按钮和指示条的颜色
@property(nonatomic,strong) UIColor *selectionIndicatorColor;
//底部细线
@property(nonatomic,strong) UIColor *bottomTrimColor;

@property(nonatomic) CGFloat selectionIndicatorHeight;

@property(nonatomic) UIEdgeInsets buttonInsets;

-(instancetype) initWithFrame:(CGRect)frame itemNameArry:(NSArray*)itemNameArry;

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state;

-(void)selectionIndicatorBarScrollRatio:(CGFloat)ratio pageWidth:(CGFloat)pageWidth currentScrollWidth:(CGFloat)scrollWidth;

@end


@protocol LHorizontalSelectionDataSource <NSObject>

//- (NSInteger)numberOfItemsInSelection:(LHorizontalSelection *)selection;
//
//- (NSString *)selection:(LHorizontalSelection *)selectionList titleForItemWithIndex:(NSInteger)index;

@end

@protocol LHorizontalSelectionDelegate <NSObject>

- (void)selectionList:(LHorizontalSelection *)selection didSelectButtonWithIndex:(NSInteger)index;

@end
