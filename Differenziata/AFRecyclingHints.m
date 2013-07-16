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
@interface AFHint:NSObject
@property(strong, nonatomic) NSString * thing;
@property(strong, nonatomic) NSString * collector;
@end
@implementation AFHint
-(id)initWithThing:(NSString*)thing collector:(NSString*)collector;
{
    if(self = [super init]) {
        self.thing = thing;
        self.collector = collector;
    }
    return self;
}
@end

@implementation AFRecyclingHints {
    NSMutableArray * letters;
    NSMutableDictionary * hintsByLetter;
}

-(id) init;
{
    if(self = [super init]) {
        letters = [NSMutableArray new];
        hintsByLetter = [NSMutableDictionary new];
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

- (NSString *)addLetterIfNeeded:(NSString *)thing
{
    NSString * letter = [thing substringToIndex:1];
    letter = [letter uppercaseString];
    if(! [letter isEqualToString:[self lastLetter]]) {
        [letters addObject:letter];
        hintsByLetter[letter] = [NSMutableArray new];
    }
    return letter;
}

-(void) parseLine:(NSString*)line;
{
    line = [self cleanUp:line];
    if([self lineShouldBeSkipped:line]) return;

    NSArray * split = [line componentsSeparatedByString:@","];
    NSString * thing = split[0];
    thing = [thing stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString * collector = [self normalizeCollector:split[1]];
    
    NSString * letter = [self addLetterIfNeeded:thing];
        
    AFHint * hint = [[AFHint alloc] initWithThing:thing collector:collector];
    [hintsByLetter[letter] addObject:hint];
}

-(NSString*)lastLetter
{
    if([letters count] > 0) {
        return letters[[letters count]-1];
    }
    return nil;
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

-(NSString*) collectorAt:(NSInteger)index inSection:(NSInteger)section;
{
    AFHint * hint = [self hintAtSection:section index:index];    
    return hint.collector;
}

- (AFHint *)hintAtSection:(NSInteger)section index:(NSInteger)index
{
    NSArray *hintsForThisLetter = [self hintsInSection:section];
    AFHint * hint = hintsForThisLetter[index];
    return hint;
}

- (NSArray *)hintsInSection:(NSInteger)section
{
    NSString * letter = letters[section];
    NSArray * hintsForThisLetter = hintsByLetter[letter];
    return hintsForThisLetter;
}

-(NSString*) thingAt:(NSInteger)index inSection:(NSInteger)section;
{
    AFHint * hint = [self hintAtSection:section index:index];
    return hint.thing;
}

-(NSInteger) countInSection:(NSInteger)section;
{
    return [[self hintsInSection:section] count];
}

-(NSInteger) numberOfSections;
{
    return [letters count];
}

-(NSArray*) letters;
{
    return [letters copy];
}

// TODO: duplicate
// put in a category of NSString
- (NSString*) pathTo:(NSString*)path;
{
    NSString * new = [[NSBundle mainBundle] pathForResource:path ofType:@""];
    return new;
}

@end
