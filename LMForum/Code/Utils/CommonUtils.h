//
//  CommonUtils.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/11.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommonUtils : NSObject

+(BOOL)isNull:(NSString*) str;



+(CAShapeLayer* ) layerWithCorner:(UIRectCorner) corners targetRect:(CGRect)rect cornerRadii:(CGSize)cornerRadii;


//获取字体宽度和高度（用于tablecell动态变化高度）  string:文字   Font:字体  ConstrainedToSize:最大尺寸  LineBreakMode:行分割模式
+(CGSize)sizeForString:(NSString *)string Font:(UIFont *)font ConstrainedToSize:(CGSize)constrainedSize LineBreakMode:(NSLineBreakMode)lineBreakMode;

+(CGSize)sizeForString:(NSString *)string ConstrainedToSize:(CGSize)constrainedSize attributes:(NSDictionary<NSString *, id> *)attributes;

///UIColor---->UIImage
+(UIImage *) ImageWithColor:(UIColor*)color width:(float)w height:(float) y;


+(UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
+(UIImage *)addImage:(UIImage *)image;
//0: 568 1:667 3:736 4:其他
+(NSInteger)deivceType;

+ (UIImage *)imageWithEmoji:(NSString *)emoji size:(CGFloat)size;

+ (NSNumber *)numberWithString:(NSString *)string;
+ (NSString *)stringWithUTF32Char:(UTF32Char)char32;

+ (NSString *)stringWithTimelineDate:(NSDate *)date ;

@end
