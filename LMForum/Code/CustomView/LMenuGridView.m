//
//  LMenuGridView.m
//  LMForum
//
//  Created by 梁海军 on 2017/2/22.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LMenuGridView.h"
#import "LMenuGridCell.h"
#import "GridViewBean.h"
@interface LMenuGridView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collection;

@end

static NSString *LMenuGridColumnCellIdentifier = @"LMenuGridColumnCellIdentifier";

#define LMenuGridColumnCellPadding 10*W_SCALE

#define LMenuGridColumnCellTopPadding 20*W_SCALE

#define LMenuGridColumnCellVPadding 10*W_SCALE

#define LMenuGridColumnCellHPadding 30*W_SCALE

#define LMenuGridCellSquareRect_SCALE 1.3

@implementation LMenuGridView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        self.collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        self.collection.delegate = self;
        self.collection.scrollEnabled = NO;
        self.collection.dataSource = self;
        self.collection.backgroundColor = [UIColor clearColor];
        self.collection.translatesAutoresizingMaskIntoConstraints=NO;
        [self.collection registerClass:[LMenuGridCell class] forCellWithReuseIdentifier:LMenuGridColumnCellIdentifier];
        [self addSubview:self.collection];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collection]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collection]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count]<=4?[self.dataArray count]:(section==0||[self.dataArray count]%4==0?4:[self.dataArray count]%4);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger s_count=[indexPath section];
    NSInteger  r_count=[indexPath row];
    NSInteger index= s_count*4+r_count;
    GridViewBean *grid = [self.dataArray objectAtIndex:index];
    LMenuGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LMenuGridColumnCellIdentifier forIndexPath:indexPath];
    [cell setupCellMenuGridView:grid.imageName title:grid.tagName];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.dataArray count]<=4?1:2;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger s_count=[indexPath section];
    NSInteger  r_count=[indexPath row];
    NSInteger index= s_count*4+r_count;
    GridViewBean *grid = [self.dataArray objectAtIndex:index];
    NSLog(@"选择的是%ld",(long)grid.index);
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = RGB(218, 219, 220, 1);
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ceilf((collectionView.frame.size.width-LMenuGridColumnCellPadding*3)/4),ceilf((collectionView.frame.size.height-LMenuGridColumnCellHPadding*3)/2));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(LMenuGridColumnCellTopPadding, 0, 0, 0);
}

-(void)reloadData{
    [self.collection reloadData];
}

@end
