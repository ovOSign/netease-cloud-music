//
//  KITextView.m
//  LMForum
//
//  Created by 梁海军 on 2017/4/2.
//  Copyright © 2017年 lhj. All rights reserved.
//

#import "KITextView.h"

NSString * const TextViewRangeKey = @"range";
NSString * const TextViewLinkKey = @"link";

@implementation KITextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditing:) name:UITextViewTextDidChangeNotification object:self];
        
        
    }
    
    return self;
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    
    
    [self updateTextStoreWithAttributedString:attributedText];
}

- (void)updateTextStoreWithAttributedString:(NSAttributedString *)attributedString
{
    
    
    self.linkRanges = [self getRangesForLinks:attributedString];
    
    attributedString = [self addLinkAttributesToAttributedString:attributedString linkRanges:self.linkRanges];
    
    [super setAttributedText:attributedString];
}

- (NSAttributedString *)addLinkAttributesToAttributedString:(NSAttributedString *)string linkRanges:(NSArray *)linkRanges
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:string];
    
    for (NSDictionary *dictionary in linkRanges)
    {
        NSRange range = [[dictionary objectForKey:TextViewRangeKey] rangeValue];
        
        
        [attributedString addAttribute:NSLinkAttributeName value:dictionary[TextViewLinkKey] range:range];
        
    }
    
    
    
    return attributedString;
}


- (NSArray *)getRangesForLinks:(NSAttributedString *)text
{
    NSMutableArray *rangesForLinks = [[NSMutableArray alloc] init];
    
    [rangesForLinks addObjectsFromArray:[self getRangesForUserHandles:text.string]];
    
    [rangesForLinks addObjectsFromArray:[self getRangesForHashtags:text.string]];
    
    return rangesForLinks;
}


- (NSArray *)getRangesForUserHandles:(NSString *)text
{
    NSMutableArray *rangesForUserHandles = [[NSMutableArray alloc] init];
    
    // Setup a regular expression for user handles and hashtags
    static NSRegularExpression *regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        regex = [[NSRegularExpression alloc] initWithPattern:@"(?<!\\w)@([\\w\\_]+)?" options:0 error:&error];
    });
    
    
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        
        [rangesForUserHandles addObject:@{
                                          TextViewRangeKey : [NSValue valueWithRange:matchRange],
                                          TextViewLinkKey : matchString
                                          }];
        
    }
    
    
    return rangesForUserHandles;
}


- (NSArray *)getRangesForHashtags:(NSString *)text
{
    NSMutableArray *rangesForHashtags = [[NSMutableArray alloc] init];
    
    static NSRegularExpression *regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        regex = [[NSRegularExpression alloc] initWithPattern:@"#[^@#]+?#" options:0 error:&error];
    });
    
    NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
    
    for (NSTextCheckingResult *match in matches)
    {
        NSRange matchRange = [match range];
        NSString *matchString = [text substringWithRange:matchRange];
        
        [rangesForHashtags addObject:@{
                                       TextViewRangeKey : [NSValue valueWithRange:matchRange],
                                       TextViewLinkKey : matchString
                                       }];
    }
    
    return rangesForHashtags;
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

#pragma mark - notification

- (void)startEditing:(NSNotification *)notification
{
    NSRange brange=self.selectedRange;
    if (self.markedTextRange == nil) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle
                              ,NSForegroundColorAttributeName:RGB(31,31,31,1)};
        
        NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:self.text attributes:dic];
        [self updateTextStoreWithAttributedString:attributeText];
        
    }
    self.selectedRange=brange;

}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint previous=[touch previousLocationInView:self];
    CGPoint location = [touch locationInView:self];
    if (self.contentSize.height < self.bounds.size.height && fabs((location.x-previous.x)/(location.y-previous.y))<1) {
        [self endEditing:YES];
    }
}

@end
