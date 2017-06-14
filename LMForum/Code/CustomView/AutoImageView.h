//
//  AutoImageView.h
//  App
//
//  Created by Yu on 16/1/22.
//  Copyright © 2016年 HangZhou QiYi Technology Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
注意：官方文档说明:UIImageView是专门为显示图片做的控件，用了最优显示技术，是不让调用darwrect方法.
 所以这里的操作在xib中是可以显示的，但但运行是是没有效果的，所以这里的操作要在代码中重新设置
 
 */



IB_DESIGNABLE
@interface AutoImageView : UIImageView

@property (nonatomic) IBInspectable CGFloat cornerRadius;//圆角

@property (nonatomic) IBInspectable UIImage *img;//图片

@end
