//
//  SummaryController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 14/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "QuizController.h"

@interface SummaryController : UIViewController<UITableViewDataSource,UITableViewDelegate>

-(void)setCurrentScore:(int)myScore;
-(void)setQuestionState:(NSMutableArray*)allState;

@end
