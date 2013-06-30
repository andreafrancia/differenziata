//
//  AFViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFViewController.h"
#import "AFParser.h"
#import "MLPAccessoryBadge.h"
#import "UIColor+MLPFlatColors.h"

@interface AFViewController ()

@end

@implementation AFViewController {
    AFParser * parser;
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
    [parser todayIs:[NSDate date]];
    NSInteger todayIndex = [parser todayIndex];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:todayIndex
                                                 inSection:0];
    [self.table scrollToRowAtIndexPath:indexPath
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    parser = [AFParser new];
    [parser parseFile:[[NSBundle mainBundle] pathForResource:@"calendario.csv"
                                                     ofType:@""]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [parser.result count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AFDay * day = parser.result[indexPath.row];


    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"acc"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"acc"];
    }
    
    cell.textLabel.text = day.humanDate;

    MLPAccessoryBadge *accessoryBadge = [MLPAccessoryBadge new];
    [accessoryBadge setText:day.what];

    NSDictionary * colors = @{
                             @"umido": [UIColor flatGreenColor],
                             @"carta": [UIColor flatRedColor],
                             @"secco": [UIColor flatYellowColor],
                             @"ingombranti": [UIColor flatDarkWhiteColor],
                             @"plastica": [UIColor flatOrangeColor],
                             @"vetro - alluminio": [UIColor flatBlueColor],
                             @"legno - ferro": [UIColor flatTealColor],
                             @"olio domestico": [UIColor flatDarkTealColor],
                            };

    UIColor * color = colors[day.what];
    [accessoryBadge setBackgroundColor:color];
    if([day.what isEqualToString:@""]) {
        [cell setAccessoryView:nil];
    } else {
        [cell setAccessoryView:accessoryBadge];
    }

    return cell;
}

#pragma mark Disable selection
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
