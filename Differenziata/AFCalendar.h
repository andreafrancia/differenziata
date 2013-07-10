//
//  AFParse.h
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFDay.h"

@class AFDetails;

@interface AFCalendar: NSObject

@property(readonly,nonatomic) NSArray* result;

- (NSInteger) count;
- (void) parseLine:(NSString*)line;
- (void) parseFile:(NSString*) path;

- (NSString*) humanDateAt:(NSInteger) index;
- (NSString*) wasteTypeAt:(NSInteger) index;

- (void) todayIs:(NSDate*)date;
- (NSUInteger) todayIndex;

- (AFDetails*) detailsAt:(NSInteger) index;
- (BOOL) hasDetailsAt:(NSInteger) index;
- (UIColor *) badgeColorAt:(NSInteger) index;
- (BOOL) isSomethingBeingCollectedAt:(NSInteger) index;

@end
