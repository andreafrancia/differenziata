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
    if([self lineShouldBeSkipped:line]) return;
    
    NSArray * split = [line componentsSeparatedByString:@","];
    NSString * thing = split[0];
    NSString * collector = [self normalizeCollector:split[1]];

    [things addObject:thing];
    [collectors addObject:collector];
}

-(BOOL) lineShouldBeSkipped:(NSString*) line
{
    return [line isEqualToString:@","];
}

-(NSString*) normalizeCollector:(NSString*) collector;
{
    if ([collector isEqualToString:@"secco indifferenziato"] )
        return kSecco;
    if ([collector isEqualToString:@"carta e cartone"])
        return kCarta;
    if ([collector isEqualToString:@"vetro e alluminio"])
        return kVetroAlluminio;
    if ([collector isEqualToString:@"legno e ferro"])
        return kLegnoFerro;
    if ([collector isEqualToString:@"contenitore c/o ambulatori medici"])
        return kMedicinaliScaduti;
    if ([collector isEqualToString:@"contenitori stradali gialli CARITAS"])
        return kIndumentiUsati;

    return collector;
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
