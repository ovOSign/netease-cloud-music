//
//  LSongMenuHeadView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/24.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuHeadState) {
    MenuHeadStateFold = 0,
    
    MenuHeadStateDown = 1,
    
};

@interface LSongMenuHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *foldImageView;

@property (weak, nonatomic) IBOutlet UILabel *title;
//0 折叠 1展开
@property(nonatomic) MenuHeadState state;

@end
