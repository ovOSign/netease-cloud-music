//
//  LENUM.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/22.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LENUM : NSObject
//个性推荐
typedef NS_ENUM(NSInteger, RecommendColumnCellType) {
    RecommendColumnCellTypeRecommend = 0,
    
    RecommendColumnCellTypeExclusive = 1,
    
    RecommendColumnCellTypeNewest    = 2,
    
    RecommendColumnCellTypeMv        = 3,
    
    RecommendColumnCellTypeRadio     = 4,
};



//播放界面
typedef NS_ENUM(NSInteger, PlayMusicState) {
    PlayMusicStateInit = 0,

    PlayMusicStatePause = 1,
    
    PlayMusicStatePlay = 2,
    
    PlayMusicStateChange = 3,
    
};




@end
