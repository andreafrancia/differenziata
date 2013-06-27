//
//  NSDate+iso8601.h
//  Differenziata
//
//  Created by Andrea Francia on 6/27/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (iso8601)
- (NSString*) toIso8601;
+ (NSDate*) fromIso8601:(NSString*) date;
@end
