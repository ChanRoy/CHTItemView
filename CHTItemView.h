//
//  CHTItemView.h
//  CHTGithub
//
//  Created by cht on 16/7/22.
//  Copyright © 2016年 cht. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTItemView;

@protocol CHTItemViewDelegate <NSObject>

@optional
- (void)itemView:(CHTItemView *)itemView didSelectItemAtIndex:(NSInteger)index;

@end

@interface CHTItemView : UIView

@property (nonatomic, strong) NSArray *icons;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) NSInteger numberOfItemPerRow;

@property (nonatomic, assign) id<CHTItemViewDelegate> delegate;

- (void)setTitles:(NSArray *)titles icons:(NSArray *)icons;

@end
