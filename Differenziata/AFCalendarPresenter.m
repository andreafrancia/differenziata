//
//  AFCalendarPresenter.m
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFCalendarPresenter.h"
#import "AFWasteTypePresenter.h"

@implementation AFCalendarPresenter
-(UIView *)badgeFor:(NSInteger) index;
{
    if([self.calendar isSomethingBeingCollectedAt:index]) {
        AFWasteTypePresenter * pres = [[AFWasteTypePresenter alloc] init];
        NSString * wasteType = [self.calendar wasteTypeAt:index];
        return [pres badgeForWasteType:wasteType];
    }
    return nil;
}

@end
