//
//  ViewController.m
//  AnimationGroup
//
//  Created by 张青 on 2023/3/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *redView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.redView];
}

- (UIView *)redView{
    if(!_redView){
        _redView = [[UIView alloc]initWithFrame:CGRectMake(40, 64, 200, 200)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *anim1 = [CABasicAnimation animation];
    anim1.keyPath = @"position.y";
    anim1.toValue = @600;
    
    CABasicAnimation *anim2 = [CABasicAnimation animation];
    anim2.keyPath = @"transform.scale";
    anim2.toValue = @0.5;
    
    CAAnimationGroup * anim = [CAAnimationGroup animation];
    anim.animations = @[anim1,anim2];
    anim.duration = 2;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [self.redView.layer addAnimation:anim forKey:nil];
}

@end
