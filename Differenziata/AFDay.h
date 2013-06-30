//
//  AFDay.h
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFDay : NSMutableDictionary
@property(strong, nonatomic) NSString * date;
@property(strong, nonatomic) NSString * what;
-(NSString*) humanDate;
-(NSString*) weekDay;
@end
