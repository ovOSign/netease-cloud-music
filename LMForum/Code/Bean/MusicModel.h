//
//  MusicModel.h
//  Music
//
//  Created by hanlei on 16/7/21.
//  Copyright © 2016年 hanlei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filename;
@property (nonatomic, copy) NSString *lrcname;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, copy) NSString *singerIcon;
@property (nonatomic, copy) id icon;
@property (nonatomic) int count;

@end
