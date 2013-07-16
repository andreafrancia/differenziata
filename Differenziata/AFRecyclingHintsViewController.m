//
//  AFRecyclingHintsViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFRecyclingHintsViewController.h"
#import "AFCalendar.h"
#import "UIColor+MLPFlatColors.h"
#import "MLPAccessoryBadge.h"
#import "AFWasteTypePresenter.h"
#import "AFRecyclingHints.h"

@implementation AFRecyclingHintsViewController {
    AFRecyclingHints * hints;
    AFWasteTypePresenter * helper;
}

- (id)init
{
    self = [super init];
    if (self) {
        hints = [[AFRecyclingHints alloc] init];
        helper = [AFWasteTypePresenter new];
        [hints loadFromFile];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [hints numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [hints countInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
    NSInteger index = indexPath.row;
    
    cell.textLabel.text  = [hints thingAt:index inSection:indexPath.section];
    
    NSString * badgeText = [hints collectorTextAt:index];    
    cell.accessoryView = [helper badgeForWasteType:badgeText];
    
    return cell;
}


@end
