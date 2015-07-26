//
//  UIView+autoLayoutView.h
//  AutoLayoutAndSIzeClass
//
//  Created by Horson Wu on 15/7/11.
//  Copyright (c) 2015年 Horson Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
@interface UIView (autoLayoutView)
//水平等间距排列
- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
//垂直等间距排列
- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end
