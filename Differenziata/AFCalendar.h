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
extern NSString * kNeonLampadine;
extern NSString * kPileEsaurite;
extern NSString * kMedicinaliScaduti;
extern NSString * kIndumentiUsati;
extern NSString * kElettrodomestici;
extern NSString * kPiazzolaEcologica;
extern NSString * kDittaSpecializzata;

@class AFDetails;

@interface AFCalendar: NSObject

@property(readonly,nonatomic) NSArray* result;

// file reading
- (void) parseLine:(NSString*)line;
- (void) parseFile:(NSString*) path;

// attribute for cell
- (NSString*) humanDateAt:(NSInteger) index;
- (NSString*) wasteTypeAt:(NSInteger) index;

// jump to today
- (NSUInteger) indexOfDay:(NSDate*)date;

// number of row
- (NSInteger) count;

// navigation to day details
- (AFDetails*) detailsAt:(NSInteger) index;

// badges
- (UIColor *) badgeColorAt:(NSInteger) index;
- (BOOL) isSomethingBeingCollectedAt:(NSInteger) index;
- (UIColor *) colorForCollector:(NSString*) collector;

@end
