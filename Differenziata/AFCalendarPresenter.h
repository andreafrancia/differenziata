//
//  AFCalendarPresenter.h
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFCalendar.h"

@interface AFCalendarPresenter : NSObject
@property(strong, nonatomic) AFCalendar* calendar;
-(UIView *)badgeFor:(NSInteger) index;
@end
