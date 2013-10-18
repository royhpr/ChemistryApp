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
            char* sound = (char *)sqlite3_column_text(statement, 7);
            NSString *newChapter = [[NSString alloc] initWithUTF8String:chapter];
            NSString *newElementEnglish = [[NSString alloc] initWithUTF8String:elementEnglish];
            NSString* newPhanetic = [[NSString alloc]initWithUTF8String:phanetic];
            NSString *newElementChinese = [[NSString alloc] initWithUTF8String:elementChinese];
            NSString *newPinyin = [[NSString alloc] initWithUTF8String:pinyin];
            NSString *newDescriptionEnglish = [[NSString alloc] initWithUTF8String:descriptionEnglish];
            NSString *newDescriptionChinese = [[NSString alloc] initWithUTF8String:descriptionChinese];
            NSString* newSound = [[NSString alloc]initWithUTF8String:sound];
            
            NSCharacterSet* dotCharSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
            
            newChapter = [[newChapter componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newElementEnglish = [[newElementEnglish componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newPhanetic = [[newPhanetic componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newElementChinese = [[newElementChinese componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newPinyin = [[newPinyin componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newDescriptionEnglish = [[newDescriptionEnglish componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newDescriptionChinese = [[newDescriptionChinese componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newSound = [[newSound componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            
            NSCharacterSet* quoteCharSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
            
            newChapter = [[newChapter componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newElementEnglish = [[newElementEnglish componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newPhanetic = [[newPhanetic componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newElementChinese = [[newElementChinese componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newPinyin = [[newPinyin componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newDescriptionEnglish = [[newDescriptionEnglish componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newDescriptionChinese = [[newDescriptionChinese componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newSound = [[newSound componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];

            ElementModel* element = [[ElementModel alloc]initializeWithChapter:newChapter :newElementEnglish :newPhanetic :newElementChinese :newPinyin :newDescriptionEnglish :newDescriptionChinese : newSound];
            [currentElementList addObject:element];
        }
        sqlite3_finalize(statement);
        //sqlite3_close(_prePopulatedDB);
    }
    return currentElementList;
}

-(NSArray*)periodicTableElementList
{
    NSMutableArray *periodicElements = [[NSMutableArray alloc] init];
    NSString *query = @"SELECT * FROM periodicTableDB ORDER BY AtomicNumber DESC";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_prePopulatedDB, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK)
    {
        while (sqlite3_step(statement) == SQLITE_ROW)
        {
            char *chinese = (char *) sqlite3_column_text(statement, 0);
            char *pinyin = (char *) sqlite3_column_text(statement, 1);
            char *english = (char*)sqlite3_column_text(statement, 2);
            char *phanetic = (char *) sqlite3_column_text(statement, 3);
            char *atomicNumber = (char *) sqlite3_column_text(statement, 4);
            char *atomicWeight = (char *) sqlite3_column_text(statement, 5);
            char *electronConfig = (char *) sqlite3_column_text(statement, 6);
            char *mp = (char *) sqlite3_column_text(statement, 7);
            char *bp = (char *) sqlite3_column_text(statement, 8);
            char *heatOfFusion = (char *) sqlite3_column_text(statement, 9);
            char *heatOfVapor = (char *) sqlite3_column_text(statement, 10);
            char *density = (char *) sqlite3_column_text(statement, 11);
            char *phase = (char *) sqlite3_column_text(statement, 12);
            char *elementClass = (char *) sqlite3_column_text(statement, 13);
            char *oxidationState = (char *) sqlite3_column_text(statement, 14);
            char *electronegativity = (char *) sqlite3_column_text(statement, 15);
            char *ionizationEnergy = (char *) sqlite3_column_text(statement, 16);
            char *atomicRadius = (char *) sqlite3_column_text(statement, 17);
            char *vdwRadius = (char *) sqlite3_column_text(statement, 18);
            
            
            NSString *newChinese = [[NSString alloc] initWithUTF8String:chinese];
            NSString *newPinyin = [[NSString alloc] initWithUTF8String:pinyin];
            NSString *newEnglish = [[NSString alloc]initWithUTF8String:english];
            NSString *newPhanetic = [[NSString alloc] initWithUTF8String:phanetic];
            NSString *newAtomicNumber = [[NSString alloc] initWithUTF8String:atomicNumber];
            NSString *newAtomicWeight = [[NSString alloc] initWithUTF8String:atomicWeight];
            NSString *newElectronConfig = [[NSString alloc] initWithUTF8String:electronConfig];
            NSString *newMp = [[NSString alloc] initWithUTF8String:mp];
            NSString *newBp = [[NSString alloc] initWithUTF8String:bp];
            NSString *newHeatOfFusion = [[NSString alloc] initWithUTF8String:heatOfFusion];
            NSString *newHeatOfVapor = [[NSString alloc] initWithUTF8String:heatOfVapor];
            NSString *newDensity = [[NSString alloc] initWithUTF8String:density];
            NSString *newPhase = [[NSString alloc] initWithUTF8String:phase];
            NSString *newElementClass = [[NSString alloc] initWithUTF8String:elementClass];
            NSString *newOxidationState = [[NSString alloc] initWithUTF8String:oxidationState];
            NSString *newElectronegativity = [[NSString alloc] initWithUTF8String:electronegativity];
            NSString *newIonizationEnergy = [[NSString alloc] initWithUTF8String:ionizationEnergy];
            NSString *newAtomicRadius = [[NSString alloc] initWithUTF8String:atomicRadius];
            NSString *newVdwRadius = [[NSString alloc] initWithUTF8String:vdwRadius];
            
            NSCharacterSet* dotCharSet = [NSCharacterSet characterSetWithCharactersInString:@" "];
            
            newChinese = [[newChinese componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newPinyin = [[newPinyin componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newEnglish = [[newEnglish componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newPhanetic = [[newPhanetic componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newAtomicNumber = [[newAtomicNumber componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newAtomicWeight = [[newAtomicWeight componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newElectronConfig = [[newElectronConfig componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newMp = [[newMp componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newBp = [[newBp componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newHeatOfFusion = [[newHeatOfFusion componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newHeatOfVapor = [[newHeatOfVapor componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newDensity = [[newDensity componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newPhase = [[newPhase componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newElementClass = [[newElementClass componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newOxidationState = [[newOxidationState componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newElectronegativity = [[newElectronegativity componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newIonizationEnergy = [[newIonizationEnergy componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newAtomicRadius = [[newAtomicRadius componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            newVdwRadius = [[newVdwRadius componentsSeparatedByCharactersInSet:dotCharSet]componentsJoinedByString:@" "];
            
            NSCharacterSet* quoteCharSet = [NSCharacterSet characterSetWithCharactersInString:@"\""];
            
            newChinese = [[newChinese componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newPinyin = [[newPinyin componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newEnglish = [[newEnglish componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newPhanetic = [[newPhanetic componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newAtomicNumber = [[newAtomicNumber componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newAtomicWeight = [[newAtomicWeight componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newElectronConfig = [[newElectronConfig componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newMp = [[newMp componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newBp = [[newBp componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newHeatOfFusion = [[newHeatOfFusion componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newHeatOfVapor = [[newHeatOfVapor componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newDensity = [[newDensity componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newPhase = [[newPhase componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newElementClass = [[newElementClass componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newOxidationState = [[newOxidationState componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newElectronegativity = [[newElectronegativity componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newIonizationEnergy = [[newIonizationEnergy componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newAtomicRadius = [[newAtomicRadius componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            newVdwRadius = [[newVdwRadius componentsSeparatedByCharactersInSet:quoteCharSet]componentsJoinedByString:@""];
            
            PeriodicTableElementModel* periodicElement = [[PeriodicTableElementModel alloc]initWithElements:newChinese :newPinyin :newEnglish :newPhanetic :newAtomicNumber :newAtomicWeight :newElectronConfig :newMp :newBp :newHeatOfFusion :newHeatOfVapor :newDensity :newPhase :newElementClass :newOxidationState :newElectronegativity :newIonizationEnergy :newAtomicRadius :newVdwRadius];
            [periodicElements addObject:periodicElement];
        }
        sqlite3_finalize(statement);
    }
    return periodicElements;
}

@end
