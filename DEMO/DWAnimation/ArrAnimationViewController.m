//
//  ArrAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "ArrAnimationViewController.h"

@interface ArrAnimationViewController ()



@end

@implementation ArrAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initAnimation {
    CABasicAnimation * aniP = [CABasicAnimation animationWithKeyPath:@"position"];
    aniP.toValue = [NSValue valueWithCGPoint:self.view.center];
    aniP.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 100)];
    aniP.duration = 0.4;
    aniP.beginTime = 1;
    
    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    ani.fromValue = (id)[UIColor redColor].CGColor;
    ani.toValue = (id)[UIColor blueColor].CGColor;
    ani.beginTime = 1;
    ani.duration = 2;
    ani.repeatCount = 3;
    ani.removedOnCompletion = NO;
    ani.fillMode = kCAFillModeForwards;
    
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arrAni" beginTime:1 duration:10 animations:@[ani,aniP]];
}



@end
