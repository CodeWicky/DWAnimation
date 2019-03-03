//
//  CombineAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/3/3.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "CombineAnimationViewController.h"

@interface CombineAnimationViewController ()

@end

@implementation CombineAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)initAnimation {
    DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateTo(360).duration(2).install();
    }];
    
    DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColor" animationCreater:^(DWAnimationMaker *maker) {
        maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
    }];
    self.ani = [ani1 combineWithAnimation:ani2 animationKey:nil];
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
