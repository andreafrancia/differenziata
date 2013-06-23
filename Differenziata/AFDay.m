//
//  AFDay.m
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFDay.h"

@implementation AFDay

-(NSString*) humanDate
{
    
    NSDateFormatter * f = [NSDateFormatter new];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate * d = [f dateFromString:self.date];
    
    NSDateFormatter * o = [NSDateFormatter new];
    [o setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"it_IT"]];
    [o setDateFormat:@"d MMM YYYY"];
    
    return [o stringFromDate:d];
}

@end
