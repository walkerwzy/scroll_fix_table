//
//  AppDelegate.m
//  TableDemo
//
//  Created by 杨沛 on 2022/1/22.
//

#import "AppDelegate.h"
#import "ContainerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [ContainerViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
