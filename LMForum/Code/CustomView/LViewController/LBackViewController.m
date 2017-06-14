//
//  LBackViewController.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/7.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LBackViewController.h"

@interface LBackViewController ()

@property(nonatomic, strong)UIBarButtonItem *backButtonItem;

@property(nonatomic, strong)UIBarButtonItem *spaceL;

@end

@implementation LBackViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"Helvetica" size:18.0], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:self.spaceL, self.backButtonItem, nil];
    
    [self.navigationController.navigationBar setBackgroundImage:MAINIMAGECOLOR forBarMetrics:UIBarMetricsDefault];
}



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(UIBarButtonItem*)spaceL{
    if (!_spaceL) {
        _spaceL = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        _spaceL.width = -20.0f;
    }
    return _spaceL;
}
-(UIBarButtonItem*)backButtonItem{
    if (!_backButtonItem) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"cm2_topbar_icn_back"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(0, 0, 40, 30);
        [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        _backButtonItem =  [[UIBarButtonItem alloc]initWithCustomView:backButton];
        
    }
    return _backButtonItem;
}

-(void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
}


@end
