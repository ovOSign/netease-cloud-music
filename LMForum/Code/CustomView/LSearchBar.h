//
//  LSearchBar.h
//  LMForum
//
//  Created by 梁海军 on 2016/12/20.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSearchBarDelegate ;

@interface LSearchBar : UIView

@property(nonatomic, weak)id<LSearchBarDelegate> delegate;

@property(nonatomic, strong)NSString *placeholder;

@property(nonatomic, strong)UIButton *playButton;

-(void)cancelTextEdit;


@end
@protocol LSearchBarDelegate<NSObject>

@optional
- (BOOL)searchBarShouldBeginEditing:(LSearchBar *)searchBar;

- (BOOL)searchBarShouldEndEditing:(LSearchBar *)searchBar;

- (void)searchBarTextDidEndEditing:(LSearchBar *)searchBar;

- (void)searchBar:(LSearchBar *)searchBar textDidChange:(NSString *)searchText;

- (void)searchBarCancelButtonClicked:(LSearchBar *)searchBar;

@end
