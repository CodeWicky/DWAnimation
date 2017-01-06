//
//  ViewController.m
//  DWAnimation
//
//  Created by Wicky on 16/9/6.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "ViewController.h"
#import "DWAnimationHeader.h"
@interface ViewController ()

@property (nonatomic ,strong) NSArray * arr;

@property (nonatomic ,strong) DWAnimation * a;

@property (nonatomic ,strong) DWAnimationGroup * g;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [button setFrame:CGRectMake(100, 100, 60, 30)];
    [button setTitle:@"点我啊" forState:(UIControlStateNormal)];
    [button setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(bu) forControlEvents:(UIControlEventTouchUpInside)];
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    redView.center = CGPointMake(self.view.center.x + 50, self.view.center.y);
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finish:) name:DWAnimationPlayFinishNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start:) name:DWAnimationPlayStartNotification object:nil];
//    
//    DWAnimation * springAnimation1 = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"springAnimationMove" springingType:(DWAnimationSpringTypeMove) beginTime:0 fromValue:[NSValue valueWithCGPoint:CGPointMake(redView.center.x, - redView.frame.size.height * 0.5)] toValue:[NSValue valueWithCGPoint:self.view.center] mass:1 stiffness:100 damping:10 initialVelocity:0];
//    springAnimation1.repeatCount = 2;
//    //    springAnimation1.beginTime = 2;
//    //        [springAnimation1 start];
//    DWAnimation * springAnimation2 = [redView dw_CreateAnimationWithAnimationKey:@"springAnimationScale" springingType:(DWAnimationSpringTypeScale) beginTime:0 fromValue:@0 toValue:@1 mass:2 stiffness:100 damping:10 initialVelocity:0];
//    //
//    DWAnimation * springAnimation = [springAnimation1 combineWithAnimation:springAnimation2 animationKey:nil];
//    //
//    DWAnimation * moveAnimation = [redView dw_CreateAnimationWithKey:@"moveAnimation" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(CGPointMake(self.view.center.x, self.view.center.y + 100)).duration(2).install();
//    }];
//    //    [moveAnimation start];
//    DWAnimation * arcAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"arcAnimation" beginTime:0 duration:1 arcCenter:CGPointMake(self.view.center.x, self.view.center.y - 300) radius:400 startAngle:180 endAngle:200 clockwise:YES autoRotate:YES];
//    arcAnimation.repeatCount = 2;
//    //
//    DWAnimation * bezierAnimation = [redView dw_CreateAnimationWithAnimationKey:@"bezierAnimation" beginTime:0 duration:2 bezierPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y - 300) radius:400 startAngle:RadianFromDegree(110) endAngle:RadianFromDegree(70) clockwise:NO] autoRotate:NO];
//    bezierAnimation.repeatCount = 2;
//    DWAnimation * rotateAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"rotate" animationCreater:^(DWAnimationMaker *maker) {
//        maker.rotateFrom(20).rotateTo(-20).duration(2).install();
//    }];
//    
//    
//    rotateAnimation.beginTime = 2;
//    DWAnimation * combineAnimation = [bezierAnimation combineWithAnimation:rotateAnimation animationKey:nil];
//    self.a = combineAnimation;
//    //    [combineAnimation start];
//    //
//    DWAnimation * resetAnimation = [redView dw_CreateResetAnimationWithAnimationKey:nil beginTime:0 duration:2];
//    //
//    DWAnimation * addAnimation = [combineAnimation addAnimation:resetAnimation animationKey:nil];
//    
//    //    [addAnimation start];
//    
//    DWAnimation * multiAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationType:(DWAnimationTypeMove) animationKey:@"multiAnimation" beginTime:0 values:@[[NSValue valueWithCGPoint:self.view.center],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y + 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x - 100, self.view.center.y)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x + 100, self.view.center.y + 100)],[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, self.view.center.y - 100)]] timeIntervals:@[@1,@2,@2,@2,@2,@2] transition:NO];
//    //    [multiAnimation start];
//    //
//    CABasicAnimation * basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    basicAnimation1.removedOnCompletion = NO;
//    basicAnimation1.fillMode = kCAFillModeForwards;
//    basicAnimation1.duration = 2;
//    basicAnimation1.toValue = @(RadianFromDegree(180));
//    //
//    CABasicAnimation * basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    basicAnimation2.removedOnCompletion = NO;
//    basicAnimation2.fillMode = kCAFillModeForwards;
//    basicAnimation2.duration = 2;
//    basicAnimation2.toValue = @(RadianFromDegree(180));
//    DWAnimation * arrAnimation = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"arrAnimation" beginTime:2 duration:2 animations:@[basicAnimation1,basicAnimation2]];
//    //    [arrAnimation start];
//    //
//    DWAnimation * longSentence = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"longSentence" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(self.view.center).cornerRadiusTo(50).scaleTo(2).alphaTo(0).duration(2).install();
//    }];
//    //    [longSentence start];
//    
//    DWAnimation * shortSentence = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"shortSentence" animationCreater:^(DWAnimationMaker *maker) {
//        maker.reset.duration(2).install();
//        maker.alphaFrom(0.5).alphaTo(1).beginTime(2).duration(2).install();
//        maker.rotateTo(90).axis(Y).beginTime(2).duration(2).install();
//        maker.reset.moveTo(CGPointMake(100, 100)).beginTime(4).duration(2).install();
//        maker.moveTo(CGPointMake(self.view.center.x + 200, self.view.center.y)).alphaTo(0).beginTime(6).duration(2).install();
//    }];
//    
//    DWAnimation * reset = [redView.layer dw_CreateResetAnimationWithAnimationKey:nil beginTime:0 duration:2];
//    reset.completion = ^(DWAnimation * ani){
//        NSLog(@"%@ over",ani.animationKey);
//    };
//    self.arr = @[springAnimation,moveAnimation,arcAnimation,addAnimation,multiAnimation,arrAnimation,longSentence,shortSentence,reset];
    
    
//    UIView * blueView = [[UIView alloc] initWithFrame:redView.frame];
//    blueView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:blueView];
//    
//    UIView * greenView = [[UIView alloc] initWithFrame:redView.frame];
//    greenView.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:greenView];
//    
//    DWAnimation * rA = [redView dw_CreateAnimationWithKey:@"re" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(CGPointMake(100, 100)).duration(2).install();
//    }];
//    
//    DWAnimation * bA = [blueView dw_CreateAnimationWithKey:@"bl" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(CGPointMake(200, 200)).duration(2).install();
//    }];
//    
//    DWAnimation * gA = [greenView dw_CreateAnimationWithKey:@"gr" animationCreater:^(DWAnimationMaker *maker) {
//        maker.moveTo(CGPointMake(300, 300)).scaleTo(2).rotateTo(360).axis(X).beginTime(2).duration(2).install();
//    }];
//    
//    bA.beginTime = 2;
//    DWAnimationGroup * group = [[DWAnimationGroup alloc] initWithAnimations:@[rA,bA,gA]];
//    
//    group.beginTime = 2;
//    
//    self.g = group;
//    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:@"ro" beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:180 rotateAxis:X deep:300];
//    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:nil beginTime:0 duration:1 bezierPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x - 50, self.view.center.y - 50) radius:sqrt(5000) startAngle:M_PI_4 endAngle:M_PI_4 * 3 clockwise:YES] autoRotate:NO];
//    DWAnimation * ani2 = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:nil animationCreater:^(DWAnimationMaker *maker) {
//        maker.rotateTo(90).duration(1).install();
//    }];
    
    CALayer * line1 = [CALayer layer];
    line1.backgroundColor = [UIColor whiteColor].CGColor;
    line1.bounds = CGRectMake(0, 0, 1, self.view.bounds.size.height);
    line1.position = CGPointMake(self.view.center.x - 50, self.view.center.y);
    [self.view.layer addSublayer:line1];
    CALayer * line2 = [CALayer layer];
    line2.backgroundColor = [UIColor whiteColor].CGColor;
    line2.bounds = CGRectMake(0, 0, 1, self.view.bounds.size.height);
    line2.position = CGPointMake(self.view.center.x + 50, self.view.center.y);
    [self.view.layer addSublayer:line2];
    CALayer * line3 = [CALayer layer];
    line3.backgroundColor = [UIColor whiteColor].CGColor;
    line3.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 1);
    line3.position = CGPointMake(self.view.center.x, self.view.center.y - 50);
    [self.view.layer addSublayer:line3];
    CALayer * line4 = [CALayer layer];
    line4.backgroundColor = [UIColor whiteColor].CGColor;
    line4.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 1);
    line4.position = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view.layer addSublayer:line4];
    
    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithLayer:redView.layer animationKey:nil
                                                          beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:360 simulateChangeAnchor:CGPointMake(0.25, 0.5)];
    ani.repeatCount = MAXFLOAT;
    self.a = ani;
}

-(void)finish:(NSNotification *)notice
{
    NSDictionary * dic = notice.object;
    DWAnimation * animaiton = dic[@"animation"];
    NSLog(@"finish:%@",animaiton.animationKey);
}

-(void)start:(NSNotification *)notice
{
    NSDictionary * dic = notice.object;
    DWAnimation * animaiton = dic[@"animation"];
    NSLog(@"start:%@",animaiton.animationKey);
}

-(void)bu
{
//    [UIView dw_StartAnimations:self.arr playMode:(DWAnimationPlayModeSingle)];
//    [self.g start];
    [self.a start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
