//
//  ElementController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 23/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@protocol ElementDelegate <NSObject>

@required
-(void)returnToMainInterface;

@end

@interface ElementController : UIViewController

@property id<ElementDelegate> delegate;
@property(nonatomic,readwrite) NSString* currentTitle;
@property(nonatomic,readwrite) NSString* elementEnglish;
@property(nonatomic,readwrite) NSString* phanetic;
@property(nonatomic,readwrite) NSString* elementChinese;
@property(nonatomic,readwrite) NSString* pinyin;
@property(nonatomic,readwrite) NSString* descriptionEnglish;
@property(nonatomic,readwrite) NSString* descriptionChinese;

@property(strong,nonatomic) UILabel* elementInChinese;
@property(strong,nonatomic) UILabel* elementInEnglish;
@property(strong,nonatomic) UIImageView* sound;
@property(strong,nonatomic) UILabel* elementDescription;

-(void)setViewTitle:(NSString*)title;
-(void)setElementDetails:(NSString*)newElementEnglish : (NSString*)newElementChinese : (NSString*)newPhanetic : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese;

@end
