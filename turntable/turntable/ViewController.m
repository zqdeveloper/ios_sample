//
//  ViewController.m
//  turntable
//
//  Created by 张青 on 2023/3/27.
//

#import "ViewController.h"
#import "WheelView.h"
@interface ViewController ()
@property (nonatomic, strong) WheelView *wheelView;
@property (nonatomic, strong) UIButton *startRotaion;
@property (nonatomic, strong) UIButton *stopRotaion;
@end

@implementation ViewController

 

- (void)loadView{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wheelView];
    [self.view addSubview:self.startRotaion];
    [self.view addSubview:self.stopRotaion];
  
}

- (WheelView *)wheelView{
    if(!_wheelView){
        _wheelView = [[WheelView alloc]init];
        _wheelView.center = self.view.center;
    }
    return _wheelView;
}


- (UIButton *)startRotaion{
    if(!_startRotaion){
        _startRotaion = [UIButton buttonWithType:UIButtonTypeSystem];
        [_startRotaion setTitle:@"开始" forState:UIControlStateNormal];
        _startRotaion.frame = CGRectMake(80, 100, 100, 40);
        [_startRotaion addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRotaion;
}

- (UIButton *)stopRotaion{
    if(!_stopRotaion){
        _stopRotaion = [UIButton buttonWithType:UIButtonTypeSystem];
        [_stopRotaion setTitle:@"暂停" forState:UIControlStateNormal];
        _stopRotaion.frame = CGRectMake(200, 100, 100, 40);
        [_stopRotaion addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopRotaion;
}


-(void)start{
    [self.wheelView rotation];
}

-(void)stop{
    [self.wheelView stop];
}
@end
