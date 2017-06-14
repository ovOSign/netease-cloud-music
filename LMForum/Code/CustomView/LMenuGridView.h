//
//  LMenuGridView.h
//  LMForum
//
//  Created by 梁海军 on 2017/2/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMenuGridView : UIView

@property (strong, nonatomic) NSMutableArray *dataArray;

-(void)reloadData;

@end
