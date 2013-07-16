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

-(void) test_should_have_one_section_for_each_initial_letter
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];

    [hints parseLine: @"accendino, secco"];
    [hints parseLine: @"budino, secco"];
    
    STAssertEquals(2, [hints numberOfSections], nil);
}

-(void) test_should_have_one_section_when_two_thing_with_same_initial
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];
    
    [hints parseLine: @"accendino, secco"];
    [hints parseLine: @"acciarino, secco"];
    
    STAssertEquals(1, [hints numberOfSections], nil);
}

-(void) test_should_parse_one_line
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];

    [hints parseLine: @"accendino (scarico),secco indifferenziato" ];

    NSString * thing = [hints thingAt:0 inSection:0];
    NSString * collectorText = [hints collectorAt:0 inSection:0];
    
    STAssertEqualObjects(thing,         @"accendino (scarico)", nil);
    STAssertEqualObjects(collectorText, kSecco, nil);
}

-(void) test_should_parse_multiple_lines
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];
    
    [hints parseLine: @"accendino (scarico),secco indifferenziato" ];
    [hints parseLine: @"agenda telefonica (in carta),carta e cartone" ];
        
    STAssertEqualObjects([hints thingAt:0     inSection:0], @"accendino (scarico)", nil);
    STAssertEqualObjects([hints collectorAt:0 inSection:0], kSecco, nil);
    STAssertEqualObjects([hints thingAt:1     inSection:0], @"agenda telefonica (in carta)", nil);
    STAssertEqualObjects([hints collectorAt:1 inSection:0], @"carta", nil);
}

-(void) test_should_put_word_in_different_sections
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc] init];
    
    [hints parseLine: @"accendino,111" ];
    [hints parseLine: @"agenda,222" ];
    [hints parseLine: @"budino,333" ];
    
    STAssertEqualObjects([hints thingAt:0 inSection:0], @"accendino", nil);
    STAssertEqualObjects([hints thingAt:1 inSection:0], @"agenda", nil);
    STAssertEqualObjects([hints thingAt:0 inSection:1], @"budino", nil);
    
    STAssertEqualObjects([hints collectorAt:0 inSection:0], @"111", nil);
    STAssertEqualObjects([hints collectorAt:1 inSection:0], @"222", nil);
    STAssertEqualObjects([hints collectorAt:0 inSection:1], @"333", nil);
    
    STAssertEquals(2, [hints countInSection:0], nil);
}

-(void) test_should_ignore_empty_lines
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc]init];
    
    [hints parseLine:@","];
    
    STAssertEquals(0, [hints numberOfSections],nil);
}

-(void) test_should_load_from_file;
{
    AFRecyclingHints * hints = [[AFRecyclingHints alloc]init];
    
    [hints loadFromFile];
    
    STAssertEqualObjects([hints thingAt:0     inSection:0], @"abbigliamento", nil);
    STAssertEqualObjects([hints collectorAt:0 inSection:0], kIndumentiUsati,  nil);
}

@end
