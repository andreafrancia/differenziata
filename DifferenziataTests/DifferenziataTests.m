//
//  DifferenziataTests.m
//  DifferenziataTests
//
//  Created by Andrea Francia on 6/22/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "DifferenziataTests.h"
#import "AFParser.h"
#import <UIKit/UIKit.h>

@implementation DifferenziataTests {
    AFParser * parser;
}

- (void)setUp
{
    parser = [AFParser new];
}

- (void) test_should_read_from_a_file
{
    [parser parseFile: [self pathFor:@"calendario.txt"]];
    
    AFDay * sixth = parser.result[5];

    STAssertEqualObjects(@"2013-07-06", sixth.date, nil);
    STAssertEqualObjects(@"ingombranti", sixth.what, nil);
}

-(NSString*)pathFor:(NSString*)filename
{
    return [[NSBundle mainBundle] pathForResource:filename
                                           ofType:@""];
}

- (void) test_should_parse_single_item
{
    [parser parseLine: @"2013-06-15	umido"];

    AFDay * parsed = parser.result[0];
    
    STAssertEqualObjects(@"2013-06-15", parsed.date, nil);
    STAssertEqualObjects(@"umido",      parsed.what, nil);
}

- (void) test_should_parse_multiple_lines
{
    [parser parseLine: @"2013-07-15	umido"];
    [parser parseLine: @"2013-07-16	secco"];

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
}


@end
