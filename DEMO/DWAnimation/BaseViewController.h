//
//  BaseViewController.h
//  DWAnimation
//
//  Created by Wicky on 2019/1/29.
//  Copyright © 2019 Wicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DWAnimation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property (nonatomic ,strong) DWAnimation * ani;

@property (nonatomic ,strong) UIView * redView;

@property (nonatomic ,copy) dispatch_block_t touchAction;

-(void)initAnimation;

-(void)timing;

-(void)stopTiming;

-(void)configTouchAction;

@end

NS_ASSUME_NONNULL_END
