//
//  ManagerMultiAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/3/6.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "ManagerMultiAnimationViewController.h"
#import <DWAnimationManager.h>
#import <DWAnimationGroup.h>

@interface ManagerMultiAnimationViewController ()

@property (nonatomic ,strong) UIView * blueView;

@property (nonatomic ,strong) UIView * greenView;

@end

@implementation ManagerMultiAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redView.center = CGPointMake(self.view.center.x - 100, self.view.center.y);
    self.greenView.center = self.view.center;
    self.blueView.center = CGPointMake(self.view.center.x + 100, self.view.center.y);
    [self.view addSubview:self.blueView];
    [self.view addSubview:self.greenView];
}

-(void)configTouchAction {
    __weak typeof(self)weakSelf = self;
    self.touchAction = ^{
        DWAnimation * redAni = [[DWAnimation alloc] initAnimationWithContent:weakSelf.redView animationKey:@"red" animationCreater:^(DWAnimationMaker *maker) {
            maker.scaleTo(2).duration(2).install();
        }];
        
        
        
        DWAnimation * greenAni = [[DWAnimation alloc] initAnimationWithContent:weakSelf.greenView animationKey:@"green" animationCreater:^(DWAnimationMaker *maker) {
            maker.backgroundColorTo([UIColor yellowColor]).duration(1).install();
        }];
        
        DWAnimation * blueAni = [[DWAnimation alloc] initAnimationWithContent:weakSelf.blueView animationKey:@"blue" beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:90 rotateAxis:X deep:300];
        
        DWAnimationGroup * group = [[DWAnimationGroup alloc] initWithAnimations:@[greenAni,blueAni]];
        group.beginTime = 2;
        [DWAnimationManager startAnimations:@[redAni,group] playMode:(DWAnimationPlayModeMulti)];
    };
}

-(UIView *)greenView {
    if (!_greenView) {
        _greenView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
        _greenView.backgroundColor = [UIColor greenColor];
    }
    return _greenView;
}

-(UIView *)blueView {
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
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
