//
//  AFParse.m
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFParser.h"
#import "DDFileReader.h"
#import "AFDay.h"
#import "NSDate+iso8601.h"
#import "Waste.h"

@implementation AFParser {
    NSMutableArray* _result;
    NSDate * _today;
}

- (BOOL) useNavigation;
{
    return false;
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

- (Waste*) detailsAt:(NSInteger) index;
{
    return [Waste new];
}

@end
