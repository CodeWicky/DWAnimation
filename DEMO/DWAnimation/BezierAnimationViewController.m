//
//  BezierViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "BezierAnimationViewController.h"

@interface BezierAnimationViewController ()

@end

@implementation BezierAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initAnimation {
    self.redView.center = self.view.center;
    UIBezierPath * bp = [UIBezierPath bezierPath];
    [bp moveToPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)];
    [bp addArcWithCenter:CGPointMake(self.view.center.x - 50, self.view.center.y) radius:50 startAngle:-M_PI endAngle:0 clockwise:YES];
    [bp addArcWithCenter:CGPointMake(self.view.center.x + 50, self.view.center.y) radius:50 startAngle:M_PI endAngle:0 clockwise:NO];
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"bezierAnimation" beginTime:0 duration:5 bezierPath:bp autoRotate:YES];
    self.ani.repeatCount = 2;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
