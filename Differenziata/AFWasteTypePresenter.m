//
//  AFWasteTypePresenter.m
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFWasteTypePresenter.h"
#import "MLPAccessoryBadge.h"
#import "UIColor+MLPFlatColors.h"
#import "AFCalendar.h"

@implementation AFWasteTypePresenter

- (UIColor *) wasteTypeColor:(NSString*) wasteType;
{
    return @{
             kUmido: [UIColor flatGreenColor],
             kSecco: [UIColor flatYellowColor],
             kPlastica: [UIColor flatOrangeColor],
             kCarta: [UIColor flatRedColor],
             kVetroAlluminio: [UIColor flatBlueColor],
             kIngombranti: [UIColor flatDarkWhiteColor],
             kLegnoFerro: [UIColor flatDarkOrangeColor],
             kOlioDomestico: [UIColor flatDarkTealColor],
             }[wasteType];
}

- (UIView*)badgeForWasteType:(NSString *)wasteType;
{
    return [self badgeWithText:wasteType
                         color:[self wasteTypeColor:wasteType]];
}

- (UIView*)badgeWithText:(NSString *)wasteType color:(UIColor*)color;
{
    MLPAccessoryBadge *accessoryBadge = [MLPAccessoryBadge new];
    [accessoryBadge setText:wasteType];
    [accessoryBadge setBackgroundColor:color];
    return accessoryBadge;
}

@end
