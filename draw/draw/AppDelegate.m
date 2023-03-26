//
//  AppDelegate.m
//  draw
//
//  Created by 张青 on 2023/3/19.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard *stortyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller = [stortyboard instantiateInitialViewController];
    self.window.rootViewController = controller;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
