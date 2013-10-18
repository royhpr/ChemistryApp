//
//  Syllabus.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ElementModel.h"

@implementation ElementModel

-(id)initializeWithChapter: (NSString*)newChapter : (NSString*)newElementEnglish : (NSString*)newPhanetic : (NSString*)newElementChinese : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese : (NSString*)newSound
{
    if(self == [super init])
    {
        self.chapter = newChapter;
        self.elementEnglish = newElementEnglish;
        self.phanetic = newPhanetic;
        self.elementChinese = newElementChinese;
        self.pinyin = newPinyin;
        self.descriptionEnglish = newDescriptionEnglish;
        self.descriptionChinese = newDescriptionChinese;
        self.sound = newSound;
    }
    return self;
}

@end
