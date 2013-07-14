//
//  AFParse.h
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFDay.h"

extern NSString * kUmido;
extern NSString * kSecco;
extern NSString * kPlastica;
extern NSString * kCarta;
extern NSString * kVetroAlluminio;
extern NSString * kIngombranti;
extern NSString * kLegnoFerro;
extern NSString * kOlioDomestico;

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

// badges
- (UIColor *) badgeColorAt:(NSInteger) index;
+ (UIColor *) badgeColorForWasteType:(NSString*) wasteType;
- (BOOL) isSomethingBeingCollectedAt:(NSInteger) index;

@end
