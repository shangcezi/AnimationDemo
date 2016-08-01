//
//  ViewController.m
//  AnimationDemo
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 PersonLiu. All rights reserved.
//
#define SCREENH     [UIScreen mainScreen].bounds.size.height
#define SCREENW     [UIScreen mainScreen].bounds.size.width

#define DurationTimeinterval   1.0
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,assign) NSInteger pageNum;
@property (nonatomic ,assign) BOOL isSelect;
@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//    [UIScreen mainScreen].bounds.size.height
    [[UINavigationBar appearance]setTranslucent:NO];
    
    self.title = NSLocalizedString(@"动画效果", nil);
    _imageView = [UIImageView new];
    _imageView.frame = CGRectMake(0, 60, SCREENW, SCREENH-60);
    _imageView.image = [UIImage imageNamed:@"a1.jpg"];
    [self.view addSubview:_imageView];
    
    _pageNum = 0;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREENW/2. -50, SCREENH/2. -25, 100, 50);
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 
}
-(void)buttonClick:(UIButton *)sender{

    
//下面是四中切换视图的方向:    (有些动画默认的是没有四个方向的,会按照独有的方式展示,这四个方向并不会影响他的)
    NSString *typeString;
    switch (_pageNum) {
            case 0:
            typeString = kCATransitionFromLeft;
                break;
            case 1:
            typeString = kCATransitionFromRight;
                break;
            case 2:
            typeString = kCATransitionFromTop;
                break;
            case 3:
            typeString = kCATransitionFromBottom;
                break;
            default:
                break;
    }

    _pageNum = _pageNum +1;
    if (_pageNum > 3) {
        _pageNum = 0;
    }
    
    
    
    
//下面是切换动画的类型.
   /*
    kCATransitionFade            淡入淡出
    kCATransitionMoveIn          覆盖
    kCATransitionPush            推挤
    kCATransitionReveal          揭开
    @"cube"                      3D立方体
    @"suckEffect"                吸允
    @"oglflip"                   翻转
    @"rippleEffect"              波纹
    @"pageCurl"                  翻页
    @"pageUnCurl"                反翻页
    @"cameraIrisHollowOpen"      开镜头
    @"cameraIrisHollowClose"     关镜头
    @"curlDown"                  下翻页
    @"curlUp"                    上翻页
    @"flipFromLeft"              左翻页
    @"flipFromeRight"            右翻页
                                   *
                                   *
                                   *
                                   *
    */
    [self transitionWithType:@"rippleEffect" WithSubtype:typeString ForView:_imageView];
    if(self.isSelect == 0){
        [self addBgImageWithImageName:@"j.jpg"];
    }else{
        [self addBgImageWithImageName:@"a1.jpg"];
    }
    self.isSelect = !self.isSelect;
    

}
//实现动画效果
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = DurationTimeinterval;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
    
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:DurationTimeinterval animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma 给View添加背景图
-(void)addBgImageWithImageName:(NSString *) imageName
{
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
