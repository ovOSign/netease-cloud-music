//
//  RecommondColumnView.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecommondColumnView : UIView

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic) RecommendColumnCellType type;

+ (CGFloat)viewHeight:(RecommendColumnCellType)type;
@end
