//
//  periodicTableElementController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 11/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeriodicTableElementModel.h"
#import "CustomNavigationController.h"
#import "Constant.h"
#import "ViewController.h"

@interface PeriodicTableElementController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property(nonatomic,readwrite)PeriodicTableElementModel* element;

-(void)setElementParameters:(PeriodicTableElementModel*)currentElement;

@end
