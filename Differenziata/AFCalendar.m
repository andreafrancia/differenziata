//
//  AFParse.m
//  Differenziata
//
//  Created by Andrea Francia on 6/23/13.
//  Copyright (c) 2013 Andrea Francia. All rights reserved.
//

#import "AFCalendar.h"
#import "DDFileReader.h"
#import "AFDay.h"
#import "NSDate+iso8601.h"
#import "AFDetails.h"

#import <UIKit/UIKit.h>
#import "UIColor+MLPFlatColors.h"

static NSString * kUmido = @"umido";
static NSString * kSecco = @"secco";
static NSString * kPlastica = @"plastica";
static NSString * kCarta = @"carta";
static NSString * kVetroAlluminio = @"vetro - alluminio";
static NSString * kIngombranti = @"ingombranti";
static NSString * kLegnoFerro = @"legno - ferro";
static NSString * kOlioDomestico = @"olio domestico";

static NSString * kDescription = @"description";

@implementation AFCalendar {
    NSMutableArray* _result;
    NSDate * _today;
    NSDictionary * _wasteTypes;
}

- (void) todayIs:(NSDate*)date
{
    _today = date;
}

- (NSUInteger) todayIndex
{
    return [_result indexOfObjectPassingTest:
            ^BOOL(AFDay* day, NSUInteger idx, BOOL*stop)
    {
        return [day.date isEqualToString:[_today toIso8601]];
    }];
}

-(id) init
{
    if(self=[super init]) {
        _result = [NSMutableArray new];
        _wasteTypes =
        @{
          kUmido: @"I rifiuti umidi sono scarti alimentari e organici come ossi, avanzi di carte, bucce e scarti di verdure e frutta fresca e secca, gusci di uova, fondi di caffè, the e tisane, avanzi di pane, pasta, riso, farine, resti di pulitura di pesci e polli, escrementi di animali domestici",
          kSecco: @"I rifiuti secchi sono carte sporche, oggetti di porcellana, ceramica, terracotta, contenitori di cartone per latte e succhi di frutta, assorbenti igenici e pannolini, lettiere per gatti, rasoi usa e getta, guarnizioni in gomma, musicassette, videocassette, stracci unti e sporchi, vaschette di polistirolo, giocattoli",
          kPlastica: @"Gli oggetti di plastica quali tappi, bottiglie d'acqua o di bibite senza tappo e ben schiacciate per far sì che occupino meno spazio, flaconi di prodotti per la casa, di bellezza, di detersivi e detergenti, vaschette per alimenti e vasetti di yogurt ben lavati e privi di residui.",
          kCarta: @"La carta pulita: giornali, riviste, sacchetti e buste di carta, scatole di cartone aperte e ripiegate, ben avvolti e senza buste di plastica.",
          kVetroAlluminio: @"Tutti gli oggetti di vetro (bottiglie e vasetti), scatole di tonno, piselli, pelati, ecc. ben lavati e privi di residui, lattine di alluminio, tappi in metallo e barattoli.",
          kIngombranti: @"I materiali o gli oggetti non in legno o in ferro oppure misti: quali divani, poltrone imbottite, mobili non in legno né in metallo, materassi, giocattoli voluminosi, oggetti in ceramica o in terracotta di grandi dimensioni, tappeti, tendaggi.",
          kLegnoFerro: @"Il ferro ed il legno: mobili, serramenti, arredi metallici, canali di gronda, pentole, recipienti di metallo o di legno di grandi dimensioni, finestre in legno",
          kOlioDomestico: @"Tutti gli oli ed i grassi di cottura e di frittura domestici, da versare nell'aposito contenitore verde con imbuto annesso.",
          };

    }
    return self;
}

-(NSInteger) indexOf:(NSDate*) date
{
    return 0;
}

-(void) parseLine:(NSString*)line
{
    AFDay * day = [AFDay new];
    
    line = [line stringByReplacingOccurrencesOfString:@"," withString:@"\t"];
    NSArray * split = [line componentsSeparatedByString:@"\t"];
    
    day.date = split[0];
    day.what = split[1];
    
    [_result addObject:day];
}

-(void) parseFile:(NSString*) path
{
    DDFileReader * reader = [[DDFileReader alloc] initWithFilePath:path];
    
    NSString* line = nil;
    
    while ((line = [reader readLine])) {
        [self parseLine:line];
    }
}

- (AFDetails*) detailsAt:(NSInteger) index;
{
    AFDetails * details = [[AFDetails alloc] init];
    AFDay * day = self.result[index];
    details.badgeColor = [self badgeColorAt:index];
    details.name = day.what;
    details.description = _wasteTypes[day.what];
    
    return details;
}

- (BOOL) hasDetailsAt:(NSInteger) index;
{
    return ![[self typeAt:index] isEqualToString:@""];
}

-(NSString*) typeAt:(NSInteger) index;
{
    AFDay * day = self.result[index];
    return day.what;
}

- (UIColor *) badgeColorAt:(NSInteger) index;
{
    NSString * type = [self typeAt:index];
    NSDictionary * colors = @{
                              kUmido: [UIColor flatGreenColor],
                              kSecco: [UIColor flatYellowColor],
                              kPlastica: [UIColor flatOrangeColor],
                              kCarta: [UIColor flatRedColor],
                              kVetroAlluminio: [UIColor flatBlueColor],
                              kIngombranti: [UIColor flatDarkWhiteColor],
                              kLegnoFerro: [UIColor flatDarkOrangeColor],
                              kOlioDomestico: [UIColor flatDarkTealColor],
                              };
    UIColor * color = colors[type];
    return color;
}



@end
