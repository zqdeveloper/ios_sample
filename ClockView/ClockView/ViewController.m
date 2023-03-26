//
//  ViewController.m
//  ClockView
//
//  Created by 张青 on 2023/3/22.
//

#import "ViewController.h"


#define width MIN(self.imageView.bounds.size.width, self.imageView.bounds.size.height) * 0.5

@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CALayer *secl;
@property (nonatomic, strong) CALayer *minL;
@property (nonatomic, strong) CALayer *houL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    [self addSecl];
    [self animation];
}


-(void)addSecl{
    [self.imageView.layer addSublayer:self.houL];
    [self.imageView.layer addSublayer:self.minL];
    [self.imageView.layer addSublayer:self.secl];
}

-(void)animation{
    [self timeChanged];
    [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
}


-(void)timeChanged{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDate * date = [NSDate date];
    NSDateComponents * components = [calender components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date];
    NSInteger sec = components.second;
    NSInteger min = components.minute;
    NSInteger hour = components.hour;
    CGFloat secA = sec * M_PI / 180.0 * 6;
    self.secl.transform = CATransform3DMakeRotation(secA, 0, 0, 1);
    
    CGFloat minA = min * M_PI / 180.0 * 6;
    self.minL.transform = CATransform3DMakeRotation(minA, 0, 0, 1);
    
    
    CGFloat houLA = hour * M_PI / 180.0 * 30 +  minA / 12;
    self.houL.transform = CATransform3DMakeRotation(houLA, 0, 0, 1);
}



- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"钟表"]];
        _imageView.center = self.view.center;
    }
    return _imageView;
}


- (CALayer *)secl{
    if(!_secl){
        _secl = [CALayer layer];
        _secl.bounds = CGRectMake(0, 0, 1, width - 15);
        _secl.backgroundColor = [UIColor redColor].CGColor;
        _secl.position =  CGPointMake(width, width);
        _secl.anchorPoint = CGPointMake(0.5, 1);
    }
    return _secl;
}



- (CALayer *)minL{
    if(!_minL){
        _minL = [CALayer layer];
        _minL.bounds = CGRectMake(0, 0, 3, width - 20);
        _minL.backgroundColor = [UIColor blackColor].CGColor;
        _minL.position = CGPointMake(width, width);
        _minL.anchorPoint = CGPointMake(0.5, 1);
        _minL.cornerRadius = 1.5;
    }
    return _minL;
}

- (CALayer *)houL{
    if(!_houL){
        _houL = [CALayer layer];
        _houL.bounds = CGRectMake(0, 0, 3, width - 40);
        _houL.backgroundColor = [UIColor blackColor].CGColor;
        _houL.position = CGPointMake(width, width);
        _houL.anchorPoint = CGPointMake(0.5, 1);
        _houL.cornerRadius = 1.5;
    }
    return _houL;
}


@end
