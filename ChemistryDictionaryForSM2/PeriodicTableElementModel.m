//
//  PeriodicTableElementModel.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 11/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "PeriodicTableElementModel.h"

@implementation PeriodicTableElementModel

-(id)initWithElements:(NSString*)newChinese : (NSString*)newPinyin : (NSString*)newEnglish : (NSString*)newPhanetic : (NSString*)newAtomicNumver : (NSString*)newAtomicWeight : (NSString*)newElectronConfig : (NSString*)newMp : (NSString*)newBp : (NSString*)newHeatFusion : (NSString*)newheatVaporization : (NSString*)newDensity : (NSString*)newPhase : (NSString*)newElementClass : (NSString*)newOxidationState : (NSString*)newElectronegativity : (NSString*)newIonizationEnergy : (NSString*)newAtomicRadius : (NSString*)newVDWRadius
{
    if(self == [super init])
    {
        self.chinese = newChinese;
        self.pinyin = newPinyin;
        self.english = newEnglish;
        self.phanetic = newPhanetic;
        self.atomicNumber = newAtomicNumver;
        self.atomicWeight = newAtomicWeight;
        self.electronConfig = newElectronConfig;
        self.mp = newMp;
        self.bp = newBp;
        self.heatFusion = newHeatFusion;
        self.heatVaporization = newheatVaporization;
        self.density = newDensity;
        self.phase = newPhase;
        self.elementClassification = newElementClass;
        self.oxidationState = newOxidationState;
        self.electronegativity = newElectronegativity;
        self.ionizationEnergy = newIonizationEnergy;
        self.atomicRadius = newAtomicRadius;
        self.vdwRadius = newVDWRadius;
    }
    return self;
}

@end
