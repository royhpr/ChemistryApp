//
//  Syllabus.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ElementModel.h"

@implementation ElementModel

/***Uncomment to display image****/
-(id)initializeWithChapter: (NSString*)newChapter : (NSString*)newElementEnglish : (NSString*)newPhanetic : (NSString*)newElementChinese : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese : (NSString*)newSound : (NSString*)newSketch
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
        self.sketch = newSketch;
    }
    return self;
}

@end
