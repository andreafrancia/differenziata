//
//  AFViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFCalendarViewController.h"
#import "AFDetailsViewController.h"

#import "AFCalendar.h"
#import "AFDetails.h"

#import "AFWasteTypePresenter.h"
#import "AFCalendarPresenter.h"
#import "AFRecyclingHintsViewController.h"

#import "MLPAccessoryBadge.h"

@implementation AFCalendarViewController {
    AFCalendar * calendar;
}

-(id) init;
{
    self = [super initWithNibName:@"AFCalendarViewController" bundle:nil];
    if(self) {
        calendar = [[AFCalendar alloc] init];
        [calendar parseFile:[self pathTo:@"differenziata-calendario.csv"]];
    }
    return self;
}
- (NSString*) pathTo:(NSString*)path;
{
    return [[NSBundle mainBundle] pathForResource:path ofType:@""];
}

-(id)initWithCalendar:(AFCalendar *) aCalendar;
{
    self = [super initWithNibName:@"AFCalendarViewController" bundle:nil];
    if(self) {
        calendar = aCalendar;
    }
    return self;
}

-(void)viewDidLoad;
{
    UIBarButtonItem *todayButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"oggi"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(scrollToTodayRow)];
    self.navigationItem.leftBarButtonItem = todayButton;
    UIBarButtonItem *hintButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"dove lo butto?"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(showHints)];
    self.navigationItem.rightBarButtonItem = hintButton;
}

-(void) showHints
{
    AFRecyclingHintsViewController * hints;
    hints = [[AFRecyclingHintsViewController alloc] init];
    [self.navigationController pushViewController:hints animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    static BOOL first_time = YES;
    if(first_time) {
        [self scrollToTodayRow];
    }
    first_time = NO;
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
    [self.table selectRowAtIndexPath:indexPath animated:YES
                      scrollPosition:UITableViewScrollPositionTop];
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [calendar count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self makeCell:tableView];
    NSInteger index = indexPath.row;

    AFCalendarPresenter * presenter = [[AFCalendarPresenter alloc]init];
    presenter.calendar = calendar;
    cell.textLabel.text = [calendar humanDateAt:index];
    cell.accessoryView = [presenter badgeFor:index];

    return cell;
}

-(UITableViewCell*)makeCell:(UITableView *)tableView
{
    static NSString * identifier = @"cell-id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row;
    if([calendar hasDetailsAt:index]) {
        AFDetailsViewController * detailsViewController  = [[AFDetailsViewController alloc] init];
        detailsViewController.waste = [calendar detailsAt:index];
        
        [self.navigationController pushViewController:detailsViewController animated:YES];
    }
}

@end
