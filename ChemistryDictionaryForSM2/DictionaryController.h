//
//  DictionaryController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 4/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DictionaryDB.h"
#import "ElementModel.h"
#import "ElementController.h"

@protocol DictionaryDelegate <NSObject>

@required
-(void)returnToMainInterface;

@end

@interface DictionaryController : UITableViewController <ElementDelegate>

@property(nonatomic, readwrite)NSString* selectedElement;
@property(nonatomic, readwrite)NSMutableArray* elementList;
@property(nonatomic, readwrite)NSMutableArray* searchResult;
@property(nonatomic, readwrite)NSArray* database;

@property id<DictionaryDelegate> delegate;

@end
