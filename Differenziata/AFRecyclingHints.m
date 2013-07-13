//
//  AFRecyclingHints.m
//  Differenziata
//
//  Created by Andrea Francia on 7/13/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFRecyclingHints.h"

#import "AFCalendar.h"

@implementation AFRecyclingHints
-(void) loadFromFile;
{
    
}
-(NSString*) collectorTextAt:(NSInteger)index;
{
    return @"raccoglitorie batterie";
}
-(NSString*) thingAt:(NSInteger)index;
{
    return @"Giornali";
}
-(NSString*)collectorAt:(NSInteger)index;
{
    return kSecco;
}
-(NSInteger) count;
{
    return 8;
}
@end
