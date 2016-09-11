//
//  ColorHelper.m
//  At
//
//  Created by Kwanghwi Kim on 3/4/15.
//  Copyright (c) 2015 Favorie. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+ (UIColor *)colorWithIndex:(NSInteger)index{
    
    index = index % 14;
    UIColor *color = nil;
    if (0==index) {
        color = [UIColor colorWithRed:171/255.f green:216/255.f blue:204/255.f alpha:1.0];
    } else if(1==index || 13==index){
        color = [UIColor colorWithRed:200/255.f green:220/255.f blue:200/255.f alpha:1.0];
    } else if(2==index || 12==index){
        color = [UIColor colorWithRed:223/255.f green:223/255.f blue:190/255.f alpha:1.0];
    } else if(3==index || 11==index){
        color = [UIColor colorWithRed:254/255.f green:225/255.f blue:161/255.f alpha:1.0];
    } else if(4==index || 10==index){
        color = [UIColor colorWithRed:247/255.f green:211/255.f blue:139/255.f alpha:1.0];
    } else if(5==index || 9==index){
        color = [UIColor colorWithRed:244/255.f green:185/255.f blue:140/255.f alpha:1.0];
    } else if(6==index || 8==index){
        color = [UIColor colorWithRed:242/255.f green:159/255.f blue:131/255.f alpha:1.0];
    } else if(7==index){
        color = [UIColor colorWithRed:237/255.f green:139/255.f blue:126/255.f alpha:1.0];
    } else {
        color = [UIColor whiteColor];
    }
    return color;
}

+ (UIColor *)colorGrayWithIndex:(NSInteger)index{
    
//    index = index % 14;
//    UIColor *color = nil;
//    if (0==index) {
//        color = [UIColor colorWithRed:171/255.f green:216/255.f blue:204/255.f alpha:1.0];
//    } else if(1==index || 13==index){
//        color = [UIColor colorWithRed:200/255.f green:220/255.f blue:200/255.f alpha:1.0];
//    } else if(2==index || 12==index){
//        color = [UIColor colorWithRed:223/255.f green:223/255.f blue:190/255.f alpha:1.0];
//    } else if(3==index || 11==index){
//        color = [UIColor colorWithRed:254/255.f green:225/255.f blue:161/255.f alpha:1.0];
//    } else if(4==index || 10==index){
//        color = [UIColor colorWithRed:247/255.f green:211/255.f blue:139/255.f alpha:1.0];
//    } else if(5==index || 9==index){
//        color = [UIColor colorWithRed:244/255.f green:185/255.f blue:140/255.f alpha:1.0];
//    } else if(6==index || 8==index){
//        color = [UIColor colorWithRed:242/255.f green:159/255.f blue:131/255.f alpha:1.0];
//    } else if(7==index){
//        color = [UIColor colorWithRed:237/255.f green:139/255.f blue:126/255.f alpha:1.0];
//    } else {
//        color = [UIColor whiteColor];
//    }
    UIColor *color = [UIColor lightGrayColor];
    return color;
}

+ (UIColor *)navigationBarColor{
    return [UIColor colorWithRed:230/255.f green:75/255.f blue:85/255.f alpha:1.0];
}

+ (UIColor *)darkTextColor{
    return [UIColor colorWithRed:90/255.f green:90/255.f blue:90/255.f alpha:1.0];
}


+ (UIColor *)selectedTabColor{
    return [UIColor colorWithRed:245/255.f green:225/255.f blue:150/255.f alpha:1.0];
}
+ (UIColor *)unselectedTabColor{
    return [UIColor colorWithRed:240/255.f green:215/255.f blue:130/255.f alpha:1.0];
}
+ (UIColor *)selectedTextColor{
    return [UIColor colorWithRed:230/255.f green:75/255.f blue:85/255.f alpha:1.0];
}
+ (UIColor *)unselectedTextColor{
    return [UIColor colorWithRed:90/255.f green:90/255.f blue:90/255.f alpha:1.0];
}
+ (UIColor *)placeHolderColor{
    return [UIColor colorWithRed:201/255.f green:183/255.f blue:130/255.f alpha:1.0];
}

+ (UIColor *)colorViewContainerPopUpBackground{
    return [UIColor colorWithRed:244/255.f green:223/255.f blue:186/255.f alpha:1.0];
}
+(UIColor *)colorButtonRestorePurchases{
    return [self colorViewContainerPopUpBackground];
}
+ (UIColor *)colorViewEventBuyOneGetOneBackground{
    return [UIColor colorWithRed:171/255.f green:216/255.f blue:204/255.f alpha:1.0];
}
+(UIColor *)colorButtonBuy{
//    return [UIColor colorWithRed:15/255.f green:150/255.f blue:180/255.f alpha:1.0];
    return [self navigationBarColor];
}
+(UIColor *)colorButtonOK{
//    return [UIColor colorWithRed:239/255.f green:132/255.f blue:111/255.f alpha:1.0];
    return [self navigationBarColor];
}
+(UIColor *)colorGrayWith:(CGFloat)rgb{
    return [UIColor colorWithRed:rgb/255.f green:rgb/255.f blue:rgb/255.f alpha:1.0];
}

