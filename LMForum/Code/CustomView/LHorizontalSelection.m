//
//  LNavigationList.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/9.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LHorizontalSelection.h"

@interface  LHorizontalSelection()

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)NSMutableArray *buttons;

@property(nonatomic, strong)UIView *contentView;

@property(nonatomic, strong)UIView *bottomTrim;

@property(nonatomic, strong)UIView *selectionIndicatorBar;

@property(nonatomic, strong)NSMutableDictionary *buttonColorsByState;

@property(nonatomic, strong)NSLayoutConstraint *leftSelectionIndicatorConstraint;

@property(nonatomic, strong)NSLayoutConstraint *rightSelectionIndicatorConstraint;

@end

#define LHorizontalMargin 3

#define LHorizontalInternalPadding 15

#define LHorizontalIndicatorHeight 3

#define LHorizontalTrimHeight 0.5

#define LHorizontalFont Font(H2)


@implementation LHorizontalSelection
-(instancetype) initWithFrame:(CGRect)frame itemNameArry:(NSArray*)itemNameArry{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //scrollView
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.scrollsToTop = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_scrollView];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_scrollView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_scrollView)]];
        //contentView
        _contentView = [[UIView alloc] init];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:_contentView];
        
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_contentView
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1.0
                                                          constant:0.0]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentView]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_contentView)]];
        
        //bottomTrim
        _bottomTrim = [[UIView alloc] init];
        _bottomTrim.backgroundColor = [UIColor blackColor];
        _bottomTrim.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_bottomTrim];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomTrim]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomTrim(height)]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"height" : @(LHorizontalTrimHeight)}
                                                                       views:NSDictionaryOfVariableBindings(_bottomTrim)]];
        
        
        //selectionIndicatorBar
        _selectionIndicatorBar = [[UIView alloc]init];
        _selectionIndicatorBar.translatesAutoresizingMaskIntoConstraints = NO;
        _selectionIndicatorBar.backgroundColor = [UIColor blackColor];
        
        
        //other
        _buttonColorsByState = [NSMutableDictionary dictionary];
        _buttonColorsByState[@(UIControlStateNormal)] = [UIColor blackColor];
        _buttons = [NSMutableArray array];
        

        self.itemNameArry = itemNameArry;
        self.buttonInsets = [self calculateEdgeInsets:self.itemNameArry];
        
        
    }
    return self;
}







#pragma mark - setter/getter

-(void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor{
    self.selectionIndicatorBar.backgroundColor = selectionIndicatorColor;
    if (!self.buttonColorsByState[@(UIControlStateSelected)]) {
        self.buttonColorsByState[@(UIControlStateSelected)] = selectionIndicatorColor;
    }
}


-(UIColor *)selectionIndicatorColor {
    return self.selectionIndicatorBar.backgroundColor;
}


-(void)setBottomTrimColor:(UIColor *)bottomTrimColor {
    self.bottomTrim.backgroundColor = bottomTrimColor;
}

-(UIColor *)bottomTrimColor {
    return self.bottomTrim.backgroundColor;
}


#pragma mark - public
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    self.buttonColorsByState[@(state)] = color;
}

