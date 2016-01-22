//
//  LEOStarView.h
//  StarView
//
//  Created by leoliu on 16/1/22.
//  Copyright © 2016年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  打分方式
 */
typedef NS_ENUM(NSUInteger, EMarkType) {
    EMarkTypeInteger,   //整数
    EMarkTypeDecimal,   //小数
};

@interface LEOStarView : UIView

@property (nonatomic, assign) NSUInteger starCount;         //星星数量（默认5）

@property (nonatomic, assign) CGFloat totalScore;           //总分数（默认10）

@property (nonatomic, strong) UIImage *starImage;           //星星图片

@property (nonatomic, strong) UIColor *starFrontColor;      //打分后的颜色（默认orangeColor）

@property (nonatomic, strong) UIColor *starBackgroundColor; //星星背景颜色（默认whiteColor）

@property (nonatomic, assign) NSUInteger currentIndex;      //当前星星位置(在EMarkTypeInteger模式下使用）范围[1 - starCount]

@property (nonatomic, assign) CGFloat currentPercent;       //在EMarkTypeDecimal模式下使用范围[0.-1.]

@property (nonatomic, assign) EMarkType markType;           //打分类型

@property (nonatomic, copy) void(^markComplete)(CGFloat score); //回传打分结果

@end
