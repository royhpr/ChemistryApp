//
//  ViewController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 20/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyllabusController.h"

@interface ViewController : UIViewController <SyllabusDelegate>

@property(strong, nonatomic)UIImage* periodicTable;
@property(strong, nonatomic)UIImage* syllabus;
@property(strong, nonatomic)UIImage* searchDictionary;
@property(strong, nonatomic)UIImage* quiz;

@property(strong, nonatomic)UIImageView* periodicTableView;
@property(strong, nonatomic)UIImageView* syllabusView;
@property(strong, nonatomic)UIImageView* searchDictionaryView;
@property(strong, nonatomic)UIImageView* quizView;

@property(strong, nonatomic)UILabel* periodicLabel;
@property(strong, nonatomic)UILabel* syllabusLabel;
@property(strong, nonatomic)UILabel* searchDictionaryLabel;
@property(strong, nonatomic)UILabel* quizLabel;

@property(nonatomic, readwrite)CGFloat viewHeight;
@property(nonatomic, readwrite)CGFloat xAxisLeft;
@property(nonatomic, readwrite)CGFloat xAxisRight;
@property(nonatomic, readwrite)CGFloat yAxisUp;
@property(nonatomic, readwrite)CGFloat yAxisDown;
@property(nonatomic, readwrite)CGFloat imageWidth;
@property(nonatomic, readwrite)CGFloat imageHeight;

@property(nonatomic, readwrite)CGFloat labelYAxisUp;
@property(nonatomic, readwrite)CGFloat labelYAxisDown;
@property(nonatomic, readwrite)CGFloat labelXAxisLeft;
@property(nonatomic, readwrite)CGFloat labelXAxisRight;

@end
