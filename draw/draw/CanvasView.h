//
//  CanvasView.h
//  draw
//
//  Created by 张青 on 2023/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CanvasView : UIView
@property (nonatomic, assign) CGFloat pathWidth;
@property (nonatomic, assign) UIColor *pathColor;
@property (nonatomic, strong)UIImage *img;
-(void)clear;
-(void)cancel;
-(void)eraser;
@end

NS_ASSUME_NONNULL_END
