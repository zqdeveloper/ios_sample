//
//  ViewController.m
//  volume
//
//  Created by 张青 on 2023/3/29.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.containerView.bounds.size.height-300, 45, 300);
    layer.position = CGPointMake((self.containerView.bounds.size.width- 5*45)/6.0, self.containerView.bounds.size.height);
    layer.anchorPoint = CGPointMake(0, 1);
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.autoreverses = YES;
    anim.toValue = @0;
    anim.duration = 0.6;
    anim.repeatCount = MAXFLOAT;
    [layer addAnimation:anim forKey:nil];
    
    CAReplicatorLayer * replicatorLayer  = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:layer];
    

    CGFloat margin = (self.containerView.bounds.size.width- 5*45)/6.0+45;
    replicatorLayer.instanceTransform = CATransform3DTranslate(replicatorLayer.instanceTransform, margin, 0, 0);
    replicatorLayer.instanceCount = 5;
    replicatorLayer.instanceDelay = 0.2;
    
    [self.containerView.layer addSublayer:replicatorLayer];
    [self.view addSubview:self.containerView];
    
}


- (UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width-20, 400)];
        _containerView.backgroundColor = [UIColor grayColor];
    }
    return _containerView;
}


@end
