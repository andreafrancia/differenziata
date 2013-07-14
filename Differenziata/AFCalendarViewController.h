//
//  AFViewController.h
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AFCalendar;

@interface AFCalendarViewController : UIViewController<UITableViewDataSource,
                                               UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;
- (id) initWithCalendar:(AFCalendar *) calendar;
- (void) applicationWillEnterForeground:(UIApplication *)application;
@end
