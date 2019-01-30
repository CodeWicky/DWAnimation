//
//  ArcAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "ArcAnimationViewController.h"

@interface ArcAnimationViewController ()

@end

@implementation ArcAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arcAnimation" beginTime:2 duration:1 arcCenter:CGPointMake(self.view.center.x, self.view.center.y - 100) radius:200 startAngle:120 endAngle:60 clockwise:NO autoRotate:YES];
}

@end
