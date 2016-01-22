//
//  LEOStarView.m
//  StarView
//
//  Created by leoliu on 16/1/22.
//  Copyright © 2016年 leoliu. All rights reserved.
//

#import "LEOStarView.h"

static CGFloat kTotalScore = 10.;
static NSUInteger kDefaultCount = 5;
static CGFloat kStarWidth = 0.0;

@implementation LEOStarView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundColor = [UIColor clearColor];
    kStarWidth = rect.size.width / self.starCount;
    for (int i = 0; i < self.starCount; i++) {
        CGRect starRect = CGRectMake(i * kStarWidth, 0, kStarWidth, rect.size.height);
        [self.starImage drawInRect:starRect];
    }
    
    [self.starBackgroundColor set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    CGRect newRect = CGRectZero;
    if (self.markType == EMarkTypeInteger) {
        newRect = CGRectMake(0, 0, self.currentIndex * kStarWidth, rect.size.height);
    } else {
        newRect = CGRectMake(0, 0, self.currentPercent * rect.size.width, rect.size.height);
    }
    [self.starFrontColor set];
    UIRectFillUsingBlendMode(newRect, kCGBlendModeSourceIn);
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == EMarkTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / kStarWidth);
        } else {
            self.currentIndex = ceilf(xPoint / kStarWidth);
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat xPoint = [[touches anyObject] locationInView:self].x;
    if (self.markType == EMarkTypeInteger) {
        if(self.currentIndex == 1) {
            self.currentIndex = roundf(xPoint / kStarWidth);
        } else {
            self.currentIndex = ceilf(xPoint / kStarWidth);
        }
    } else {
        self.currentPercent = xPoint / self.bounds.size.width;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.markComplete) {
        if (self.markType == EMarkTypeInteger) {
            if (self.currentIndex > self.starCount) {
                self.currentIndex = self.starCount;
            }
            self.currentIndex = self.currentIndex > self.starCount ? self.starCount : self.currentIndex;
            self.markComplete(self.currentIndex * self.totalScore / self.starCount);
        } else {
            self.currentPercent = self.currentPercent > 1. ? 1. : self.currentPercent;
            self.currentPercent = self.currentPercent < 0. ? 0. : self.currentPercent;
            self.markComplete(self.currentPercent * self.totalScore);
        }
    }
    [self setNeedsDisplay];
}

#pragma mark - lazy

- (NSUInteger)starCount
{
    if (_starCount <= 0) {
        _starCount = kDefaultCount;
    }
    return _starCount;
}

- (CGFloat)totalScore
{
    if (_totalScore <= 0.001) {
        _totalScore = kTotalScore;
    }
    return _totalScore;
}

- (UIImage *)starImage
{
    if(!_starImage)
    {
        _starImage = [UIImage imageNamed:@"star"];
    }
    return _starImage;
}

- (UIColor *)starBackgroundColor
{
    if(!_starBackgroundColor)
    {
        _starBackgroundColor = [UIColor whiteColor];
    }
    return _starBackgroundColor;
}

- (UIColor *)starFrontColor
{
    if(!_starFrontColor)
    {
        _starFrontColor = [UIColor orangeColor];
    }
    return _starFrontColor;
}


@end
