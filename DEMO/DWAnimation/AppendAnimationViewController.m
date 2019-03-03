//
//  AddAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/3/3.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "AppendAnimationViewController.h"

@interface AppendAnimationViewController ()

@end

@implementation AppendAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initAnimation {
    DWAnimation * ani1 = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"rotateAnimation" animationCreater:^(DWAnimationMaker *maker) {
        maker.rotateTo(360).duration(2).install();
    }];
    
    DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"bgColor" animationCreater:^(DWAnimationMaker *maker) {
        maker.backgroundColorTo([UIColor blueColor]).duration(2).install();
    }];
    self.ani = [ani1 appendAnimation:ani2 animationKey:nil];
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
