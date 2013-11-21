//
//  ElementController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 23/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Constant.h"

@protocol ElementDelegate <NSObject>

@required
-(void)returnToMainInterface;

@end

@interface ElementController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property id<ElementDelegate> delegate;
@property(nonatomic,readwrite) NSString* currentTitle;
@property(nonatomic,readwrite) NSString* elementEnglish;
@property(nonatomic,readwrite) NSString* phanetic;
@property(nonatomic,readwrite) NSString* elementChinese;
@property(nonatomic,readwrite) NSString* pinyin;
@property(nonatomic,readwrite) NSString* descriptionEnglish;
@property(nonatomic,readwrite) NSString* descriptionChinese;
@property(nonatomic,readwrite) NSString* soundName;
@property(nonatomic,readwrite) NSString* sketchName;

-(void)setViewTitle:(NSString*)title;
-(void)setElementDetails:(NSString*)newElementEnglish : (NSString*)newElementChinese : (NSString*)newPhanetic : (NSString*)newPinyin : (NSString*)newDescriptionEnglish : (NSString*)newDescriptionChinese : (NSString*)newSoundName : (NSString*)imageName;

@end
