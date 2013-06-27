//
//  AFViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFViewController.h"
#import "AFParser.h"
#import "AFDayCell.h"

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

    UINib * nib = [UINib nibWithNibName:@"AFDayCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:@"day"];
    
    AFDayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"day"];
    
    cell.dateLabel.text = day.humanDate;
    cell.kindLabel.text = day.what;
    
    NSDictionary * colors = @{
                             @"umido": [UIColor greenColor],
                             @"carta": [UIColor magentaColor],
                             @"secco": [UIColor yellowColor],
                             @"ingombranti": [UIColor lightGrayColor],
                             @"plastica": [UIColor redColor],
                             @"vetro - alluminio": [UIColor cyanColor],
                             @"legno - ferro": [UIColor brownColor],
                             @"olio domestico": [UIColor orangeColor],
                            };
    cell.kindLabel.backgroundColor = colors[day.what];
    return cell;
}

#pragma mark Disable selection
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


@end
