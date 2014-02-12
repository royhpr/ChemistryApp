//
//  PeriodicTableController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 5/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "ViewController.h"
#import "DictionaryDB.h"
#import "PeriodicTableElementModel.h"
#import "PeriodicTableElementController.h"
#import "ElementListController.h"

@interface PeriodicTableController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate,UIScrollViewAccessibilityDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *periodicTableScrollView;

@end
