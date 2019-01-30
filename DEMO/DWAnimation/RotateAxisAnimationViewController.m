//
//  RotateAxisAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/30.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "RotateAxisAnimationViewController.h"

@interface RotateAxisAnimationViewController ()

@end

@implementation RotateAxisAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"axisAnimation" beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:-180 rotateAxis:X deep:300];
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
