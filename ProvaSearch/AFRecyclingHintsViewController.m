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

@interface AFRecyclingHints :NSObject

@end

@implementation AFRecyclingHints
-(NSString*) thingAt:(NSInteger)index;
{
    return @"Giornali";
}
-(NSString*)collectorAt:(NSInteger)index;
{
    return kSecco;
}
-(NSInteger) count;
{
    return 8;
}
@end

@interface AFRecyclingHintsViewController ()

@end

@implementation AFRecyclingHintsViewController {
    AFRecyclingHints * hints;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        hints = [[AFRecyclingHints alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.textLabel.text = [hints thingAt:indexPath.row];
    
    AFWasteTypePresenter * presenter = [AFWasteTypePresenter new];
    cell.accessoryView = [presenter badgeForWasteType:kSecco];
    
    return cell;
}


@end
