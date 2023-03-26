//
//  ViewController.m
//  heartbeat
//
//  Created by 张青 on 2023/3/23.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"心"]];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.toValue = @0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 1;
    anim.autoreverses = YES;
    [self.imageView.layer addAnimation:anim forKey:nil];
}

-(void)closeAimation{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.view.layer.position = CGPointMake(10, 10);
    [CATransaction commit];
}
@end
