//
//  AFRecyclingHintsTests.m
//  Differenziata
//
//  Created by Andrea Francia on 7/13/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AFRecyclingHints.h"
#import "AFCalendar.h"

@interface AFRecyclingHintsTests : SenTestCase

@end

@implementation AFRecyclingHintsTests

-(void) test_should_parse_one_line
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];

    [hints parseLine: @"accendino (scarico),secco indifferenziato" ];

    NSString * thing = [hints thingAt:0];
    NSString * collectorText = [hints collectorTextAt:0];
    
    STAssertEqualObjects(thing,         @"accendino (scarico)", nil);
    STAssertEqualObjects(collectorText, kSecco, nil);
}

-(void) test_should_parse_multiple_lines
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];
    
    [hints parseLine: @"accendino (scarico),secco indifferenziato" ];
    [hints parseLine: @"agenda telefonica (in carta),carta e cartone" ];
        
    STAssertEqualObjects([hints thingAt:0],         @"accendino (scarico)", nil);
    STAssertEqualObjects([hints collectorTextAt:0], kSecco, nil);
    STAssertEqualObjects([hints thingAt:1],         @"agenda telefonica (in carta)", nil);
    STAssertEqualObjects([hints collectorTextAt:1], @"carta", nil);
}

-(void) test_should_ignore_empty_lines
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc]init];
    
    [hints parseLine:@","];
    
    STAssertEquals(0, [hints count],nil);
}

-(void) test_should_load_from_file;
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc]init];
    
    [hints loadFromFile];
    
    STAssertEqualObjects([hints thingAt:0], @"abbigliamento", nil);
    STAssertEqualObjects([hints collectorTextAt:0],
                         @"contenitori stradali gialli CARITAS",  nil);
}

@end
