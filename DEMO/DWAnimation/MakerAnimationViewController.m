#import "MakerAnimationViewController.h"
#import "DWAnimationHeader.h"
@interface MakerAnimationViewController ()

@property (nonatomic ,strong) NSArray * arr;

@property (nonatomic ,strong) DWAnimationGroup * g;

@end

@implementation MakerAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initAnimation {
    self.ani = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"redAni" animationCreater:^(DWAnimationMaker *maker) {
        maker.moveTo(self.view.center).duration(0.4).install();
        maker.backgroundColorTo([UIColor greenColor]).beginTime(0.4).duration(0.4).install();
    }];
}

//-(void)testBeginTimeRepeat {
//    [self.view addSubview:self.redView];
//    CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//    ani.fromValue = (id)[UIColor redColor].CGColor;
//    ani.toValue = (id)[UIColor blueColor].CGColor;
//    //    ani.beginTime = 2 + ani.beginTime;
//    ani.duration = 1;
//    ani.repeatCount = 3;
//    ani.removedOnCompletion = NO;
//    ani.fillMode = kCAFillModeForwards;
//    self.touchAction = ^{
//        ani.beginTime = CACurrentMediaTime() + 2;
//        [self.redView.layer addAnimation:ani forKey:@"aaaa"];
//    };
//}
//

//
//-(void)testSimulateChangeAnchorAnimation {
//    [self.view addSubview:self.redView];
//    __weak typeof(self)weakSelf = self;
//    self.a = [[DWAnimation alloc] initAnimationWithContent:self.redView animationKey:@"simulateAnimation" beginTime:2 duration:2 rotateStartAngle:0 rotateEndAngle:360 simulateChangeAnchor:CGPointMake(1, 0.5)];
//    self.touchAction = ^{
//        [weakSelf.a start];
//    };
//}

@end
