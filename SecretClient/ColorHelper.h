//
//  ColorHelper.h
//  At
//
//  Created by Kwanghwi Kim on 3/4/15.
//  Copyright (c) 2015 Favorie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ColorHelper : NSObject

+ (UIColor *)colorWithIndex:(NSInteger)index;
+ (UIColor *)navigationBarColor;
+ (UIColor *)darkTextColor;
+ (UIColor *)selectedTabColor;
+ (UIColor *)unselectedTabColor;
+ (UIColor *)selectedTextColor;
+ (UIColor *)unselectedTextColor;
+ (UIColor *)placeHolderColor;
+ (UIColor *)colorViewContainerPopUpBackground;
+(UIColor *)colorButtonRestorePurchases;
+(UIColor *)colorButtonBuy;
+(UIColor *)colorButtonOK;
+ (UIColor *)colorViewEventBuyOneGetOneBackground;
+(UIColor *)colorGrayWith:(CGFloat)rgb;
+(NSArray *)colorsATTypeMenu;
+(UIColor *)colorBackgroundBright;
+(NSArray *)colorsRecipeMenu;
+(NSArray *)colorsATTypeMenuSub;
+(UIColor *)colorSelectWeekButtonBackground;
+(UIColor *)colorSelectedJumpToDate;
+(UIColor *)colorUnselectedJumpToDate;
+(UIColor *)colorNewAtDatePickerNavigationBar;
+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+(UIColor *)colorArchive;
+ (UIColor *)colorGrayWithIndex:(NSInteger)index;
+ (UIColor *)colorWithSentiment:(NSString *)sentiment;
+ (UIColor *)colorWithSentiment:(NSString *)sentiment andAlpha:(CGFloat)alpha;
@end
