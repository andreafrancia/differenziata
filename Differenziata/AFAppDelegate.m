//
//  AFAppDelegate.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFAppDelegate.h"
#import "AFViewController.h"
#import "AFDetailsViewController.h"
#import "AFCalendar.h"

@interface AFAppDelegate ()
@property (strong, nonatomic) AFViewController *viewController;
@property (strong, nonatomic) AFCalendar * parser;
@end

@implementation AFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    self.parser = [[AFCalendar alloc] init];
    [self.parser parseFile:[self pathTo:@"differenziata-calendario.csv"]];

    self.viewController = [[AFViewController alloc] initWithCalendar:self.parser];
    UINavigationController * navigation = [[UINavigationController alloc]
                                           initWithRootViewController:self.viewController];
    self.window.rootViewController = navigation;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // TODO: should this be handled in some willAppear or similar of the Controller.
    [self.viewController applicationWillEnterForeground:application];
}

- (NSString*) pathTo:(NSString*)path;
{
    return [[NSBundle mainBundle] pathForResource:path ofType:@""];
}

@end
