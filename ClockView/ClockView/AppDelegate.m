//
//  AppDelegate.m
//  ClockView
//
//  Created by 张青 on 2023/3/22.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [storyboard instantiateInitialViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
