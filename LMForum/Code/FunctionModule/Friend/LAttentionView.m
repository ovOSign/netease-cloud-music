//
//  LAttentionView.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/28.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LAttentionView.h"
#import "LStatusCell.h"
@interface LAttentionView()<UITableViewDelegate,UITableViewDataSource,LStatusCellDelegate>

@property(nonatomic, strong)UIView *defaultFooterView;


@property(nonatomic, strong)UIButton *newactView;


@end

@implementation LAttentionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = self.defaultFooterView;
        [self addSubview:_tableView];
        
        [self addSubview:self.newactView];

        _layouts = [NSMutableArray new];
    }
    return self;
}


#pragma mark - getter
- (UIView *)defaultFooterView{
    if (_defaultFooterView == nil) {
        _defaultFooterView = [[UIView alloc] init];
    }
    
    return _defaultFooterView;
}

-(UIButton *)newactView{
    if (!_newactView) {
        UIImage *imag = [UIImage imageNamed:@"cm2_act_newact"];

        
        _newactView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_newactView setImage:[UIImage imageNamed:@"cm2_act_newact_bg"] forState:UIControlStateNormal];
        [_newactView setImage:[UIImage imageNamed:@"cm2_act_newact_bg_prs"] forState:UIControlStateHighlighted];
        _newactView.frame = CGRectMake(15, self.frame.size.height-49-15-imag.size.height, imag.size.width, imag.size.height);
        [_newactView addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];

        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.bounds = CGRectMake(0, 0, imag.size.width, imag.size.height);
        imgView.center = CGPointMake(_newactView.frame.size.width*.5, _newactView.frame.size.height*.5);
        [imgView setImage:imag];
        [_newactView addSubview:imgView];
        

    }
    return _newactView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_layouts count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = @"cell";
    LStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = (id<LStatusCellDelegate>)_delegate;
    }
    [cell setLayout:_layouts[indexPath.row]];
    return cell;

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return 1;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return ((LStatusLayout *)_layouts[indexPath.row]).height;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(attentionView:didSelectDetailModel:)]) {
        [self.delegate attentionView:self didSelectDetailModel:_layouts[indexPath.row]];
    }

}




-(void)shareAction:(UIButton*)button{
    if ([self.delegate respondsToSelector:@selector(attentionView:didShareAction:)]) {
        [self.delegate attentionView:self didShareAction:button];
    }
}

@end
