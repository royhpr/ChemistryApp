//
//  DictionaryDB.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "DictionaryDB.h"
#import "ElementModel.h"

@implementation DictionaryDB

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"dictionary"
                                                             ofType:@"sqlite"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_prePopulatedDB) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

+(DictionaryDB*)database
{
    static DictionaryDB* _database;
    if(_database == nil)
    {
        _database = [[DictionaryDB alloc]init];
    }
    return _database;
}

-(NSArray*)elementList
{
    NSMutableArray *currentElementList = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT * FROM dictionaryDB ORDER BY Chapter DESC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_prePopulatedDB, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *chapter = (char *) sqlite3_column_text(statement, 0);
            char *elementEnglish = (char *) sqlite3_column_text(statement, 1);
            char* phanetic = (char*)sqlite3_column_text(statement, 2);
            char *elementChinese = (char *) sqlite3_column_text(statement, 3);
            char *pinyin = (char *) sqlite3_column_text(statement, 4);
            char *descriptionEnglish = (char *) sqlite3_column_text(statement, 5);
            char *descriptionChinese = (char *) sqlite3_column_text(statement, 6);
            NSString *newChapter = [[NSString alloc] initWithUTF8String:chapter];
            NSString *newElementEnglish = [[NSString alloc] initWithUTF8String:elementEnglish];
            NSString* newPhanetic = [[NSString alloc]initWithUTF8String:phanetic];
            NSString *newElementChinese = [[NSString alloc] initWithUTF8String:elementChinese];
            NSString *newPinyin = [[NSString alloc] initWithUTF8String:pinyin];
            NSString *newDescriptionEnglish = [[NSString alloc] initWithUTF8String:descriptionEnglish];
            NSString *newDescriptionChinese = [[NSString alloc] initWithUTF8String:descriptionChinese];
            
            NSCharacterSet* charSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
            
            newChapter = [[newChapter componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newElementEnglish = [[newElementEnglish componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newPhanetic = [[newPhanetic componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newElementChinese = [[newElementChinese componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newPinyin = [[newPinyin componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newDescriptionEnglish = [[newDescriptionEnglish componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            newDescriptionChinese = [[newDescriptionChinese componentsSeparatedByCharactersInSet:charSet]componentsJoinedByString:@" "];
            ElementModel* element = [[ElementModel alloc]initializeWithChapter:newChapter :newElementEnglish :newPhanetic :newElementChinese :newPinyin :newDescriptionEnglish :newDescriptionChinese];
            [currentElementList addObject:element];
        }
        sqlite3_finalize(statement);
        //sqlite3_close(_prePopulatedDB);
    }
    return currentElementList;
}

@end
