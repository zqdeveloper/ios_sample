//
//  CanvasView.m
//  draw
//
//  Created by 张青 on 2023/3/20.
//

#import "CanvasView.h"
#import "ZQUIBezierPath.h"


@interface CanvasView ()
@property (nonatomic, strong) NSMutableArray<ZQUIBezierPath*> *paths;
@end

@implementation CanvasView

- (NSMutableArray<ZQUIBezierPath *> *)paths{
    if(!_paths){
        _paths = [NSMutableArray array];
    }
    return _paths;
}


- (void)drawRect:(CGRect)rect{
    for(ZQUIBezierPath *path in self.paths){
        if(path.img){
            [path.img drawInRect:rect];
        }else {
            [path.color set];
            [path stroke];
        }
    }
}


- (void)clear{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)cancel{
    if(self.paths.count>0){
        [self.paths removeLastObject];
        [self setNeedsDisplay];
    }
}

- (void)eraser{
    self.pathColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ZQUIBezierPath * path = [ZQUIBezierPath bezierPath];
    UITouch *touch = touches.anyObject;
    CGPoint Point =  [touch locationInView:self];
    [path moveToPoint:Point];
    if(self.pathWidth<=0){
        self.pathWidth = 1;
    }
    path.color = self.pathColor;
    path.lineWidth = self.pathWidth;
    [self.paths addObject:path];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIBezierPath * path = [self.paths lastObject];
    UITouch *touch = touches.anyObject;
    CGPoint Point =  [touch locationInView:self];
    [path addLineToPoint:Point];
    [self setNeedsDisplay];
}

- (void)setImg:(UIImage *)img{
    _img = img;
    ZQUIBezierPath *path = [ZQUIBezierPath bezierPath];
    path.img = img;
    [self.paths addObject:path];
    [self setNeedsDisplay];
}
@end
