//
//  SpringAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "SpringAnimationViewController.h"

@interface SpringAnimationViewController ()

@end

@implementation SpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"springAnimation" springingType:(DWAnimationSpringTypeScale) beginTime:2 fromValue:@0 toValue:@1 mass:1 stiffness:100 damping:10 initialVelocity:0];
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
