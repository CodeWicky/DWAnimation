//
//  KeyPathAnimationViewController.m
//  DWAnimation
//
//  Created by Wicky on 2019/1/30.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import "KeyPathAnimationViewController.h"

@interface KeyPathAnimationViewController ()

@property (nonatomic ,strong) CAShapeLayer * shape;

@property (nonatomic ,strong) UIBezierPath * fP;

@property (nonatomic ,strong) UIBezierPath * tP;

@end

@implementation KeyPathAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.redView removeFromSuperview];
    [self.view.layer addSublayer:self.shape];
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.shape keyPath:@"path" animationKey:@"keyPathAnimation" beginTime:2 duration:2 fromValue:(__bridge id)self.fP.CGPath toValue:(__bridge id)self.tP.CGPath timingFunctionName:nil];
}

-(CAShapeLayer *)shape {
    if (!_shape) {
        _shape = [CAShapeLayer layer];
        _shape.bounds = CGRectMake(0, 0, 200, 200);
        _shape.position = self.view.center;
        _shape.borderColor = [UIColor redColor].CGColor;
        _shape.fillColor = [UIColor redColor].CGColor;
        _shape.path = self.fP.CGPath;
    }
    return _shape;
}

-(UIBezierPath *)fP {
    if (!_fP) {
        _fP = [UIBezierPath bezierPath];
        [_fP moveToPoint:CGPointMake(100, 0)];
        [_fP addLineToPoint:CGPointMake(200, 0)];
        [_fP addLineToPoint:CGPointMake(200, 50)];
        [_fP addLineToPoint:CGPointMake(200, 100)];
        [_fP addLineToPoint:CGPointMake(200, 150)];
        [_fP addLineToPoint:CGPointMake(200, 200)];
        [_fP addLineToPoint:CGPointMake(100, 200)];
        [_fP addLineToPoint:CGPointMake(0, 200)];
        [_fP addLineToPoint:CGPointMake(0, 150)];
        [_fP addLineToPoint:CGPointMake(0, 100)];
        [_fP addLineToPoint:CGPointMake(0, 50)];
        [_fP addLineToPoint:CGPointMake(0, 0)];
        [_fP closePath];
    }
    return _fP;
}

-(UIBezierPath *)tP {
    if (!_tP) {
        _tP = [UIBezierPath bezierPath];
        [_tP moveToPoint:CGPointMake(100, 0)];
        [_tP addLineToPoint:CGPointMake(128.868, 50)];
        [_tP addLineToPoint:CGPointMake(186.604, 50)];
        [_tP addLineToPoint:CGPointMake(157.736, 100)];
        [_tP addLineToPoint:CGPointMake(186.604, 150)];
        [_tP addLineToPoint:CGPointMake(128.868, 150)];
        [_tP addLineToPoint:CGPointMake(100, 200)];
        [_tP addLineToPoint:CGPointMake(71.132, 150)];
        [_tP addLineToPoint:CGPointMake(13.396, 150)];
        [_tP addLineToPoint:CGPointMake(42.264, 100)];
        [_tP addLineToPoint:CGPointMake(13.396, 50)];
        [_tP addLineToPoint:CGPointMake(71.132, 50)];
        [_tP closePath];
    }
    return _tP;
}

@end