+(NSArray *)colorsATTypeMenu{
    return @[[UIColor colorWithRed:171/255.f green:216/255.f blue:204/255.f alpha:1.0],
             [UIColor colorWithRed:254/255.f green:225/255.f blue:161/255.f alpha:1.0],
             [UIColor colorWithRed:244/255.f green:185/255.f blue:140/255.f alpha:1.0],
             [UIColor colorWithRed:242/255.f green:159/255.f blue:131/255.f alpha:1.0]];
}

+(NSArray *)colorsATTypeMenuSub{
    return @[[UIColor colorWithRed:113/255.f green:170/255.f blue:153/255.f alpha:1.0],
             [UIColor colorWithRed:226/255.f green:170/255.f blue:71/255.f alpha:1.0],
             [UIColor colorWithRed:211/255.f green:126/255.f blue:68/255.f alpha:1.0],
             [UIColor colorWithRed:209/255.f green:102/255.f blue:78/255.f alpha:1.0]];
}
+(NSArray *)colorsRecipeMenu{
    return @[[UIColor colorWithRed:60/255.f green:110/255.f blue:190/255.f alpha:1.0],
             [UIColor colorWithRed:245/255.f green:190/255.f blue:40/255.f alpha:1.0],
             [UIColor colorWithRed:235/255.f green:110/255.f blue:120/255.f alpha:1.0],
             [UIColor colorWithRed:90/255.f green:200/255.f blue:195/255.f alpha:1.0],
             [UIColor colorWithRed:250/255.f green:120/255.f blue:55/255.f alpha:1.0],
             [UIColor colorWithRed:105/255.f green:160/255.f blue:75/255.f alpha:1.0],
             [UIColor colorWithRed:125/255.f green:200/255.f blue:230/255.f alpha:1.0],
             [UIColor colorWithRed:245/255.f green:215/255.f blue:125/255.f alpha:1.0],
             [UIColor colorWithRed:250/255.f green:140/255.f blue:100/255.f alpha:1.0],
             [UIColor colorWithRed:125/255.f green:125/255.f blue:200/255.f alpha:1.0]];
}

+(UIColor *)colorBackgroundBright{
    return [UIColor colorWithRed:250/255.f green:240/255.f blue:225/255.f alpha:1.0];
}


+(UIColor *)colorSelectWeekButtonBackground{
    return [UIColor colorWithRed:245/255.f green:225/255.f blue:150/255.f alpha:1.0];
}

+ (UIColor *)colorSelectedJumpToDate{
    return [UIColor colorWithRed:112/255.f green:188/255.f blue:196/255.f alpha:1.0];
}
+ (UIColor *)colorUnselectedJumpToDate{
    return [UIColor colorWithRed:33/255.f green:36/255.f blue:50/255.f alpha:1.0];
}
+ (UIColor *)colorNewAtDatePickerNavigationBar{
    return [UIColor colorWithRed:237/255.f green:139/255.f blue:126/255.f alpha:1.0];
}
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue{
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.0];
}

+(UIColor *)colorArchive{
    return [self colorWithRed:243 green:189 blue:41];
}

+ (UIColor *)colorWithSentiment:(NSString *)sentiment{
    if ([sentiment isEqualToString:@"Excited"]) {
        return [UIColor colorWithRed:241/255.f green:102/255.f blue:99/255.f alpha:1.0];
    } else if ([sentiment isEqualToString:@"anger"]) {
        return [UIColor colorWithRed:244/255.f green:141/255.f blue:108/255.f alpha:1.0];
    } else if ([sentiment isEqualToString:@"joy"]) {
        return [UIColor colorWithRed:223/255.f green:204/255.f blue:96/255.f alpha:1.0];
    } else if ([sentiment isEqualToString:@"disappointed"]) {
        return [UIColor colorWithRed:138/255.f green:190/255.f blue:155/255.f alpha:1.0];
    }else {
        return [UIColor colorWithRed:74/255.f green:109/255.f blue:139/255.f alpha:1.0];
    }
}

+ (UIColor *)colorWithSentiment:(NSString *)sentiment andAlpha:(CGFloat)alpha{
    if ([sentiment isEqualToString:@"Excited"]) {
        return [UIColor colorWithRed:241/255.f green:102/255.f blue:99/255.f alpha:alpha];
    } else if ([sentiment isEqualToString:@"anger"]) {
        return [UIColor colorWithRed:244/255.f green:141/255.f blue:108/255.f alpha:alpha];
    } else if ([sentiment isEqualToString:@"joy"]) {
        return [UIColor colorWithRed:223/255.f green:204/255.f blue:96/255.f alpha:alpha];
    } else if ([sentiment isEqualToString:@"disappointed"]) {
        return [UIColor colorWithRed:138/255.f green:190/255.f blue:155/255.f alpha:alpha];
    }else {
        return [UIColor colorWithRed:74/255.f green:109/255.f blue:139/255.f alpha:alpha];
    }
}
@end
