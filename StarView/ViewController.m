//
//  ViewController.m
//  StarView
//
//  Created by leoliu on 16/1/22.
//  Copyright © 2016年 leoliu. All rights reserved.
//

#import "ViewController.h"
#import "LEOStarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LEOStarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.starView.currentPercent = 0.4;
//    self.starView.markType = EMarkTypeDecimal;
    self.starView.currentIndex = 3;
    self.starView.markType = EMarkTypeInteger;
    self.starView.markComplete = ^(CGFloat score){
        self.scoreLabel.text = [NSString stringWithFormat:@"%.1f分",score];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
