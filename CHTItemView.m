//
//  CHTItemView.m
//  CHTGithub
//
//  Created by cht on 16/7/22.
//  Copyright © 2016年 cht. All rights reserved.
//

#import "CHTItemView.h"

static NSInteger const kDefaultNumberOfItemPerCount = 4;
static NSInteger const kStartTag                    = 100;
static NSInteger const kItemHeight                  = 92;

@interface CHTItemView ()



@end


@implementation CHTItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialization];
    }
    return self;
}

- (void)initialization{
    
    _numberOfItemPerRow = kDefaultNumberOfItemPerCount;
}

- (void)setTitles:(NSArray *)titles icons:(NSArray *)icons{
    
    _titles = titles;
    _icons  = icons;
    
    [self layoutUI];
}

- (void)layoutUI{
    
    //remove subviews of self
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat bgViewH = kItemHeight;
    CGFloat bgViewW = CGRectGetWidth(self.frame) / _numberOfItemPerRow;
    
    CGFloat labelH = 12;

    NSInteger rowCount = _icons.count / _numberOfItemPerRow + 1;
    
    for (NSInteger i = 0; i < rowCount; i ++) {
        
        for (NSInteger j = 0; j < _numberOfItemPerRow; j ++) {
            
            NSInteger number = i * _numberOfItemPerRow + j;
            
            if (number >= _icons.count) {
                break;
            }
            
            UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(bgViewW * j, bgViewH * i, bgViewW, bgViewH)];
            bgView.tag = number + kStartTag;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
            [bgView addGestureRecognizer:tap];
            
            [self addSubview:bgView];
            
            UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgView.frame), CGRectGetHeight(bgView.frame) - labelH)];
            icon.contentMode = UIViewContentModeCenter;
            icon.image = _icons[number];
            [bgView addSubview:icon];
            
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), CGRectGetWidth(bgView.frame), labelH)];
            title.font = [UIFont systemFontOfSize:12.0f];
            title.textAlignment = NSTextAlignmentCenter;
            title.text = _titles[number];
            [bgView addSubview:title];

        }
    }
}

- (void)tapEvent:(UITapGestureRecognizer *)tap{
    
    if (_delegate && [_delegate respondsToSelector:@selector(itemView:didSelectItemAtIndex:)]) {
        
        [_delegate itemView:self didSelectItemAtIndex:tap.view.tag - kStartTag];
    }
}

#pragma mark - Setters
- (void)setNumberOfItemPerRow:(NSInteger)numberOfItemPerRow{
    
    if (_numberOfItemPerRow == numberOfItemPerRow) {
        return;
    }
    _numberOfItemPerRow = numberOfItemPerRow;
    [self layoutUI];
}

@end
