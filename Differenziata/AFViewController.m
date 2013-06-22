//
//  AFViewController.m
//  Differenziata
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFViewController.h"

@interface AFViewController ()

@end

@implementation AFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"def"];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"def"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"rifiuto %d",
                           indexPath.row];
    
    return cell;
}



@end
