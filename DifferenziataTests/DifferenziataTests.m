//
//  DifferenziataTests.m
//  DifferenziataTests
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFCalendar.h"
#import "NSDate+iso8601.h"
#import <UIKit/UIKit.h>
#import "AFDetails.h"

#import <SenTestingKit/SenTestingKit.h>



@interface DifferenziataTests : SenTestCase
@end
@implementation DifferenziataTests {
    AFCalendar * calendar;
}

- (void)setUp
{
    calendar = [AFCalendar new];
}

- (void) test_details
{
    [calendar parseLine: @"2010-06-15,umido"];
    
    AFDetails * details = [calendar detailsAt:0];
    
    STAssertEqualObjects(@"umido", details.name, nil);
    STAssertEqualObjects(@"I rifiuti", [details.description substringToIndex:9], nil);
}

- (void) test_no_details
{
    [calendar parseLine: @"2010-06-15,"];
    
    BOOL result = [calendar hasDetailsAt:0];
    
    STAssertEquals(NO, result , nil);
}


- (void) test_details_present
{
    [calendar parseLine: @"2010-06-15,umido"];
    
    BOOL result = [calendar hasDetailsAt:0];
    
    STAssertEquals(YES, result , nil);
}


- (void) test_how_to_get_today_date
{
    NSDate * date = [NSDate fromIso8601:@"2013-09-08"];

    STAssertEqualObjects(@"2013-09-08", [date toIso8601], nil);
}

- (void) test
{
    [calendar todayIs:[NSDate fromIso8601:@"2010-06-15"]];
    [calendar parseLine: @"2010-06-13,umido"];
    [calendar parseLine: @"2010-06-15,sporco"];
    [calendar parseLine: @"2010-06-18,sporco"];

    NSInteger row = [calendar todayIndex];

    STAssertEquals(1, row, nil);
}

- (void) test_should_accept_comma_as_separator
{
    [calendar parseLine: @"2010-06-15,sporco"];

    AFDay * parsed = calendar.result[0];

    STAssertEqualObjects(@"2010-06-15", parsed.date, nil);
    STAssertEqualObjects(@"sporco",      parsed.what, nil);
}

- (void) test_should_read_from_a_csv_file
{
    [calendar parseFile: [self pathFor:@"calendario.csv"]];

    NSInteger dec31index = [calendar.result count] - 1;
    AFDay * dec31 = calendar.result[dec31index];

    STAssertEqualObjects(@"2013-12-31" , dec31.date, nil);
    STAssertEqualObjects(@"carta",       dec31.what, nil);
}

-(NSString*)pathFor:(NSString*)filename
{
    return [[NSBundle mainBundle] pathForResource:filename
                                           ofType:@""];
}

- (void) test_should_parse_multiple_lines
{
    [calendar parseLine: @"2013-07-15\tumido"];
    [calendar parseLine: @"2013-07-16\tsecco"];

    AFDay * first = calendar.result[0];
    AFDay * second = calendar.result[1];

    STAssertEqualObjects(@"2013-07-15", first.date, nil);
    STAssertEqualObjects(@"umido", first.what, nil);
    STAssertEqualObjects(@"2013-07-16", second.date, nil);
    STAssertEqualObjects(@"secco", second.what, nil);
}

- (void) test_should_render_human_readable_date
{
    [calendar parseLine:@"2010-06-08\tumido"];

    STAssertEqualObjects(@"8 giu 2010", [calendar humanDateAt:0], nil);
}


@end
