//
//  WheelView.m
//  turntable
//
//  Created by 张青 on 2023/3/27.
//

#import "WheelView.h"
#import "WheelButton.h"
#define angle2Rad(angle) ((angle)/180.0*M_PI)

@interface WheelView ()<CAAnimationDelegate>
@property (nonatomic, strong) UIImageView * contentView; //背景图片
@property (nonatomic, strong) UIButton * startRotation; //开始选号按钮
@property (nonatomic, strong) CADisplayLink *link; //定时器
@property (nonatomic, strong) UIImage *image; //背景图片
@property (nonatomic, weak) WheelButton *previousButton; //选中的按钮

@end


@implementation WheelView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame: frame]){
        [self setup];
    }
    return self;
}



- (void)drawRect:(CGRect)rect{
    [self.image drawAtPoint:CGPointMake(0, 0)];
}



- (UIImage *)image{
    if(!_image){
        _image = [UIImage imageNamed:@"LuckyBaseBackground"];
    }
    return _image;
}

- (UIImageView *)contentView{
    if(!_contentView){
        _contentView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LuckyRotateWheel"]];
        _contentView.userInteractionEnabled = YES;
    }
    return _contentView;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    [self addSubview:self.contentView];
    
    UIImage *original = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *originalPressed = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    UIImage *backgound = [UIImage imageNamed:@"LuckyRototeSelected"];
    
    CGFloat btnW = 68;
    CGFloat btnH = self.contentView.bounds.size.height * 0.5;
    
    
    //CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat clipW = original.size.width / 12.0*2;
    CGFloat clipH = original.size.height*2;
    CGFloat X = 0;
    CGFloat Y = 0;
   
    for(int i=0;i<12;i++){
        CGRect rectNormal = CGRectMake(X, Y, clipW, clipH);
        CGRect rectPressed = CGRectMake(X, Y, clipW,clipH);
        
        X += clipW;
        
        CGImageRef refNormal =  CGImageCreateWithImageInRect(original.CGImage, rectNormal);
        CGImageRef refPressed =  CGImageCreateWithImageInRect(originalPressed.CGImage, rectPressed);
        
        UIImage *imageNormal = [UIImage imageWithCGImage:refNormal];
        UIImage *imagePressed = [UIImage imageWithCGImage:refPressed];
    

        WheelButton *button = [WheelButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, btnW, btnH);
        button.layer.position = CGPointMake(self.contentView.bounds.size.width*0.5, btnH);
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.transform = CATransform3DMakeRotation(angle2Rad(i*30), 0, 0, 1);
        [button setBackgroundImage:backgound forState:UIControlStateSelected];
        [button setImage:imageNormal forState:UIControlStateNormal];
        [button setImage:imagePressed forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        if(i==0){
            [self selectButton:button];
        }
    }
    [self addSubview:self.startRotation];
}

- (UIButton *)startRotation{
    if(!_startRotation){
        CGFloat scale = [UIScreen mainScreen].scale;
        _startRotation = [UIButton buttonWithType:UIButtonTypeCustom];
        _startRotation.bounds = CGRectMake(0, 0, 162.0/scale, 162.0/scale);
        _startRotation.center = self.contentView.center;
        [_startRotation setImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
        [_startRotation setImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateSelected];
        [_startRotation addTarget:self action:@selector(startChoose) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRotation;
}

-(void)selectButton:(WheelButton*)btn{
    self.previousButton.selected = NO;
    self.previousButton = btn;
    btn.selected = YES;
}

- (CADisplayLink *)link{
    if(!_link){
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

-(void)update{
    self.contentView.transform = CGAffineTransformRotate(self.contentView.transform, angle2Rad(1));
}

- (void)rotation{
    self.link.paused = NO;
}

- (void)stop{
    self.link.paused = YES;
}

-(void)startChoose{
    self.link.paused = YES;
    self.contentView.userInteractionEnabled = NO;
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.repeatCount = 1;
    anim.delegate = self;
    anim.keyPath = @"transform.rotation";
    anim.duration = 0.5;
    anim.toValue = @(M_PI * 4);
    [self.contentView.layer addAnimation:anim forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CGAffineTransform transform = self.previousButton.transform;
    CGFloat angle = atan2(transform.b, transform.a);
    self.contentView.transform = CGAffineTransformMakeRotation(-angle);
    self.contentView.userInteractionEnabled = YES;
}
@end
