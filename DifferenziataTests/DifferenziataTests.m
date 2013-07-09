//
//  DifferenziataTests.m
//  DifferenziataTests
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "DifferenziataTests.h"
#import "AFCalendar.h"
#import "NSDate+iso8601.h"
#import <UIKit/UIKit.h>

@implementation DifferenziataTests {
    AFCalendar * parser;
}

- (void)setUp
{
    parser = [AFCalendar new];
}

- (void) test_how_to_get_today_date
{
    NSDate * date = [NSDate fromIso8601:@"2013-09-08"];

    STAssertEqualObjects(@"2013-09-08", [date toIso8601], nil);
}

- (void) test
{
    [parser todayIs:[NSDate fromIso8601:@"2010-06-15"]];
    [parser parseLine: @"2010-06-13,umido"];
    [parser parseLine: @"2010-06-15,sporco"];
    [parser parseLine: @"2010-06-18,sporco"];

    NSInteger row = [parser todayIndex];

    STAssertEquals(1, row, nil);
}

- (void) test_should_accept_comma_as_separator
{
    [parser parseLine: @"2010-06-15,sporco"];

    AFDay * parsed = parser.result[0];

    STAssertEqualObjects(@"2010-06-15", parsed.date, nil);
    STAssertEqualObjects(@"sporco",      parsed.what, nil);
}

- (void) test_should_read_from_a_csv_file
{
    [parser parseFile: [self pathFor:@"calendario.csv"]];

    NSInteger dec31index = [parser.result count] - 1;
    AFDay * dec31 = parser.result[dec31index];

    STAssertEqualObjects(@"2013-12-31" , dec31.date, nil);
    STAssertEqualObjects(@"carta",       dec31.what, nil);
}

-(NSString*)pathFor:(NSString*)filename
{
    return [[NSBundle mainBundle] pathForResource:filename
                                           ofType:@""];
}

- (void) test_should_parse_single_item
{
    [parser parseLine: @"2013-06-15\tumido"];

    AFDay * parsed = parser.result[0];

    STAssertEqualObjects(@"2013-06-15", parsed.date, nil);
    STAssertEqualObjects(@"umido",      parsed.what, nil);
}

- (void) test_should_parse_multiple_lines
{
    [parser parseLine: @"2013-07-15\tumido"];
    [parser parseLine: @"2013-07-16\tsecco"];

    AFDay * first = parser.result[0];
    AFDay * second = parser.result[1];

    STAssertEqualObjects(@"2013-07-15", first.date, nil);
    STAssertEqualObjects(@"umido", first.what, nil);
    STAssertEqualObjects(@"2013-07-16", second.date, nil);
    STAssertEqualObjects(@"secco", second.what, nil);
}

- (void) test_should_render_human_readable_date
{
    [parser parseLine:@"2010-06-08\tumido"];

    AFDay * day = parser.result[0];

    STAssertEqualObjects(@"8 giu 2010", day.humanDate, nil);
    STAssertEqualObjects(@"mar", day.weekDay, nil);
}


@end
