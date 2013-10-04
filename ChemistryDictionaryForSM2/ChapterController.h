//
//  ChapterController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "DictionaryDB.h"
#import "ElementModel.h"
#import "ElementController.h"

@protocol ChapterDelegate <NSObject>

@required
-(void)returnToMainInterface;

@end

@interface ChapterController : UITableViewController<ElementDelegate>

@property(nonatomic, readwrite)int chapterNumber;
@property(nonatomic, readwrite)NSString* currentTitle;
@property(nonatomic, readwrite)NSString* selectedElement;
@property(nonatomic, readwrite)NSMutableArray* currentChapterElements;
@property(nonatomic, readwrite)NSMutableArray* searchResult;
@property(nonatomic, readwrite)NSArray* database;

@property id<ChapterDelegate> delegate;

-(void)setChapterNumber: (int)currentChapterNumber;

@end
