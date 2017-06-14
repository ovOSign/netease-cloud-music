//
//  LNavigationController.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "LNavigationController.h"

@interface LNavigationController ()

@end

@implementation LNavigationController


-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                  [UIFont fontWithName:@"Helvetica" size:18.0], NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
        [self.navigationBar setBackgroundImage:MAINIMAGECOLOR forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"cm2_topbar_icn_back"]];
        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"cm2_topbar_icn_back"]];
        
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



@end
