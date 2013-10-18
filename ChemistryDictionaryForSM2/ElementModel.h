//
//  Syllabus.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElementModel : NSObject


@property(strong, readwrite) NSString* chapter;
@property(strong, readwrite) NSString* elementEnglish;
@property(strong, readwrite) NSString* phanetic;
@property(strong, readwrite) NSString* elementChinese;
@property(strong, readwrite) NSString* pinyin;
@property(strong, readwrite) NSString* descriptionEnglish;
@property(strong, readwrite) NSString* descriptionChinese;
@property(strong, readwrite) NSString* sound;

-(id)initializeWithChapter: (NSString*)newChapter : (NSString*)newElementEnglish : (NSString*)newPhanetic : (NSString*)newElementChinese : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese : (NSString*)newSound;
@end
