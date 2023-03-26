//
//  HandleImageView.m
//  draw
//
//  Created by 张青 on 2023/3/21.
//

#import "HandleImageView.h"

@interface HandleImageView ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@end


@implementation HandleImageView


- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [_imageView addGestureRecognizer:pan];
        
        UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
        rotation.delegate = self;
        [_imageView addGestureRecognizer:rotation];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
        pinch.delegate = self;
        [_imageView addGestureRecognizer:pinch];
        UILongPressGestureRecognizer *LongPreess = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(LongPress:)];
        LongPreess.delegate = self;
        [_imageView addGestureRecognizer:LongPreess];
       
    }
    return _imageView;
}

-(void)pan:(UIPanGestureRecognizer*)pan{
    CGPoint point = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

-(void)rotation:(UIRotationGestureRecognizer*)rotation{
    rotation.view.transform = CGAffineTransformRotate(rotation.view.transform, rotation.rotation);
    rotation.rotation = 0;
}

-(void)pinch:(UIPinchGestureRecognizer*)pinch{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

-(void)LongPress:(UILongPressGestureRecognizer*)LongPress{
    if(LongPress.state == UIGestureRecognizerStateBegan){
        [UIView animateWithDuration:0.5 animations:^{
            LongPress.view.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                LongPress.view.alpha = 1;
            } completion:^(BOOL finished) {
                [self finishImage];
            }];
        }];
    }
}

-(void)finishImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if([self.delegete respondsToSelector:@selector(HandleImageView:image:)]){
        [self.delegete HandleImageView:self image:image];
    }
}


- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
