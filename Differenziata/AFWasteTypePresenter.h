//
//  AFWasteTypePresenter.h
//  Differenziata
//
//  Created by Andrea Francia on 7/12/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFWasteTypePresenter : NSObject
- (UIColor *) wasteTypeColor:(NSString*) wasteType;
- (UIView*)badgeForWasteType:(NSString *)wasteType;
- (UIView*)badgeWithText:(NSString *)wasteType color:(UIColor*)color;
@end
