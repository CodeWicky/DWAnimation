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

@property (nonatomic ,strong) UIView * redView;

@property (nonatomic ,copy) dispatch_block_t touchAction;

@property (nonatomic ,strong) NSArray * arr;

@property (nonatomic ,strong) DWAnimation * a;

@property (nonatomic ,strong) DWAnimationGroup * g;

@property (nonatomic ,strong) UILabel * timeLb;

@property (nonatomic ,strong) NSTimer * timer;

@property (nonatomic ,assign) CGFloat time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finish:) name:DWAnimationPlayFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(start:) name:DWAnimationPlayStartNotification object:nil];
    [self.view addSubview:self.timeLb];
    [self testArrAnimation];
    
//    CASpringAnimation * animation = [CASpringAnimation animationWithKeyPath:@"position"];
//    animation.beginTime = 10;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
////    animation.mass = mass;
////    animation.stiffness = stiffness;
////    animation.damping = damping;
////    animation.initialVelocity = initialVelocity;
//    animation.duration = animation.settlingDuration;
//
//    NSLog(@"%f",animation.settlingDuration);
//
//
//    UIButton * button = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    [button setFrame:CGRectMake(100, 100, 60, 30)];
//    [button setTitle:@"点我啊" forState:(UIControlStateNormal)];
//    [button setBackgroundColor:[UIColor greenColor]];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(bu) forControlEvents:(UIControlEventTouchUpInside)];
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    redView.center = CGPointMake(self.view.center.x + 50, self.view.center.y);
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
    
//    CALayer * line1 = [CALayer layer];
//    line1.backgroundColor = [UIColor whiteColor].CGColor;
//    line1.bounds = CGRectMake(0, 0, 1, self.view.bounds.size.height);
//    line1.position = CGPointMake(self.view.center.x - 50, self.view.center.y);
//    [self.view.layer addSublayer:line1];
//    CALayer * line2 = [CALayer layer];
//    line2.backgroundColor = [UIColor whiteColor].CGColor;
//    line2.bounds = CGRectMake(0, 0, 1, self.view.bounds.size.height);
//    line2.position = CGPointMake(self.view.center.x + 50, self.view.center.y);
//    [self.view.layer addSublayer:line2];
//    CALayer * line3 = [CALayer layer];
//    line3.backgroundColor = [UIColor whiteColor].CGColor;
//    line3.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 1);
//    line3.position = CGPointMake(self.view.center.x, self.view.center.y - 50);
//    [self.view.layer addSublayer:line3];
//    CALayer * line4 = [CALayer layer];
//    line4.backgroundColor = [UIColor whiteColor].CGColor;
//    line4.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 1);
//    line4.position = CGPointMake(self.view.center.x, self.view.center.y + 50);
//    [self.view.layer addSublayer:line4];
//
//    DWAnimation * ani = [[DWAnimation alloc] initAnimationWithContent:redView animationKey:nil
//                                                          beginTime:0 duration:2 rotateStartAngle:0 rotateEndAngle:360 simulateChangeAnchor:CGPointMake(0.25, 0.5)];
//    ani.repeatCount = MAXFLOAT;
//    self.a = ani;
}

-(void)testMakerAnimation {
    [self.view addSubview:self.redView];
    self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"redAni" animationCreater:^(DWAnimationMaker *maker) {
        maker.moveTo(self.view.center).duration(0.4).install();
        maker.backgroundColorTo([UIColor greenColor]).beginTime(0.4).duration(0.4).install();
    }];
    __weak typeof(self)weakSelf = self;
    self.touchAction = ^{
        [weakSelf.a start];
    };
}

-(void)testArrAnimation {
    [self.view addSubview:self.redView];
    CABasicAnimation * aniP = [CABasicAnimation animationWithKeyPath:@"position"];
    aniP.toValue = [NSValue valueWithCGPoint:self.view.center];
    aniP.fromValue = [NSValue valueWithCGPoint:self.redView.center];
    aniP.duration = 0.4;
    aniP.beginTime = 1;
    
    self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView.layer animationKey:@"arrAni" beginTime:1 duration:1.4 animations:@[aniP]];
    self.a.repeatCount = 2;
    __weak typeof(self)weakSelf = self;
    self.touchAction = ^{
        [weakSelf.a start];
    };
}

-(void)timing {
    self.time = 0;
    self.timeLb.text = @"0";
    [self.timer invalidate];
    self.timer = nil;
    [self.timer fire];
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.touchAction) {
        self.touchAction();
    }
    [self timing];
}

-(UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

-(UILabel *)timeLb {
    if (!_timeLb) {
        _timeLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 50)];
    }
    return _timeLb;
}

-(NSTimer *)timer {
    if (!_timer) {
        __weak typeof(self)weakSelf = self;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            weakSelf.timeLb.text = [NSString stringWithFormat:@"%.1f",self.time];
            weakSelf.time += 0.1;
        }];
    }
    return _timer;
}

@end
