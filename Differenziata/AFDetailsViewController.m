//
//  AFWasteDescriptionViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 7/9/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFDetailsViewController.h"
#import "AFDetails.h"
#import "UIColor+MLPFlatColors.h"

@interface AFDetailsViewController ()
@end

@implementation AFDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

static NSString *WasteTypeCellIdentifier = @"Type";
static NSString *WasteDescriptionCellIdentifier = @"Desc";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor flatWhiteColor];
        cell.backgroundColor = self.waste.badgeColor;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;

    if(indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:WasteTypeCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:WasteTypeCellIdentifier];
        }

        cell.textLabel.text = self.waste.name;
    } else {

        cell = [tableView dequeueReusableCellWithIdentifier:WasteDescriptionCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:WasteDescriptionCellIdentifier];
        }

        {
            UITextView *text = [[UITextView alloc] init];
            CGSize size = [self descriptionSize];
            text.frame = CGRectMake(cell.frame.origin.x + 20,
                                    cell.frame.origin.y,
                                    cell.frame.size.width - 40,
                                    size.height + 30);
            text.text = self.waste.description;
            text.editable = NO;
            text.scrollEnabled = NO;

            [cell.contentView addSubview:text];

        }
    }

    return cell;
}

-(CGSize) descriptionSize;
{
    return [self.waste.description sizeWithFont:[self descriptionFont]
                   constrainedToSize:CGSizeMake(self.tableView.frame.size.width - 40, 999)
                       lineBreakMode:NSLineBreakByWordWrapping];

}
-(UIFont*) descriptionFont;
{
    return [[UITextView alloc] init].font;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    if (indexPath.row == 1)
        return [self descriptionSize].height;
    return 0;
}

@end
