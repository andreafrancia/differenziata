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
    self = [super initWithStyle:UITableViewStylePlain];
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
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [hints letters];
}
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
    NSInteger section = indexPath.section;
    
    cell.textLabel.text  = [hints thingAt:index inSection:section];
    
    NSString * badgeText = [hints collectorAt:index inSection:section];
    cell.accessoryView = [helper badgeForWasteType:badgeText];
    
    return cell;
}


@end
