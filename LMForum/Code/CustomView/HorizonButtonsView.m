//
//  HorizonButtons.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/18.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "HorizonButtonsView.h"
#import "AutomCancelButton.h"
@interface HorizonButtonsView(){
    NSTimer *buttonTimer;
}

@property(nonatomic, strong)NSArray *views;

@property(nonatomic, strong)NSMutableArray *buttons;

@property(nonatomic, strong)NSMutableArray *labels;


@end




@implementation HorizonButtonsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _buttons = [NSMutableArray array];
        _labels = [NSMutableArray array];
    }
    return self;
}




-(void)reloadData{
    
    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }
    
    [_buttons removeAllObjects];
    [_labels removeAllObjects];
    
    UIView *fmView = [self buttonWithName:@"私人FM" dailyNumber:nil imageName:@"cm2_discover_icn_fm" highlightedImageName:@"cm2_discover_icn_fm_prs" type:0];
    UIView *dailyView = [self buttonWithName:@"每日歌曲推荐" dailyNumber:@"16" imageName:nil highlightedImageName:@"cm2_discover_icn_daily_prs"type:1];
    UIView *upbillView = [self buttonWithName:@"云音乐热歌榜"dailyNumber:nil imageName:@"cm2_discover_icn_upbill" highlightedImageName:@"cm2_discover_icn_upbill_prs" type:0];
    self.views = @[fmView,dailyView,upbillView];
    [self addSubview:fmView];
    [self addSubview:dailyView];
    [self addSubview:upbillView];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:dailyView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[dailyView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellIndicatorTopMargin)}
                                                                   views:NSDictionaryOfVariableBindings(dailyView)]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:dailyView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:ceilf((self.frame.size.width-cellMargin*2)/3)]];
    
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[fmView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellIndicatorTopMargin)}
                                                                   views:NSDictionaryOfVariableBindings(fmView)]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:fmView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:ceilf((self.frame.size.width-cellMargin*2)/3)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[fmView]-0-[dailyView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(fmView,dailyView)]];
    
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[upbillView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellIndicatorTopMargin)}
                                                                   views:NSDictionaryOfVariableBindings(upbillView)]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:upbillView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:ceilf((self.frame.size.width-cellMargin*2)/3)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[dailyView]-0-[upbillView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(dailyView,upbillView)]];
}

- (void)layoutSubviews {
    
    if (!self.views.count) {
        [self reloadData];
    }
    [super layoutSubviews];
}

-(UIView*)buttonWithName:(NSString *)name dailyNumber:(NSString *)dailyNumber imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName type:(NSInteger)type{
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    UIImage *image;
    UIImage *highlightedImage;
    if (type == 0) {
        image = [self addImage:[UIImage imageNamed:imageName] toImage:[UIImage imageNamed:@"cm2_discover_icn_daily"]];
        highlightedImage = [UIImage imageNamed:highlightedImageName];
    }
    if (type == 1) {
        image = [self addString:dailyNumber toImage:[UIImage imageNamed:@"cm2_discover_icn_daily"]state:UIControlStateNormal];
        highlightedImage = [self addString:dailyNumber toImage:[UIImage imageNamed:highlightedImageName]state:UIControlStateHighlighted];
    }
    AutomCancelButton *imageView = [AutomCancelButton buttonWithType:UIButtonTypeCustom];
    [imageView setImage:image forState:UIControlStateNormal];
    [imageView setImage:highlightedImage forState:UIControlStateHighlighted];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:imageView];
    
    UIButton *label = [UIButton buttonWithType:UIButtonTypeCustom];
    label.userInteractionEnabled = YES;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.titleLabel.font = Font(H3);
    [label setTitle:name forState:UIControlStateNormal];
    [label setTitleColor:RGB(38, 38, 38, 1) forState:UIControlStateNormal];
    CGSize size = [CommonUtils sizeForString:name Font:Font(H3) ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
    label.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [label sizeToFit];
    [view addSubview:label];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [view addConstraint: [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:image.size.width]];
    
    [view addConstraint: [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:image.size.height]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(imageView)]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(label)]];
    [view addConstraint: [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:size.width]];
    [view addConstraint: [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:size.height]];
    
    
    [_buttons addObject:imageView];
    [_labels addObject:label];
    
    
 
    [label addTarget:self action:@selector(labelUpInsideActon:) forControlEvents:UIControlEventTouchUpInside];
    
    [label addTarget:self action:@selector(labelDownActon:) forControlEvents:UIControlEventTouchDown];
    
    [imageView addTarget:self action:@selector(buttonUpInsideActon:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return view;
}



- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    
    UIGraphicsBeginImageContextWithOptions (image2.size, NO , 0.0 );
    
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (UIImage *)addString:(NSString *)string toImage:(UIImage *)image2 state:(UIControlState)state{
    
    UIGraphicsBeginImageContextWithOptions (image2.size, NO , 0.0 );
    
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    CGContextRef context= UIGraphicsGetCurrentContext ();
    
    CGContextDrawPath (context, kCGPathStroke);
    
    CGFloat fontSize = H1+4;
    CGSize size = [CommonUtils sizeForString:string Font:Font(fontSize) ConstrainedToSize:image2.size LineBreakMode:NSLineBreakByWordWrapping];
    [string drawAtPoint : CGPointMake ( (image2.size.width-size.width-3)*.5 , (image2.size.height-size.height)*.5) withAttributes : [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:fontSize], NSFontAttributeName,state == UIControlStateHighlighted?[UIColor whiteColor]:[UIColor colorWithPatternImage:MAINIMAGECOLOR],NSForegroundColorAttributeName,nil]];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
#pragma mark - action

-(void)labelDownActon:(UIButton*)button{
    NSInteger index = [self.labels indexOfObject:button];
    if (index !=NSNotFound) {
        UIButton *button = self.buttons[index];
        button.highlighted = YES;
        if(!buttonTimer){
            buttonTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
                button.highlighted = NO;
                [buttonTimer invalidate];
                buttonTimer = nil;
            }];
        }

    }
}
-(void)labelUpInsideActon:(UIButton*)button{
    NSInteger index = [self.labels indexOfObject:button];
    if (index !=NSNotFound) {
        UIButton *button = self.buttons[index];
         if (button.highlighted) {
        button.highlighted = NO;
        [self buttonUpInsideActon:button];
    }
}
}

-(void)buttonUpInsideActon:(UIButton*)button{

}


@end
