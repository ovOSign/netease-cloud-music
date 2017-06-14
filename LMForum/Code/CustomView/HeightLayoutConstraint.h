//
//  HeightLayoutConstraint.h
//  App
//
//  Created by Yu on 16/3/19.
//  Copyright © 2016年 HangZhou QiYi Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 注意：xib中使用的约束(LayoutConstraint)是以   高度    为依据或者是指定2个控件之间的  纵向     距离时，可以继承此类
 注意：xib中的约束(LayoutConstraint)继承此类后可以自动按比例缩放约束的值的大小,不用在代码中重新更改
 注意：实际测试发现缩放后可能产生误差(小于2%),在承受范围之内，可以放心使用(具体原因为明,以后有空在看)
 (前提：保持xib布局高度为800)
 
 */

@interface HeightLayoutConstraint : NSLayoutConstraint

-(CGFloat)constant;

@end
