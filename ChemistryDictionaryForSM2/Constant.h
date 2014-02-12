//
//  Constant.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 20/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <Foundation/Foundation.h>

//Front page
extern NSString* TITLE_LOGO;
extern NSString* NUS_LOGO;


//Instruction page
extern NSString* INSTRUCTION_IMAGE;
//extern NSString* CHINESE_VERSION;
//extern NSString* CONTRIBUTORS;


//Main interface
extern NSString* PERIODIC_IMAGE;
extern NSString* SYLLUBAS_IMAGE;
extern NSString* SEARCH_DIC_IMAGE;
extern NSString* QUIZ_IMAGE;

extern float TITLE_WIDTH;
extern float TITLE_HEIGHT;
extern float ELEMENT_DESCRIP_WIDTH_PERIODIC;

extern NSString* PERIODIC_LABEL;
extern NSString* SYLLABUS_LABEL;
extern NSString* SEARCH_DIC_LABEL;
extern NSString* QUIZ_LABEL;


//Chapter
extern NSString* CHAPTER_1;
extern NSString* CHAPTER_2;
extern NSString* CHAPTER_3;
extern NSString* CHAPTER_4;
extern NSString* CHAPTER_5;
extern NSString* CHAPTER_6;
extern NSString* CHAPTER_7;
extern NSString* CHAPTER_8;
extern NSString* CHAPTER_9;
extern NSString* CHAPTER_10;
extern NSString* CHAPTER_11;
extern NSString* CHAPTER_12;
extern NSString* CHAPTER_13;
extern NSString* CHAPTER_14;
extern NSString* CHAPTER_15;
extern NSString* CHAPTER_16;
extern NSString* CHAPTER_17;

//Element
extern float ELEMENT_WIDTH;
extern float ELEMENT_HEIGHT;
extern float ELEMENT_START_POSITION_X;
extern float ELEMENT_START_POSITION_Y;
extern float ELEMENT_COMPONENT_GAP;
extern NSString* NEW_LINE;
extern float SCALE_DOWN_FACTOR;
extern NSString* APP_FONT;
extern float ELEMENT_VIEW_BODY_FONT_SIZE;
extern float ELEMENT_DESCRIP_WIDTH;
extern float ELEMENT_DESCRIP_HEIGHT;

//Quiz
extern NSString* PERIODIC_ELEMENT_INDICATOR;


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface Constant : NSObject


@end
