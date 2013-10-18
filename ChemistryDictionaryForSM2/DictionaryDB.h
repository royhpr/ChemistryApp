//
//  DictionaryDB.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ElementModel.h"
#import "PeriodicTableElementModel.h"

@interface DictionaryDB : NSObject
{
    sqlite3* _prePopulatedDB;
}

+(DictionaryDB*)database;
-(NSArray*)elementList;
-(NSArray*)periodicTableElementList;

@end
