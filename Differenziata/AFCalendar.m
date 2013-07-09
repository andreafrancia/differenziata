//
//  AFParse.m
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFCalendar.h"
#import "DDFileReader.h"
#import "AFDay.h"
#import "NSDate+iso8601.h"
#import "AFDetails.h"

#import <UIKit/UIKit.h>
#import "UIColor+MLPFlatColors.h"

@implementation AFCalendar {
    NSMutableArray* _result;
    NSDate * _today;
}

- (void) todayIs:(NSDate*)date
{
    _today = date;
}

- (NSUInteger) todayIndex
{
    return [_result indexOfObjectPassingTest:
            ^BOOL(AFDay* day, NSUInteger idx, BOOL*stop)
    {
        return [day.date isEqualToString:[_today toIso8601]];
    }];
}

-(id) init
{
    if(self=[super init]) {
        _result = [NSMutableArray new];
    }
    return self;
}

-(NSInteger) indexOf:(NSDate*) date
{
    return 0;
}

-(void) parseLine:(NSString*)line
{
    AFDay * day = [AFDay new];
    
    line = [line stringByReplacingOccurrencesOfString:@"," withString:@"\t"];
    NSArray * split = [line componentsSeparatedByString:@"\t"];
    
    day.date = split[0];
    day.what = split[1];
    
    [_result addObject:day];
}

-(void) parseFile:(NSString*) path
{
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:path];
    
    NSString* line = nil;
    
    while ((line = [reader readLine])) {
        [self parseLine:line];
    }
}

- (AFDetails*) detailsAt:(NSInteger) index;
{
    AFDetails * details = [[AFDetails alloc] init];
    AFDay * day = self.result[index];
    details.badgeColor = [self badgeColorAt:index];
    details.name = day.what;
    details.description =@"quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta quello che si può buttare nella carta";
    return details;
}

- (BOOL) hasDetailsAt:(NSInteger) index;
{
    return ![[self typeAt:index] isEqualToString:@""];
}

-(NSString*) typeAt:(NSInteger) index;
{
    AFDay * day = self.result[index];
    return day.what;
}

- (UIColor *) badgeColorAt:(NSInteger) index;
{
    NSString * type = [self typeAt:index];
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
    UIColor * color = colors[type];
    return color;
}



@end
