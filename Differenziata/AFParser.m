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

@implementation AFParser {
    NSMutableArray* _result;
}

-(id) init
{
    if(self=[super init]) {
        _result = [NSMutableArray new];
    }
    return self;
}

-(void) parseLine:(NSString*)line
{
    AFDay * day = [AFDay new];
    
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

@end
