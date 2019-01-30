//
//  TimeIntervalAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "TimeIntervalAnimationViewController.h"

@interface TimeIntervalAnimationViewController ()

@end

@implementation TimeIntervalAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationType:(DWAnimationTypeBackgroundColor) animationKey:@"timeIntervalAnimation" beginTime:1 values:@[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor redColor]] timeIntervals:@[@1,@2,@3,@1] transition:NO];
}


@end