//先清理，再重新添加
- (void)reloadData{
    for (UIButton *button in self.buttons) {
        [button removeFromSuperview];
    }
    [self.selectionIndicatorBar removeFromSuperview];
    [self.buttons removeAllObjects];
    
    NSInteger totalButtons = [self.itemNameArry count];
    
    if (totalButtons < 1) {
        return;
    }
    
    UIButton *previousButton;
    
    for (NSInteger index = 0; index < totalButtons; index++) {
        
        NSString *buttonTitle = self.itemNameArry[index];
        
        UIButton *button = [self selectionListButtonWithTitle:buttonTitle];
        
        [self.contentView addSubview:button];
        
        if (previousButton) {
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-padding-[button]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:@{@"padding" : @(LHorizontalInternalPadding)}
                                                                                       views:NSDictionaryOfVariableBindings(previousButton, button)]];
        }else{
            [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[button]"
                                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                     metrics:@{@"margin" : @(LHorizontalMargin)}
                                                                                       views:NSDictionaryOfVariableBindings(button)]];
        }
        
        previousButton = button;
        
        [self.buttons addObject:button];
        
    }
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[previousButton]-margin-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:@{@"margin" : @(LHorizontalMargin)}
                                                                               views:NSDictionaryOfVariableBindings(previousButton)]];
    
    if (totalButtons > 0) {
        UIButton *selectedButton = self.buttons[self.selectedButtonIndex];
        selectedButton.selected = YES;
        [self.contentView addSubview:self.selectionIndicatorBar];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_selectionIndicatorBar(height)]|"
                                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                                 metrics:@{@"height" : @(LHorizontalIndicatorHeight)}
                                                                                   views:NSDictionaryOfVariableBindings(_selectionIndicatorBar)]];
        [self alignSelectionIndicatorWithButton:selectedButton];
    }
    
    [self sendSubviewToBack:self.bottomTrim];
    
    [self updateConstraintsIfNeeded];
}

- (void)layoutSubviews {
    
    if (!self.buttons.count) {
        [self reloadData];
    }
    
    [super layoutSubviews];
}

-(void)selectionIndicatorBarScrollRatio:(CGFloat)ratio pageWidth:(CGFloat)pageWidth currentScrollWidth:(CGFloat)scrollWidth{
    if (ratio == 0) {
        //如果按钮点击触发,否则滑动但未翻页
        if(self.selectedButtonIndex*pageWidth == scrollWidth){
            return;
        }else{
            UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
            [self updateSelectionIndicatorBarWithRatio:ratio oldSelectedButton:oldSelectedButton destinationButton:oldSelectedButton];
        }
    }else{
        //往右滑
        if (ratio>0) {
            
            if(ratio==1&&self.selectedButtonIndex<[self.itemNameArry count]-1){
                UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
                oldSelectedButton.selected = NO;
                 UIButton *destinationButton = self.buttons[self.selectedButtonIndex+1];
                self.selectedButtonIndex = self.selectedButtonIndex+1;
                destinationButton.selected = YES;
            }else{
                UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
                UIButton *destinationButton = self.buttons[self.selectedButtonIndex+1];
                if(ratio>=0.5){
                    self.selectedButtonIndex = self.selectedButtonIndex+1;
                    destinationButton.selected = YES;
                    oldSelectedButton.selected = NO;
                }else{
                    destinationButton.selected = NO;
                    oldSelectedButton.selected = YES;
                }
                [self updateSelectionIndicatorBarWithRatio:ratio oldSelectedButton:oldSelectedButton destinationButton:destinationButton];
            }
        }else{
            if (ratio==-1&&self.selectedButtonIndex>0) {
                UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
                oldSelectedButton.selected = NO;
                UIButton *destinationButton = self.buttons[self.selectedButtonIndex-1];
                self.selectedButtonIndex = self.selectedButtonIndex-1;
                destinationButton.selected = YES;
            }else{
                UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
                UIButton *destinationButton = self.buttons[self.selectedButtonIndex-1];
                if(ratio<=-0.5){
                    self.selectedButtonIndex = self.selectedButtonIndex-1;
                    destinationButton.selected = YES;
                    oldSelectedButton.selected = NO;
                }else{
                    destinationButton.selected = NO;
                    oldSelectedButton.selected = YES;
                }
                [self updateSelectionIndicatorBarWithRatio:ratio oldSelectedButton:oldSelectedButton destinationButton:destinationButton];
            }
        }
    }
}

#pragma mark - Private
- (UIButton *)selectionListButtonWithTitle:(NSString *)buttonTitle {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.contentEdgeInsets = self.buttonInsets;
    
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    
    for (NSNumber *controlState in [self.buttonColorsByState allKeys]) {
        [button setTitleColor:self.buttonColorsByState[controlState] forState:controlState.integerValue];
    }
    
    button.titleLabel.font = LHorizontalFont;
    
    [button sizeToFit];
    
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];

    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    return button;
}

