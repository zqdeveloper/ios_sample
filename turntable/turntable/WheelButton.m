//
//  WheelButton.m
//  turntable
//
//  Created by 张青 on 2023/3/27.
//

#import "WheelButton.h"

@implementation WheelButton


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
   CGRect rect =  CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5);
    
    if (CGRectContainsPoint(rect, point)) {
        //在指定的范围内
        return [super hitTest:point withEvent:event];
    }else {
        return nil;
    }
    
}


- (void)setHighlighted:(BOOL)highlighted{
    
}


//返回当前按钮当中Label的位置尺寸
//-(CGRect)titleRectForContentRect:(CGRect)contentRect {
//
//}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat w = 40;
    CGFloat h=  48;
    CGFloat x = (contentRect.size.width - w) * 0.5;
    CGFloat y = 20;
   
   return  CGRectMake(x, y, w, h);
}

@end
