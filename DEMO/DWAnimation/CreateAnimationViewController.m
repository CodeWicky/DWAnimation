//
//  CreateAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/3/3.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "CreateAnimationViewController.h"

@interface CreateAnimationViewController ()

@end

@implementation CreateAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initAnimation {
    DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateTo(360).duration(2).install();
    }];
    
    DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColorAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
    }];
    
    DWAnimation * ani3 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"moveAniamtion" animationCreater:^(DWAnimationMaker *maker) {
        maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y - 100)).duration(2).install();
    }];
    
    self.ani = [DWAnimation createAnimationWithAnimations:@[ani1,ani2,ani3] animationKey:@"createAnimation"];
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
