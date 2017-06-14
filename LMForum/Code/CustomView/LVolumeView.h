//
//  LVolumeView.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVolumeBar.h"

@interface LVolumeView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *volImage;

@property (weak, nonatomic) IBOutlet LVolumeBar *volBar;


@end