- (void)alignSelectionIndicatorWithButton:(UIButton *)button{
    self.leftSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:button
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:0.0];
    [self.contentView addConstraint:self.leftSelectionIndicatorConstraint];
    
    self.rightSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:button
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:0.0];
    [self.contentView addConstraint:self.rightSelectionIndicatorConstraint];
}

- (void)setupSelectedButton:(UIButton *)selectedButton oldSelectedButton:(UIButton *)oldSelectedButton{
    
    [self.contentView removeConstraint:self.leftSelectionIndicatorConstraint];
    [self.contentView removeConstraint:self.rightSelectionIndicatorConstraint];
    
    [self alignSelectionIndicatorWithButton:selectedButton];
    [self layoutIfNeeded];
}
-(UIEdgeInsets)calculateEdgeInsets:(NSArray *)nameArray{
    
    if (nameArray ==NULL || [nameArray count] == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    CGFloat totalLength = 0;
    for (NSString *name in nameArray) {
        CGSize size = [CommonUtils sizeForString:name Font:LHorizontalFont ConstrainedToSize:self.frame.size LineBreakMode:NSLineBreakByWordWrapping];
        totalLength += size.width;
    }
    
    CGFloat fontHeigth = LHorizontalFont.lineHeight;
    
    CGFloat heigth = self.frame.size.height;
    
    CGFloat width = self.frame.size.width;
    
    return  UIEdgeInsetsMake((heigth-ceilf(fontHeigth))*0.5, (width-totalLength-LHorizontalMargin*2-LHorizontalInternalPadding*([nameArray count]-1))/([nameArray count]*2), (heigth-ceilf(fontHeigth))*0.5,(width-totalLength-LHorizontalMargin*2-LHorizontalInternalPadding*([nameArray count]-1))/([nameArray count]*2));
    
}

-(void)updateSelectionIndicatorBarWithRatio:(float)ratio oldSelectedButton:(UIButton *)oldSelectedButton destinationButton:(UIButton *)destinationButton{
    [self.contentView removeConstraint:self.leftSelectionIndicatorConstraint];
    [self.contentView removeConstraint:self.rightSelectionIndicatorConstraint];
    
    CGFloat leftDistance = destinationButton.frame.origin.x - oldSelectedButton.frame.origin.x;
    CGFloat rightDistance = CGRectGetMaxX(destinationButton.frame) - CGRectGetMaxX(oldSelectedButton.frame);
    self.leftSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                         attribute:NSLayoutAttributeLeft
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:destinationButton
                                                                         attribute:NSLayoutAttributeLeft
                                                                        multiplier:1.0
                                                                          constant:-(leftDistance*(1-fabsf(ratio)))];
    [self.contentView addConstraint:self.leftSelectionIndicatorConstraint];
    
    self.rightSelectionIndicatorConstraint = [NSLayoutConstraint constraintWithItem:self.selectionIndicatorBar
                                                                          attribute:NSLayoutAttributeRight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:destinationButton
                                                                          attribute:NSLayoutAttributeRight
                                                                         multiplier:1.0
                                                                           constant:-(rightDistance*(1-fabsf(ratio)))];
    [self.contentView addConstraint:self.rightSelectionIndicatorConstraint];
    
    [self layoutIfNeeded];
    
}

#pragma mark - action
- (void)buttonAction:(id)sender {
    NSInteger index = [self.buttons indexOfObject:sender];
    if (index !=NSNotFound) {
        if (index == self.selectedButtonIndex) {
            return;
        }
        UIButton *oldSelectedButton = self.buttons[self.selectedButtonIndex];
        oldSelectedButton.selected = NO;
        self.selectedButtonIndex = index;
        UIButton *tappedButton = (UIButton *)sender;
        tappedButton.selected = YES;
        if ([self.delegate respondsToSelector:@selector(selectionList:didSelectButtonWithIndex:)]) {
            [self.delegate selectionList:self didSelectButtonWithIndex:index];
        }
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:10 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
             [self setupSelectedButton:tappedButton oldSelectedButton:oldSelectedButton];
            
        } completion:^(BOOL finished) {
         
        }];
        
    }
    
}


@end
