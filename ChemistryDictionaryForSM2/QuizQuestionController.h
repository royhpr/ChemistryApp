//
//  QuizQuestionController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 13/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QuizController.h"
#import "ViewController.h"
#import "SummaryController.h"

@interface QuizQuestionController : UIViewController

-(void)setParameters:(NSString*)newQuestion : (NSString*)newAnswer : (NSString*)newPAnsOne : (NSString*)newPAnsTwo : (NSString*)newPAnsThree : (NSString*)newPAnsFour;

-(void)setRemainingQuestions:(NSMutableArray*)remaining;

-(void)setCurrentScore:(int)myScore;

-(void)setResultList:(NSMutableArray*)currentResult;

@end
