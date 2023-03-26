//
//  ViewController.m
//  draw
//
//  Created by 张青 on 2023/3/19.
//

#import "ViewController.h"
#import "CanvasView.h"
#import "HandleImageView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HandleImageViewDelegete>
@property (nonatomic, strong) UIStackView *vStackView;
@property (nonatomic, strong) UIStackView *HStatckView;
@property (nonatomic, strong) NSMutableArray<UIBarButtonItem*> *items;
@property (nonatomic, strong) CanvasView *canvasView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    toolBar.frame  = CGRectMake(0,52,self.view.bounds.size.width, 44);
    toolBar.items = self.items;
    [self.view addSubview:toolBar];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-120,self.view.bounds.size.width, 120)];
    UISlider *slide  = [[UISlider alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 20)];
    [slide addTarget:self action:@selector(pathWidth:) forControlEvents:UIControlEventValueChanged];
    slide.minimumValue = 1;
    slide.maximumValue = 10;
    [bottomView  addSubview:slide];
    bottomView.backgroundColor = [UIColor orangeColor];

    UIStackView *stackViwe = [[UIStackView alloc]initWithFrame:CGRectMake(10, 40, self.view.bounds.size.width-20, 40)];
    stackViwe.distribution  = UIStackViewDistributionFillEqually;
    stackViwe.axis = UILayoutConstraintAxisHorizontal;
    stackViwe.spacing = 60;
   

    UIButton * yellow = [UIButton buttonWithType:UIButtonTypeSystem];
    yellow.backgroundColor = [UIColor yellowColor];
    [yellow addTarget:self action:@selector(pathColor:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * green = [UIButton buttonWithType:UIButtonTypeCustom];
    green.backgroundColor = [UIColor greenColor];
    [green addTarget:self action:@selector(pathColor:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * blue = [UIButton buttonWithType:UIButtonTypeCustom];
    blue.backgroundColor = [UIColor blueColor];
    [blue addTarget:self action:@selector(pathColor:) forControlEvents:UIControlEventTouchUpInside];


    [stackViwe addArrangedSubview:yellow];
    [stackViwe addArrangedSubview:green];
    [stackViwe addArrangedSubview:blue];
   

    [bottomView addSubview:stackViwe];
    [self.view addSubview:bottomView];
    
    self.canvasView.frame = CGRectMake(0, 96, self.view.bounds.size.width, self.view.bounds.size.height - 96-120);
    [self.view addSubview:self.canvasView];
    
}

- (NSMutableArray<UIBarButtonItem *> *)items{
    if(!_items){
        _items = [NSMutableArray array];
        UIBarButtonItem *item1 = [[UIBarButtonItem  alloc]initWithTitle:@"清屏" style:UIBarButtonItemStylePlain target:self action:@selector(clear)];
        UIBarButtonItem *item2 = [[UIBarButtonItem  alloc]initWithTitle:@"撤销" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        UIBarButtonItem *item3 = [[UIBarButtonItem  alloc]initWithTitle:@"橡皮擦" style: UIBarButtonItemStylePlain target:self action:@selector(eraser)];
        UIBarButtonItem *item4 = [[UIBarButtonItem  alloc]initWithTitle:@"图片" style:UIBarButtonItemStylePlain target:self action:@selector(pictue)];
        // 创建弹簧按钮
        UIBarButtonItem *flexibleButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *item5 = [[UIBarButtonItem  alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
        [_items addObject:item1];
        [_items addObject:item2];
        [_items addObject:item3];
        [_items addObject:item4];
        [_items addObject:flexibleButton];
        [_items addObject:item5];
    }
    return _items;
}

- (CanvasView *)canvasView{
    if(!_canvasView){
        _canvasView = [[CanvasView alloc]init];
        _canvasView.backgroundColor = [UIColor clearColor];
    }
    return _canvasView;
}


-(void)clear{
    [self.canvasView clear];
}

-(void)cancel{
    [self.canvasView cancel];
}

-(void)eraser{
    [self.canvasView eraser];
}

-(void)pathColor:(UIButton*)button{
    self.canvasView.pathColor = button.backgroundColor;
}

-(void)pathWidth:(UISlider*)slide{
    self.canvasView.pathWidth = slide.value;
}

-(void)pictue{
    UIImagePickerController * pickeVc= [[UIImagePickerController alloc]init];
    pickeVc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum ;
    pickeVc.delegate =  self;
    [self presentViewController:pickeVc animated:YES completion:nil];
    
}
-(void)save{
    UIGraphicsBeginImageContextWithOptions(self.canvasView.bounds.size, NO, 0);
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    [self.canvasView.layer renderInContext:ctx];
    UIImage *img =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"保存成功");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    HandleImageView *handleImageView = [[HandleImageView alloc]initWithFrame:self.canvasView.frame];
    [self.view addSubview:handleImageView];
    handleImageView.backgroundColor = [UIColor clearColor];
    handleImageView.image = img;
    handleImageView.delegete = self;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)HandleImageView:(HandleImageView *)handleImageView image:(UIImage *)image{
    self.canvasView.img = image;
    [handleImageView removeFromSuperview];
}
@end
