//
//  ViewController.m
//  PictureJitter
//
//  Created by 张青 on 2023/3/23.
//

#import "ViewController.h"
#define angle2Rad(angle) (M_PI*angle/180.0)

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
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@angle2Rad(-10),@angle2Rad(10)];
    anim.repeatCount = MAXFLOAT;
    anim.autoreverses = YES;
    anim.removedOnCompletion = NO;
    anim.duration = 0.2;
}

-(void)pathAnimation{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.duration = 4;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.imageView.bounds.size.width,self.imageView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.view.bounds.size.width-self.imageView.bounds.size.width, self.imageView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.view.bounds.size.width-self.imageView.bounds.size.width, self.view.bounds.size.height-self.imageView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.imageView.bounds.size.width, self.view.bounds.size.height-self.imageView.bounds.size.height)];
    [path addLineToPoint:CGPointMake(self.imageView.bounds.size.width,self.imageView.bounds.size.height)];
    anim.path = path.CGPath;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    anim.fillMode  = kCAFillModeForwards;
    [self.imageView.layer addAnimation:anim forKey:nil];
}
@end
