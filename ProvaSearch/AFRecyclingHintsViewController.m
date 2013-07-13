//
//  AFRecyclingHintsViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFRecyclingHintsViewController.h"
#import "UIColor+MLPFlatColors.h"
#import "MLPAccessoryBadge.h"
#import "AFWasteTypePresenter.h"
#import "AFCalendar.h"
#import "AFRecyclingHints.h"

@implementation AFRecyclingHintsViewController {
    AFRecyclingHints * hints;
    AFWasteTypePresenter * helper;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        hints = [[AFRecyclingHints alloc] init];
        helper = [AFWasteTypePresenter new];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [hints loadFromFile];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
    NSInteger index = indexPath.row;
    
    cell.textLabel.text  = [hints thingAt:index];
    
    NSString * badgeText = [hints collectorTextAt:index];
    cell.accessoryView = [helper badgeForWasteType:badgeText];
    
    return cell;
}


@end
