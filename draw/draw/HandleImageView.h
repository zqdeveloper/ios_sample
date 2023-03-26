//
//  HandleImageView.h
//  draw
//
//  Created by 张青 on 2023/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HandleImageView;

@protocol HandleImageViewDelegete <NSObject>

-(void)HandleImageView:(HandleImageView*)handleImageView image:(UIImage*)image;

@end

@interface HandleImageView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id <HandleImageViewDelegete> delegete;
@end

NS_ASSUME_NONNULL_END
