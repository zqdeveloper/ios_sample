//
//  ViewController.m
//  TransitionAnimation
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
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
        _imageView.center = self.view.center;
    }
    return _imageView;
}
static int _index = 1;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView transitionWithView:self.imageView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _index++;
        if(_index>=4){
            _index = 1;
        }
        NSString *imaageName = [NSString stringWithFormat:@"%d",_index];
        UIImage *img = [UIImage imageNamed:imaageName];
        self.imageView.image = img;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)transition{
    _index++;
    if(_index>=4){
        _index = 1;
    }
    NSString *imaageName = [NSString stringWithFormat:@"%d",_index];
    UIImage *img = [UIImage imageNamed:imaageName];
    self.imageView.image = img;
    
    CATransition  *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = @"cube";
    //transition.startProgress = 0;
    //transition.endProgress = 0.5;
    [self.imageView.layer addAnimation:transition forKey:nil];
}

@end
