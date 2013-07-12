//
//  AFAppDelegate.m
//  ProvaSearch
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFAppDelegate.h"
#import "AFRecyclingHintsViewController.h"

@implementation AFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.rootViewController = [[AFRecyclingHintsViewController alloc] init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
