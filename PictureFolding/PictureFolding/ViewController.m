//
//  ViewController.m
//  PictureFolding
//
//  Created by 张青 on 2023/3/28.
//

#import "ViewController.h"
#define angle2Rad(angle) ((angle/180.0*M_PI))

@interface ViewController ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bottomImageView];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.bgView];
    [self.bottomImageView.layer addSublayer:self.gradientLayer];
}

//-(void)gradientLayer{
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(10, self.img.size.height*0.5+10, self.bottomImageView.frame.size.width, self.bottomImageView.frame.size.height);
//    gradientLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
//    gradientLayer.startPoint = CGPointMake(0, 0.5);
//    gradientLayer.endPoint = CGPointMake(1, 0.5);
//    gradientLayer.locations = 0;
//    [self.bgView.layer addSublayer:gradientLayer];
//}


- (CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bottomImageView.bounds;
        //_gradientLayer.backgroundColor = [UIColor grayColor].CGColor;
        //设置渐变的颜色
        _gradientLayer.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
        _gradientLayer.opacity = 0;
    }
    return _gradientLayer;
}

- (UIImageView *)topImageView{
    if(!_topImageView){
        _topImageView = [[UIImageView alloc]initWithImage:self.img];
        _topImageView.center = self.view.center;
        _topImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
        _topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
        _topImageView.layer.position = CGPointMake(_topImageView.center.x, CGRectGetMaxY(_topImageView.frame));
        //_topImageView.contentMode = UIViewContentModeBottom;
        CGRect rect =  _topImageView.frame;
        rect.size.height = self.img.size.height * 0.5;
        rect.origin.y = self.view.center.y - rect.size.height;
        _topImageView.frame = rect;
//        _topImageView.layer.borderColor = [UIColor redColor].CGColor;
//        _topImageView.layer.borderWidth = 1;
    }
    return _topImageView;
}


- (UIImageView *)bottomImageView{
    if(!_bottomImageView){
        _bottomImageView = [[UIImageView alloc]initWithImage:self.img];
        _bottomImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
        _bottomImageView.layer.anchorPoint = CGPointMake(0.5, 0);
        _bottomImageView.layer.position = CGPointMake(_bottomImageView.center.x, CGRectGetMinY(_bottomImageView.frame));
        _bottomImageView.center = self.view.center;
        CGRect rect =  _bottomImageView.frame;
        rect.size.height = self.img.size.height * 0.5;
        rect.origin.y = self.view.center.y;
        _bottomImageView.frame = rect;
        //_bottomImageView.contentMode = UIViewContentModeTop;
//        _bottomImageView.layer.borderColor = [UIColor blueColor].CGColor;
//        _bottomImageView.layer.borderWidth = 1;
    }
    return _bottomImageView;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, self.img.size.width+20, self.img.size.height+20)];
        _bgView.center = self.view.center;
        _bgView.backgroundColor = [UIColor clearColor];
//        _bgView.layer.borderColor = [UIColor blackColor].CGColor;
//        _bgView.layer.borderWidth = 1;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_bgView addGestureRecognizer:pan];
    }
    return _bgView;
}

-(void)pan:(UIPanGestureRecognizer*)pan{
    CGPoint point = [pan locationInView:self.bgView];
    CGFloat max = CGRectGetMaxY(self.bgView.frame);
    CGFloat p = point.y/max*1.0;
    if(p<=0){
       p= 0;
    }
    if(p>=1){
        p=1;
    }
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    CGFloat angle = p * 180.0;
    self.gradientLayer.opacity = p;
//    NSLog(@"%f--%f---%f---%f",point.y,max, p,angle);
    self.topImageView.layer.transform = CATransform3DRotate(transform, -angle2Rad(angle), 1, 0, 0);
    if(pan.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.topImageView.layer.transform = CATransform3DRotate(transform, 0, 1, 0, 0);
            self.gradientLayer.opacity = 0;
        } completion:nil];
    }
}


- (UIImage *)img{
    if(!_img){
        _img = [UIImage imageNamed:@"知道错了"];
    }
    return _img;
}
@end
