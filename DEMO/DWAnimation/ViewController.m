//
//  ViewController.m
//  DWAnimation
//
//  Created by Wicky on 16/9/6.
//  Copyright © 2016年 Wicky. All rights reserved.
//

#import "ViewController.h"
#import "DWAnimationHeader.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) NSArray * dataArr;

@property (nonatomic ,strong) NSArray * titleArr;

@property (weak, nonatomic) IBOutlet UITableView *mainTab;

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DWAnimation";
    [self.mainTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
}

#pragma mark --- delegate ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * c = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    c.textLabel.text = self.titleArr[indexPath.row];
    return c;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * clazz = self.dataArr[indexPath.row];
    UIViewController * vc = [NSClassFromString(clazz) new];
    vc.title = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- setter/getter ---
-(NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[
                     @"MakerAnimationViewController",
                     @"ArrAnimationViewController",
                     @"TimeIntervalAnimationViewController",
                     @"BezierAnimationViewController",
                     @"ArcAnimationViewController",
                     @"SpringAnimationViewController",
                     @"KeyPathAnimationViewController",
                     @"RotateAxisAnimationViewController",
                     @"SimulateChangeAnchorViewController",
                     @"AppendAnimationViewController",
                     @"CreateAnimationViewController",
                     @"CombineAnimationViewController",
                     @"CombineAnimationsInArrayViewController",
                     @"ResetAnimationViewController",
                     @"AnimationGroupViewController",
                     @"ManagerSingleAnimationViewController",
                     @"ManagerMultiAnimationViewController",
                     ];
    }
    return _dataArr;
}

-(NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[
                      @"以链式函数生成动画",
                      @"以CAAnimation数组生成动画",
                      @"以关键帧生成动画",
                      @"以贝塞尔曲线生成动画",
                      @"以弧线生成动画",
                      @"生成弹簧动画",
                      @"生成特殊属性动画",
                      @"改变旋转轴，带透视效果的旋转动画",
                      @"拟合锚点改变的旋转动画",
                      @"拼接两个动画",
                      @"以多个DWAnimation串行拼接成新动画",
                      @"组合两个DWAnimation为一个新动画",
                      @"组合数组中的所有DWAnimation为一个新动画",
                      @"创建恢复动画",
                      @"动画组",
                      @"Manager管理的串行动画",
                      @"Manager管理的并行动画",
                      ];
    }
    return _titleArr;
}

@end
