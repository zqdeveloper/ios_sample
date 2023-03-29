//
//  ViewController.m
//  invertedimage
//
//  Created by 张青 on 2023/3/29.
//

#import "ViewController.h"
#import "CAReplicatorLayerView.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *img;
@end

@implementation ViewController

- (void)loadView{
    self.view = [[CAReplicatorLayerView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    CAReplicatorLayer *layer = (CAReplicatorLayer*)self.view.layer;
    layer.instanceCount = 2;
    //layer.instanceTransform = CATransform3DTranslate(layer.instanceTransform, 0, self.img.size.height, 0);
    //绕着复制层的锚点进行旋转.
    layer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    //倒影
    layer.instanceRedOffset -= 0.1;
    layer.instanceBlueOffset -= 0.1;
    layer.instanceGreenOffset -= 0.1;
    layer.instanceAlphaOffset -= 0.1;
}

- (UIImage *)img{
    if(!_img){
        _img = [UIImage imageNamed:@"卡哇伊"];
    }
    return _img;
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithImage:self.img];
        _imageView.frame = CGRectMake(self.view.center.x - self.img.size.width*0.5, self.view.center.y - self.img.size.height, self.img.size.width, self.img.size.height);
        
    }
    return _imageView;
}

@end
