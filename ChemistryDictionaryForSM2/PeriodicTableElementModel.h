//
//  PeriodicTableElementModel.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 11/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PeriodicTableElementModel : NSObject

@property(strong,readwrite)NSString* chinese;
@property(strong,readwrite)NSString* pinyin;
@property(strong,readwrite)NSString* english;
@property(strong,readwrite)NSString* phanetic;
@property(strong,readwrite)NSString* atomicNumber;
@property(strong,readwrite)NSString* atomicWeight;
@property(strong,readwrite)NSString* electronConfig;
@property(strong,readwrite)NSString* mp;
@property(strong,readwrite)NSString* bp;
@property(strong,readwrite)NSString* heatFusion;
@property(strong,readwrite)NSString* heatVaporization;
@property(strong,readwrite)NSString* density;
@property(strong,readwrite)NSString* phase;
@property(strong,readwrite)NSString* elementClassification;
@property(strong,readwrite)NSString* oxidationState;
@property(strong,readwrite)NSString* electronegativity;
@property(strong,readwrite)NSString* ionizationEnergy;
@property(strong,readwrite)NSString* atomicRadius;
@property(strong,readwrite)NSString* vdwRadius;

-(id)initWithElements:(NSString*)newChinese : (NSString*)newPinyin : (NSString*)newEnglish : (NSString*)newPhanetic : (NSString*)newAtomicNumver : (NSString*)newAtomicWeight : (NSString*)newElectronConfig : (NSString*)newMp : (NSString*)newBp : (NSString*)newHeatFusion : (NSString*)newheatVaporization : (NSString*)newDensity : (NSString*)newPhase : (NSString*)newElementClass : (NSString*)newOxidationState : (NSString*)newElectronegativity : (NSString*)newIonizationEnergy : (NSString*)newAtomicRadius : (NSString*)newVDWRadius;

@end
