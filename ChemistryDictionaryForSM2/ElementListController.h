//
//  ElementListController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 12/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "PeriodicTableController.h"
#import "ViewController.h"

@interface ElementListController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *currentListWebView;
@property (weak, nonatomic) IBOutlet UIScrollView *currentScrollView;

@end
