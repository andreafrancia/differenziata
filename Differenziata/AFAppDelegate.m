//
//  AFAppDelegate.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFAppDelegate.h"
#import "AFCalendarViewController.h"
#import "AFDetailsViewController.h"
#import "AFCalendar.h"

@interface AFAppDelegate ()
@end

@implementation AFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.window.rootViewController = [self makeCalendarViewController];

    [self.window makeKeyAndVisible];
    return YES;
}

-(UIViewController*) makeCalendarViewController;
{
    AFCalendarViewController *viewController;
    viewController = [[AFCalendarViewController alloc] init];
    UINavigationController * navigation = [[UINavigationController alloc]
                                           initWithRootViewController:viewController];    
    return navigation;
}

@end
