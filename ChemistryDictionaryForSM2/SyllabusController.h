//
//  SyllabusController.h
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 21/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChapterController.h"

@protocol SyllabusDelegate <NSObject>

@required
-(void)returnToMainInterface;

@end

@interface SyllabusController : UITableViewController <ChapterDelegate>
{
    int _currentTableRow;
}

@property id<SyllabusDelegate> delegate;

@end