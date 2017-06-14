//
//  RecommondColumnView.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/19.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "RecommondColumnView.h"
#import "FindCollectionViewCell+topic.h"
#import "FindCollectionViewCell+music.h"
#import "FindCollectionViewCell+video.h"
#import "FindCollectionViewCell+radio.h"
@interface RecommondColumnView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collection;

@end

static NSString *RecommondColumnCellIdentifier = @"RecommondColumnCellIdentifier";


#define RecColumnCellPadding 8*W_SCALE

#define RecColumnCellButtomPadding 10*W_SCALE

#define RecColumnCelSquareRect_SCALE 1.4

#define RecColumnCelRectangleRect_SSCALE 0.8

#define RecColumnCelRectangleRect_LSCALE 0.55

#define RecColumnCelRectangleRect_MSCALE 0.9
@implementation RecommondColumnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumInteritemSpacing = 0.0f;
        layout.minimumLineSpacing = RecColumnCellButtomPadding;
        self.collection = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        self.collection.delegate = self;
        self.collection.scrollEnabled = NO;
        self.collection.dataSource = self;
        self.collection.backgroundColor = [UIColor clearColor];
        self.collection.translatesAutoresizingMaskIntoConstraints=NO;
        [self.collection registerClass:[FindCollectionViewCell class] forCellWithReuseIdentifier:RecommondColumnCellIdentifier];
        [self addSubview:self.collection];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collection]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collection]|"
                                                                     options:NSLayoutFormatDirectionLeadingToTrailing
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_collection)]];
        
        self.type = RecommendColumnCellTypeRecommend;

    }
    return self;
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.type) {
        case RecommendColumnCellTypeRecommend:
            return 6;
            break;
        case RecommendColumnCellTypeNewest:
            return 6;
            break;
        case RecommendColumnCellTypeRadio:
            return 6;
            break;
        case RecommendColumnCellTypeExclusive:
            return 3;
            break;
        case RecommendColumnCellTypeMv:
            return 6;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecommondColumnCellIdentifier forIndexPath:indexPath];
    switch (self.type) {
        case RecommendColumnCellTypeRecommend:{
            [cell setupCellMusicView];
            if([indexPath row] ==0 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4b79c8ac3571ea9675bbb613d3325beb_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"可爱的笑容"];
                [cell.rightTopLabel setText:@"17万"];
            }
            if([indexPath row] ==1 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/others/frontPageRec/161219/0/-M-f83414f548534448281d8b453d85a403_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"Billboard 2016年度单曲榜《上集》"];
            }
            if([indexPath row] ==2 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.c.yinyuetai.com/others/frontPageRec/161214/0/-M-6a767298ca5ef25d1109bae1d40967e9_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"BiHeartRadio Jingle Ball 2016"];
            }
            if([indexPath row] ==3 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"VEVO 2016年全球最热25支mv年榜"];
            }
            if([indexPath row] ==4 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161213/0/-M-cc41300165c0162ae48aa878bbe3d04a_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"那些由童话故事改编的真人版电影"];
            }
            if([indexPath row] ==5 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.c.yinyuetai.com/others/frontPageRec/161201/0/-M-ff7222eaf4d8236bb9df0522980b6ee7_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"《时代》杂志评选出2016年十大最烂歌曲"];
            }
            
            return cell;
        }
            
            break;
        case RecommendColumnCellTypeNewest:{
            [cell setupCellMusicViewWithSinger];
            if([indexPath row] ==0 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/others/frontPageRec/161216/0/-M-9e755d58bd09643391daf95d9477a3fe_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"可爱的笑容"];
                [cell.singerLabel setText:@"群星"];
 
            }
            if([indexPath row] ==1 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161220/0/-M-70596dea0294cb35ba05cdf598ffcdaf_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"Billboard 2016年度单曲榜《上集》"];
                [cell.singerLabel setText:@"周杰伦"];
            }
            if([indexPath row] ==2 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img4.c.yinyuetai.com/others/frontPageRec/161215/0/-M-6616c8f067ff244b898b13ff95683a02_0x0.png"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"BiHeartRadio Jingle Ball 2016"];
                [cell.singerLabel setText:@"王力宏"];
            }
            if([indexPath row] ==3 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img3.c.yinyuetai.com/others/frontPageRec/161219/0/-M-efb21b76df13e3ea0a62803749d4b1a9_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"VEVO 2016年全球最热25支mv年榜"];
                [cell.singerLabel setText:@"许嵩"];
            }
            if([indexPath row] ==4 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161217/0/-M-2c89e60300f806e6fcb9260d8b1ba1b3_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"那些由童话故事改编的真人版电影"];
                [cell.singerLabel setText:@"林宥嘉"];
            }
            if([indexPath row] ==5 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img4.c.yinyuetai.com/others/frontPageRec/161215/0/-M-6a73bab9f7fd151c7805aa039894dece_0x0.png"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"《时代》杂志评选出2016年十大最烂歌曲"];
                [cell.singerLabel setText:@"五月天"];
            }
            return cell;
        }
            
            break;
        case RecommendColumnCellTypeRadio:{
            [cell setupCellRadioView];
            if([indexPath row] ==0 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/video/mv/160415/2545205/-M-43fe8506addd421c27508f51aa801659_240x135.jpg?t=20160415184510"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"可爱的笑容"];
                [cell.radioNameLabel setText:@"2016年度单曲榜《上集》"];
            }
            if([indexPath row] ==1 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img4.yytcdn.com/video/mv/160405/2539032/-M-5a58dc1ef4bf6b2de86114b162e7b235_240x135.jpg?t=20160405150511"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"Billboard 2016年度单曲榜《上集》"];
                [cell.radioNameLabel setText:@"VEVO "];
            }
            if([indexPath row] ==2 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"https://img3.c.yinyuetai.com/video/playlist/160331/0/-M-5f0f0c7d6f9da25156ffcda15251786c_110x110.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"BiHeartRadio Jingle Ball 2016"];
                [cell.radioNameLabel setText:@"笑容 "];
            }
            if([indexPath row] ==3 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.yytcdn.com/video/mv/160130/0/-M-2503e801545f7e8f8d1be1c18516f39d_240x135.jpg?t=20130126213245"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"VEVO 2016年全球最热25支mv年榜"];
                [cell.radioNameLabel setText:@"故事改编的真人版电影"];
            }
            if([indexPath row] ==4 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/video/mv/161217/2752370/-M-a70140f9f8b58870a331effba0ebd457_240x135.jpg?t=20161217181502"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"那些由童话故事改编的真人版电影"];
                [cell.radioNameLabel setText:@"十大最烂歌曲"];
            }
            if([indexPath row] ==5 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/video/mv/161028/2711923/-M-1a023d4657931eb7729f87d5dd50df47_240x135.jpg?t=20161123141503"]];
                [cell.describeLabel setText:@"《时代》杂志评选出2016年十大最烂歌曲"];
                [cell.radioNameLabel setText:@"Billboard"];
            }
            
            return cell;
        }
            
            break;
        case RecommendColumnCellTypeExclusive:{
            if([indexPath row] ==0 ){
                [cell setupCellTopicView];
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161215/0/-M-b6efbd690e4f9cd9d5f01f5e6e4a9fc9_0x0.png"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"可爱的笑容,优美的身材,才华横溢和动听的琴声"];
                [cell.rightTopLabel setText:@"17万"];
            }
            if([indexPath row] ==1 ){
                [cell setupCellTopicView];
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161219/0/-M-6c48d5d61e4b86bace011f16e6d36d6b_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"Billboard 2016年度单曲榜《上集》"];
            }
            if([indexPath row] ==2 ){
                [cell setupCellVideoView];
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161216/0/-M-4aff003a0ee89dbc5026b49d2f28bcc7_0x0.jpg"]placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
                [cell.describeLabel setText:@"BiHeartRadio Jingle Ball 2016"];
            }
            return cell;
        }
            
            break;
        case RecommendColumnCellTypeMv:{
            [cell setupCellVideoViewWithSinger];
            if([indexPath row] ==0 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.c.yinyuetai.com/others/frontPageRec/161215/0/-M-fc61cc5892788edd9145701fbae68b02_0x0.png"]];
                [cell.describeLabel setText:@"可爱的笑容"];
                [cell.singerLabel setText:@"群星"];
                
            }
            if([indexPath row] ==1 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.c.yinyuetai.com/others/frontPageRec/161124/0/-M-98fb8da65d148cf46d905d24b2fbf761_0x0.jpg"]];
                [cell.describeLabel setText:@"Billboard 2016年度单曲榜《上集》"];
                [cell.singerLabel setText:@"周杰伦"];
            }
            if([indexPath row] ==2 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.c.yinyuetai.com/others/frontPageRec/161123/0/-M-35e601bf7c5f526bb8e8624c964435e5_0x0.jpg"]];
                [cell.describeLabel setText:@"BiHeartRadio Jingle Ball 2016"];
                [cell.singerLabel setText:@"王力宏"];
            }
            if([indexPath row] ==3 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161209/0/-M-5ffbd58700fd2f894783d9a37f4c2215_0x0.jpg"]];
                [cell.describeLabel setText:@"VEVO 2016年全球最热25支mv年榜"];
                [cell.singerLabel setText:@"许嵩"];
            }
            if([indexPath row] ==4 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img1.c.yinyuetai.com/others/frontPageRec/161213/0/-M-cc41300165c0162ae48aa878bbe3d04a_0x0.jpg"]];
                [cell.describeLabel setText:@"那些由童话故事改编的真人版电影"];
                [cell.singerLabel setText:@"林宥嘉"];
            }
            if([indexPath row] ==5 ){
                [cell.imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img0.c.yinyuetai.com/others/frontPageRec/161201/0/-M-ff7222eaf4d8236bb9df0522980b6ee7_0x0.jpg"]];
                [cell.describeLabel setText:@"《时代》杂志评选出2016年十大最烂歌曲"];
                [cell.singerLabel setText:@"五月天"];
            }
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.type) {
        case RecommendColumnCellTypeRecommend:
               return CGSizeMake(ceilf((self.frame.size.width-2*RecColumnCellPadding)/3),ceilf((self.frame.size.width-2*RecColumnCellPadding)/3)*RecColumnCelSquareRect_SCALE);
            break;
        case RecommendColumnCellTypeNewest:
            return CGSizeMake(ceilf((self.frame.size.width-2*RecColumnCellPadding)/3),ceilf((self.frame.size.width-2*RecColumnCellPadding)/3)*RecColumnCelSquareRect_SCALE);
            break;
        case RecommendColumnCellTypeRadio:
            return CGSizeMake(ceilf((self.frame.size.width-2*RecColumnCellPadding)/3),ceilf((self.frame.size.width-2*RecColumnCellPadding)/3)*RecColumnCelSquareRect_SCALE);
            break;
        case RecommendColumnCellTypeExclusive:{
            if([indexPath row] ==0 ){
              return CGSizeMake(ceilf((self.frame.size.width-RecColumnCellPadding)/2),ceilf((self.frame.size.width-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_SSCALE);
            }
            if([indexPath row] ==1 ){
              return CGSizeMake(ceilf((self.frame.size.width-RecColumnCellPadding)/2),ceilf((self.frame.size.width-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_SSCALE);
            }
            if([indexPath row] ==2 ){
              return CGSizeMake(ceilf(self.frame.size.width),ceilf(self.frame.size.width)*RecColumnCelRectangleRect_LSCALE);
            }
            
        }
            break;
        case RecommendColumnCellTypeMv:
            return CGSizeMake(ceilf((self.frame.size.width-RecColumnCellPadding)/2),ceilf((self.frame.size.width-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_MSCALE);
            break;
            
        default:
            break;
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

+ (CGFloat)viewHeight:(RecommendColumnCellType)type{
    switch (type) {
        case RecommendColumnCellTypeRecommend:
            return ceilf(2*(((S_WIDTH-2*(RecColumnCellPadding+cellMargin))/3)*RecColumnCelSquareRect_SCALE+2*RecColumnCellButtomPadding));
            break;
        case RecommendColumnCellTypeNewest:
            return ceilf(((ceilf((S_WIDTH-2*(RecColumnCellPadding)-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_SSCALE+RecColumnCellButtomPadding))+ceilf((S_WIDTH-2*(RecColumnCellPadding))*RecColumnCelRectangleRect_LSCALE));
            break;
        case RecommendColumnCellTypeRadio:
            return ceilf(2*(((S_WIDTH-2*(RecColumnCellPadding+cellMargin))/3)*RecColumnCelSquareRect_SCALE+2*RecColumnCellButtomPadding));
            break;
        case RecommendColumnCellTypeExclusive:
            return ceilf(((ceilf((S_WIDTH-2*(RecColumnCellPadding)-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_SSCALE+RecColumnCellButtomPadding))+ceilf((S_WIDTH-2*(RecColumnCellPadding))*RecColumnCelRectangleRect_LSCALE));
            break;
        case RecommendColumnCellTypeMv:
            return ceilf(2*(((S_WIDTH-2*(RecColumnCellPadding)-RecColumnCellPadding)/2)*RecColumnCelRectangleRect_MSCALE)+2*RecColumnCellButtomPadding);
            break;
            
        default:
            break;
    }
    return 0;
}

@end
