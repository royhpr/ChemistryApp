//
//  AppDelegate.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 20/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
//#import "ElementModel.h"
//#import "DictionaryDB.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@end
