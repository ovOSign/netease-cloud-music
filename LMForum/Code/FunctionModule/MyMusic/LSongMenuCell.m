//
//  LSongMenuCell.m
//  LMForum
//
//  Created by 梁海军 on 2017/3/24.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "LSongMenuCell.h"

@implementation LSongMenuCell

-(void)setModel:(MyMusicColumMenuModel *)model{
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"cm2_default_recmd_list"]];
    if (!model.person ) {
        self.personName.hidden = YES;
    }else{
        self.personName.text = model.person;
    }
    
    self.numText.text = model.num;
    
    self.itemName.text = model.itemName;
    
}
@end
