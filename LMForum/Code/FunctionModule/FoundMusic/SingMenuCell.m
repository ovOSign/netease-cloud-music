//
//  SingMenuCell.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/25.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "SingMenuCell.h"
#import "SingCollectionViewCell.h"
#import "SingMenuBean.h"
@interface SingMenuCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collection;

@end

#define SingMenuCellPadding 8*W_SCALE

#define SingMenuCellButtomPadding 10*W_SCALE

#define SingMenuCellSquareRect_SCALE 1.3

static NSString *SingMenuCellIdentifier = @"SingMenuCellIdentifier";


@implementation SingMenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 0.0f;
        layout.minimumLineSpacing = SingMenuCellPadding;
        self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collection.delegate = self;
        self.collection.scrollEnabled = NO;
        self.collection.dataSource = self;
        self.collection.backgroundColor = [UIColor clearColor];
        self.collection.translatesAutoresizingMaskIntoConstraints=NO;
        [self.collection registerClass:[SingCollectionViewCell class] forCellWithReuseIdentifier:SingMenuCellIdentifier];
        [self addSubview:self.collection];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[_collection]-margin-|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"margin":@(cellMargin)}
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-margin-[_collection]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:@{@"margin":@(cellIndicatorTopMargin)}
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SingMenuCellIdentifier forIndexPath:indexPath];
    [cell setupCellSingView];
    NSInteger  index=[indexPath row];
    SingMenuBean *bean = [self.dataArray objectAtIndex:index];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:bean.imgUrl]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
    [cell.describeLabel setText:bean.describe];
    [cell.rightTopLabel setText:bean.listenNum];
    [cell.personLabel setText:bean.person];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ceilf((collectionView.frame.size.width-SingMenuCellPadding)/2),ceilf((collectionView.frame.size.width-SingMenuCellPadding)/2)*SingMenuCellSquareRect_SCALE);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)reloadData{
    [self.collection reloadData];
}

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self reloadData];
}

+ (CGFloat)cellHeight{
    return ceilf(((S_WIDTH-2*cellMargin-SingMenuCellPadding)/2)*SingMenuCellSquareRect_SCALE+cellIndicatorTopMargin);
}

@end
