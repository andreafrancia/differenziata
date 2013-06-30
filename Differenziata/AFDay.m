//
//  AFDay.m
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFDay.h"
#import "NSDate+iso8601.h"

@implementation AFDay

-(NSString*) weekDay
{
    return [self formatDateWith:@"EEE"];
}

-(NSString*) humanDate
{
    return [self formatDateWith:@"d MMM YYYY"];
}

-(NSDate*) asDate
{
    return [NSDate fromIso8601:self.date];
}

-(NSString*) formatDateWith:(NSString*)format
{
    NSDate * d = [self asDate];

    NSDateFormatter * o = [NSDateFormatter new];
    [o setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"]];
    [o setDateFormat:format];
    
    return [o stringFromDate:d];

}

@end
