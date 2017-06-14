//
//  LLrcMainView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LLrcMainView.h"
#import "LVolumeBar.h"

@interface LLrcMainView()

@end

#define padding 0

@implementation LLrcMainView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    [self addSubview:self.volumeView];
    [self addSubview:self.lrcScrollView];
    }
    return self;
}


#pragma mark - getter
-(void)setDelegate:(id<LLrcMainViewDelegate>)delegate{
    _delegate = delegate;
    if ([_lrcScrollView isKindOfClass:[LLrcScrollView class]]) {
        [(LLrcScrollView *)_lrcScrollView setDelegate:(id<LLrcScrollViewDelegate>)delegate];
    }
    if([_volumeView.volBar isKindOfClass:[LVolumeBar class]]){
         [(LVolumeBar *)_volumeView.volBar setDelegate:(id<LVolumeBarDelegate>)delegate];
    }
}


-(LLrcScrollView*)lrcScrollView{
    if (!_lrcScrollView) {
        _lrcScrollView = [[LLrcScrollView alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(_volumeView.frame), self.frame.size.width-padding*2, self.frame.size.height-_volumeView.frame.size.height)];
    }
    return _lrcScrollView;
}



-(LVolumeView*)volumeView{
    if (!_volumeView) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"LVolumeView" owner:nil options:nil];
        _volumeView = [array objectAtIndex:0];
        CGFloat height = self.frame.size.width*50/400;
        _volumeView.frame = CGRectMake(0,0, self.frame.size.width,height);
    }
    
    return _volumeView;
}


-(void)reloadLrcArray:(NSMutableArray*)array{
    self.lrcScrollView.dataArray = array;
    [self.lrcScrollView reloadData];
}

- (void)setVolumeValueByRatio:(float)ratio animated:(BOOL)animated{
    [_volumeView.volBar setRatio:ratio animated:YES];
}

- (void)setVolumeValue:(float)value{
    [_volumeView.volBar setVolumeValue:value];
}

@end
