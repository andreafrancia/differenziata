//
//  NSDate+iso8601.m
//  Differenziata
//
//  Created by Andrea Francia on 6/27/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "NSDate+iso8601.h"

@implementation NSDate (iso8601)
- (NSString*) toIso8601 {
    NSDateFormatter * o = [NSDateFormatter new];
    [o setDateFormat:@"yyyy-MM-dd"];
    
    return [o stringFromDate:self];
}

+(NSDate*) fromIso8601:(NSString*) date{
    NSDateFormatter * f = [NSDateFormatter new];
    [f setDateFormat:@"yyyy-MM-dd"];
    return [f dateFromString:date];
}

@end
