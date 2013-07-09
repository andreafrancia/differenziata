//
//  AFViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFViewController.h"
#import "AFCalendar.h"
#import "UIColor+MLPFlatColors.h"
#import "AFDetailsViewController.h"
#import "AFDetails.h"

#import "MLPAccessoryBadge.h"

@interface AFViewController ()

@end

@implementation AFViewController {
    AFCalendar * calendar;
}

-(id) initWithCalendar:(AFCalendar *) aCalendar;
{
    self = [super initWithNibName:@"AFViewController" bundle:nil];
    if(self) {
        calendar = aCalendar;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self scrollToTodayRow];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self scrollToTodayRow];
}

- (void)scrollToTodayRow
{
    [calendar todayIs:[NSDate date]];
    NSInteger todayIndex = [calendar todayIndex];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:todayIndex
                                                 inSection:0];
    [self.table scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [calendar.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    AFDay * day = calendar.result[index];

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"acc"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"acc"];
    }
    
    cell.textLabel.text = day.humanDate;

    MLPAccessoryBadge *accessoryBadge = [MLPAccessoryBadge new];
    [accessoryBadge setText:day.what];

    [accessoryBadge setBackgroundColor:[calendar badgeColorAt:index]];
    if([day.what isEqualToString:@""]) {
        [cell setAccessoryView:nil];
    } else {
        [cell setAccessoryView:accessoryBadge];
    }

    return cell;
}

- (void) tableView:(UITableView *)tableView
 didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFDetailsViewController * detailsViewController;
    detailsViewController = [[AFDetailsViewController alloc] init];

    detailsViewController.waste = [calendar detailsAt:indexPath.row];

    [self.navigationController pushViewController:detailsViewController animated:YES];
}
@end
