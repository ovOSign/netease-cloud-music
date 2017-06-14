//
//  LViewController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LViewController.h"

@interface LViewController ()

@property(nonatomic , strong)UIButton *playButton;

@property(nonatomic , strong)UIBarButtonItem *spaceR;

@property(nonatomic , strong)UIBarButtonItem *playBtnItem;

@end

@implementation LViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = MAINIBACKGROUNDCOLOR;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"Helvetica" size:18.0], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setBackgroundImage:MAINIMAGECOLOR forBarMetrics:UIBarMetricsDefault];
}

-(void)setChildViewAutoMoveDown64:(BOOL)on
{
    if (on) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            self.edgesForExtendedLayout =  UIRectEdgeNone;
        }
    }else{
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
}

@end
