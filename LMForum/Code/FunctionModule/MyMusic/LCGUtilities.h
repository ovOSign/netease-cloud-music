//
//  LCGUtilities.h
//  LMForum
//
//  Created by 梁海军 on 2017/3/29.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import <Foundation/Foundation.h>
/// Get main screen's scale.
CGFloat LScreenScale();

/// Convert pixel to point.
static inline CGFloat CGFloatFromPixel(CGFloat value) {
    return value / LScreenScale();
}

static inline CGFloat CGFloatPixelRound(CGFloat value) {
    CGFloat scale = LScreenScale();
    return round(value * scale) / scale;
}


static inline CGSize CGSizePixelRound(CGSize size) {
    CGFloat scale = LScreenScale();
    return CGSizeMake(round(size.width * scale) / scale,
                      round(size.height * scale) / scale);
}

static inline CGSize CGSizePixelCeil(CGSize size) {
    CGFloat scale = LScreenScale();
    return CGSizeMake(ceil(size.width * scale) / scale,
                      ceil(size.height * scale) / scale);
}

// main screen's scale
#ifndef kScreenScale
#define kScreenScale LScreenScale()
#endif

// main screen's size (portrait)
#ifndef kScreenSize
#define kScreenSize LScreenScale()
#endif
