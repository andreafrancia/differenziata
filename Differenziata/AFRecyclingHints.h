//
//  AFRecyclingHints.h
//  Differenziata
//
//  Created by Andrea Francia on 7/13/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFRecyclingHints : NSObject
-(void) loadFromFile;
-(void) parseLine:(NSString*)line;
-(NSInteger) count;
-(NSString*) thingAt:(NSInteger)index;
-(NSString*) collectorTextAt:(NSInteger)index;

-(NSString*) normalizeCollector:(NSString*) collector;
@end
