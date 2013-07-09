//
//  AFParse.h
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFDay.h"

@class Waste;

@interface AFParser: NSObject

@property(readonly,nonatomic) NSArray* result;

-(void) parseLine:(NSString*)line;
-(void) parseFile:(NSString*) path;

- (void) todayIs:(NSDate*)date;
- (NSUInteger) todayIndex;

- (BOOL) useNavigation;
- (Waste*) detailsAt:(NSInteger) index;
@end
