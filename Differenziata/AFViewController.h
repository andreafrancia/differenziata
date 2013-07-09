//
//  AFViewController.h
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFParser;

@interface AFViewController : UIViewController<UITableViewDataSource,
                                               UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;
- (id) initWithCalendar:(AFParser *) calendar;
- (void) applicationWillEnterForeground:(UIApplication *)application;
@end
