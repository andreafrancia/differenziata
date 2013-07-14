//
//  AFRecyclingHints.m
//  Differenziata
//
//  Created by Andrea Francia on 7/13/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFRecyclingHints.h"

#import "AFCalendar.h"
#import "DDFileReader.h"

@implementation AFRecyclingHints {
    NSMutableArray * things;
    NSMutableArray * collectors;
}
-(id) init;
{
    if(self = [super init]) {
        things = [[NSMutableArray alloc]init];
        collectors = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void) loadFromFile;
{
    NSString * path = [self pathTo:@"differenziata-dove-va-cosa.csv"];
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:path];
    
    NSString* line = nil;
    
    while ((line = [reader readLine])) {
        [self parseLine:line];
    }
}
-(void) parseLine:(NSString*)line;
{
    line = [self cleanUp:line];
    NSArray * split = [line componentsSeparatedByString:@","];
    
    NSString * thing = split[0];
    NSString * collector = split[1];

    if ([collector isEqualToString:@"secco indifferenziato"] ) {
        collector = kSecco;
    } else if([collector isEqualToString:@"carta e cartone"]) {
        collector = kCarta;
    }
    
    [things addObject:thing];
    [collectors addObject:collector];
}

-(NSString*) cleanUp:(NSString*) line;
{
    line = [line stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    line = [line stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return line;
}

-(NSString*) collectorTextAt:(NSInteger)index;
{
    return collectors[index];
}
-(NSString*) thingAt:(NSInteger)index;
{
    return things[index];
}

-(NSString*)collectorAt:(NSInteger)index;
{
    return kSecco;
}
-(NSInteger) count;
{
    return [things count];
}

// TODO: duplicate
// put in a category of NSString
- (NSString*) pathTo:(NSString*)path;
{
    NSString * new = [[NSBundle mainBundle] pathForResource:path ofType:@""];
    return new;
}

@end
