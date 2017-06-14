//
//  RecommendViewColumnCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommendViewColumnCell.h"
#import "RecommondColumnView.h"
@interface RecommendViewColumnCell()

@property(nonatomic, strong)UIImageView *headImageView;

@property(nonatomic, strong)UILabel *headLabel;

@property(nonatomic, strong)UIButton *moreButton;

@property(nonatomic, strong)RecommondColumnView *columnView;

@property(nonatomic, strong)UIView *headView;

@end

#define RecommendColumnmoreButtonFont Font(H4)

#define RecommendColumnHeadFont Font(H1)

#define CellBottomTrimHeight 0.5

@implementation RecommendViewColumnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(RecommendColumnCellType)type{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MAINIBACKGROUNDCOLOR;
        [self setupSubviewsWith:type];

    }
    return self;
}
-(void)setupSubviewsWith:(RecommendColumnCellType)type{
    
    _headView = [[UIView alloc] init];
    _headView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_headView];
    
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [_headView addSubview:_headImageView];
    
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = RecommendColumnHeadFont;
    _headLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_headView addSubview:_headLabel];
    
    _moreButton = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:@"cm2_list_morecmt_icn_arr"];
    NSString *string = @"更多";
    [_moreButton setImage:image forState:UIControlStateNormal];
    CGSize size = [CommonUtils sizeForString:string Font:RecommendColumnmoreButtonFont ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
    _moreButton.imageEdgeInsets = UIEdgeInsetsMake(0,0+size.width,0,0-size.width);
    _moreButton.titleEdgeInsets = UIEdgeInsetsMake(0,0-image.size.width,0, 0+image.size.width);
    [_moreButton setTitle:string forState:UIControlStateNormal];
    _moreButton.titleLabel.font = RecommendColumnmoreButtonFont;
    [_moreButton setTitleColor:colorGray forState:UIControlStateNormal];
    _moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_headView addSubview:_moreButton];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_headView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellIndicatorTopMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_headView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_headView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_headView)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_headView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:_headLabel.font.lineHeight]];
    
    
    
    
    
    
    [_headView addConstraint:[NSLayoutConstraint constraintWithItem:_headView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_moreButton attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [_headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_moreButton]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_moreButton)]];
    
    
    //图片内容
    _columnView = [[RecommondColumnView alloc] init];
    _columnView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_columnView];
    
  
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_columnView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_columnView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headView]-padding-[_columnView]-margin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                              metrics:@{@"padding":@(cellIndicatorTopPadding),@"margin":@(cellIndicatorTopMargin)}
                                                                      views:NSDictionaryOfVariableBindings(_headView,_columnView)]];
    _columnView.type = type;
    
    _bottomTrim = [[UIView alloc] init];
    _bottomTrim.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomTrim.backgroundColor = RGB(186, 186, 186, 1);
    _bottomTrim.alpha = 0;
    [self addSubview:_bottomTrim];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomTrim]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_bottomTrim)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTrim(height)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"height" : @(CellBottomTrimHeight)}
                                                                   views:NSDictionaryOfVariableBindings(_bottomTrim)]];
    
    [self initHeadViewWithType:type];
    
}

-(void)initHeadViewWithType:(RecommendColumnCellType)type{
    switch (type) {
        case RecommendColumnCellTypeRecommend:{
            [_headImageView setImage:[UIImage imageNamed:@"cm2_discover_icn_recmd"]];
            [_headLabel setText:@"推荐歌单"];
        }
            
            break;
        case RecommendColumnCellTypeRadio:{
           [_headImageView setImage:[UIImage imageNamed:@"cm2_discover_icn_radio"]];
           [_headLabel setText:@"电台主播"];
        }
            
            break;
        case RecommendColumnCellTypeNewest:{
            [_headImageView setImage:[UIImage imageNamed:@"cm2_discover_icn_newest"]];
            [_headLabel setText:@"最新音乐"];
        }
            
            break;
        case RecommendColumnCellTypeExclusive:{
           [_headImageView setImage:[UIImage imageNamed:@"cm2_discover_icn_exclusive"]];
           [_headLabel setText:@"独家放送"];
        }
            
            break;
        case RecommendColumnCellTypeMv:{
           [_headImageView setImage:[UIImage imageNamed:@"cm2_discover_icn_mv"]];
            [_headLabel setText:@"推荐MV"];
        }
            
            break;
            
        default:
            break;
    }
    
    [_headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headImageView]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_headImageView)]];
    
    [_headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headImageView]|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_headImageView)]];
    
    
    [_headView addConstraint:[NSLayoutConstraint constraintWithItem:_headImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_headImageView attribute:NSLayoutAttributeHeight multiplier:_headImageView.image.size.width/_headImageView.image.size.height constant:0.0]];
    

    
    
    [_headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headLabel]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_headLabel)]];
    
    
    [_headView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_headImageView]-margin-[_headLabel]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:@{@"margin":@(cellMargin)}
                                                                   views:NSDictionaryOfVariableBindings(_headImageView,_headLabel)]];
    
}





+ (CGFloat)cellHeight:(RecommendColumnCellType)type{
    CGSize size = [CommonUtils sizeForString:@"更多" Font:RecommendColumnmoreButtonFont ConstrainedToSize:CGSizeMake(S_WIDTH, S_HEIGHT) LineBreakMode:NSLineBreakByWordWrapping];
    switch (type) {
        case RecommendColumnCellTypeRecommend:{
            return [RecommondColumnView viewHeight:RecommendColumnCellTypeRecommend]+2*cellMargin+size.height+20*H_SCALE;
        }
            break;
        case RecommendColumnCellTypeRadio:{
            return [RecommondColumnView viewHeight:RecommendColumnCellTypeRadio]+2*cellMargin+size.height+20*H_SCALE;
        }
            
            break;
        case RecommendColumnCellTypeExclusive:{
            return [RecommondColumnView viewHeight:RecommendColumnCellTypeExclusive]+2*cellMargin+size.height+20*H_SCALE;
            
        }
            
            break;
        case RecommendColumnCellTypeNewest:{
            return [RecommondColumnView viewHeight:RecommendColumnCellTypeNewest]+2*cellMargin+size.height+20*H_SCALE;

        }
            
            break;
        case RecommendColumnCellTypeMv:{
             return [RecommondColumnView viewHeight:RecommendColumnCellTypeMv]+2*cellMargin+size.height+20*H_SCALE;
        }
            break;
        default:
            break;
    }
    return 0;
   
}
@end
