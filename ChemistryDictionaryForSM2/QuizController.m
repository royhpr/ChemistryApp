//
//  QuizController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 12/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "QuizController.h"

@interface QuizController ()

@property(strong,nonatomic)UIView* periodicTableView;
@property(strong,nonatomic)UIView* syllabusView;
@property(strong,nonatomic)UIView* startView;
@property(strong,nonatomic)UIButton* startButton;
@property(strong,nonatomic)UISwitch* periodicTableIndicator;
@property(strong,nonatomic)UISwitch* syllabusIndicator;
@property(strong,nonatomic)UITableView* syllabusTable;
@property(nonatomic,readwrite)NSMutableArray* chapterArray;

@property(nonatomic,readwrite)NSMutableArray* switchStates;
@property(nonatomic,readwrite)NSMutableArray* sourceQuestionAnswer;
@property(nonatomic,readwrite)NSMutableArray* sourceAnswer;

@property(nonatomic,readwrite)NSMutableArray* syllabusDatabase;
@property(nonatomic,readwrite)NSMutableArray* periodicTableDatabase;

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@property(nonatomic,readwrite)int n;

@end

@implementation QuizController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
        
        self.ViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
    }
    else
    {
        self.ViewOrigin = self.view.frame.origin;
        
        self.ViewSize = self.view.frame.size;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       
	self.navigationItem.hidesBackButton = YES;
    
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(0, 0, 40, 40);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMain)];
    [singleTap setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTap];
    
    UIBarButtonItem* homeButton = [[UIBarButtonItem alloc]initWithCustomView:homeView];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    //set up left item
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    title.font = [UIFont boldSystemFontOfSize:20.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    title.text = @"Quiz 测验";
    UIBarButtonItem* leftNavButton = [[UIBarButtonItem alloc]initWithCustomView:title];
    self.navigationItem.leftBarButtonItem = leftNavButton;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    if(self.startView != NULL)
        return;
    [self initializeSubviews];
}

- (void)initializePeriodicTableView
{
    self.periodicTableView = [[UIView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, self.ViewOrigin.y, self.ViewSize.width, 40.0)];
    [self.periodicTableView setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:217.0/255.0 blue:241.0/255.0 alpha:1]];
    self.periodicTableView.layer.borderColor = [UIColor colorWithRed:127.0/255.0 green:165.0/255.0 blue:209.0/255.0 alpha:1].CGColor;
    self.periodicTableView.layer.borderWidth = 2.0;
    
    UILabel* periodicTableTitle = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 5.0, 200.0, 50.0)];
    periodicTableTitle.text = @"Periodic Table 周期表";
    [periodicTableTitle setBackgroundColor:[UIColor clearColor]];
    periodicTableTitle.font = [UIFont boldSystemFontOfSize:18.0];
    periodicTableTitle.numberOfLines = 0;
    [periodicTableTitle sizeToFit];
    
    self.periodicTableIndicator = [[UISwitch alloc]initWithFrame:CGRectZero];
    CGRect frame = self.periodicTableIndicator.frame;
    frame.origin = CGPointMake(self.periodicTableView.frame.size.width - frame.size.width - 10.0, (self.periodicTableView.frame.size.height - frame.size.height)/2);
    self.periodicTableIndicator.frame = frame;
    [self.periodicTableIndicator setBackgroundColor:[UIColor clearColor]];
    
    [self.periodicTableView addSubview:periodicTableTitle];
    [self.periodicTableView addSubview:self.periodicTableIndicator];
    
    [self.view addSubview:self.periodicTableView];
}

- (void)initializeSyllabusView
{
    self.syllabusView = [[UIView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, self.periodicTableView.frame.origin.y + self.periodicTableView.frame.size.height, self.ViewSize.width, 40.0)];
    [self.syllabusView setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:217.0/255.0 blue:241.0/255.0 alpha:1]];
    self.syllabusView.layer.borderColor = [UIColor colorWithRed:127.0/255.0 green:165.0/255.0 blue:209.0/255.0 alpha:1].CGColor;
    self.syllabusView.layer.borderWidth = 2.0;
    
    UILabel* syllabusTitle = [[UILabel alloc]initWithFrame:CGRectMake(10.0, 5.0, 200.0, 50.0)];
    syllabusTitle.text = @"Syllabus 教学大纲";
    [syllabusTitle setBackgroundColor:[UIColor clearColor]];
    syllabusTitle.font = [UIFont boldSystemFontOfSize:18.0];
    syllabusTitle.numberOfLines = 0;
    [syllabusTitle sizeToFit];
    
    self.syllabusIndicator = [[UISwitch alloc]initWithFrame:CGRectZero];
    CGRect frame = self.syllabusIndicator.frame;
    frame.origin = CGPointMake(self.syllabusView.frame.size.width - frame.size.width - 10.0, (self.syllabusView.frame.size.height - frame.size.height)/2);
    self.syllabusIndicator.frame = frame;

    [self.syllabusIndicator setBackgroundColor:[UIColor clearColor]];
    [self.syllabusIndicator addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.syllabusView addSubview:syllabusTitle];
    [self.syllabusView addSubview:self.syllabusIndicator];
    [self.view addSubview:self.syllabusView];
}

-(void)initializeSyllabusTable
{
    self.syllabusTable = [[UITableView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, self.syllabusView.frame.origin.y + self.syllabusView.frame.size.height, self.ViewSize.width, self.ViewSize.height - 120.0) style:UITableViewStylePlain];
    
    self.syllabusTable.rowHeight = 45;
    self.syllabusTable.scrollEnabled = YES;
    self.syllabusTable.showsVerticalScrollIndicator = YES;
    self.syllabusTable.userInteractionEnabled = YES;
    self.syllabusTable.bounces = YES;
    self.syllabusTable.delegate = self;
    self.syllabusTable.dataSource = self;
    
    
    self.n = 0;
    [self.syllabusTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    [self.view addSubview:self.syllabusTable];
}

-(void)initializeStartView
{
    self.startView = [[UIView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, self.syllabusView.frame.origin.y + self.syllabusView.frame.size.height, self.ViewSize.width, 40.0)];
    [self.startView setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:217.0/255.0 blue:241.0/255.0 alpha:1]];
    self.startView.layer.borderColor = [UIColor colorWithRed:127.0/255.0 green:165.0/255.0 blue:209.0/255.0 alpha:1].CGColor;
    self.startView.layer.borderWidth = 2.0;
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.startButton addTarget:self action:@selector(tapToStart:) forControlEvents:UIControlEventTouchDown];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    self.startButton.frame = CGRectMake((self.startView.frame.size.width - 80.0)/2, (self.startView.frame.size.height - 30.0)/2, 80.0, 30.0);
    self.startButton.layer.borderColor = [UIColor blackColor].CGColor;
    self.startButton.layer.borderWidth = 2.0;
    self.startButton.layer.cornerRadius = 5.0;
    
    [self.startView addSubview:self.startButton];
    [self.view addSubview:self.startView];
}

-(void)tapToStart:(UIButton*)sender
{
    self.sourceQuestionAnswer = [[NSMutableArray alloc]init];
    self.sourceAnswer = [[NSMutableArray alloc]init];

    if(self.periodicTableIndicator.on)
    {
        self.periodicTableDatabase = [NSMutableArray arrayWithArray:[[DictionaryDB database]periodicTableElementList]];
        
        for(PeriodicTableElementModel* currentElement in self.periodicTableDatabase)
        {
            [self.sourceAnswer addObject:[NSMutableArray arrayWithObjects:PERIODIC_ELEMENT_INDICATOR, currentElement.english, nil]];
            
                NSArray* currentObject = [NSArray arrayWithObjects: PERIODIC_ELEMENT_INDICATOR, currentElement.chinese, currentElement.english, nil];
                [self.sourceQuestionAnswer addObject:currentObject];
        }
    }
    if(self.syllabusIndicator.on)
    {
        self.syllabusDatabase = [NSMutableArray arrayWithArray:[[DictionaryDB database]elementList]];
        NSMutableArray* selectedChapterArray = [[NSMutableArray alloc]init];
        for(int i=0; i<17; i++)
        {
            if([[self.switchStates objectAtIndex:i]isEqualToString:@"ON"])
            {
                [selectedChapterArray addObject:[NSString stringWithFormat:@"%d",i+1]];
            }
        }
        for(ElementModel* currentElement in self.syllabusDatabase)
        {
            if([selectedChapterArray containsObject:currentElement.chapter])
            {
                NSArray* currentObject = [NSArray arrayWithObjects:currentElement.chapter,currentElement.elementChinese,currentElement.elementEnglish, nil];
                [self.sourceQuestionAnswer addObject:currentObject];
                [self.sourceAnswer addObject:[NSMutableArray arrayWithObjects:currentElement.chapter, currentElement.elementEnglish, nil]];
            }
        }
    }
    if(self.sourceQuestionAnswer.count != 0 && self.sourceAnswer!=0)
    {
        [self generateSetOfQuestions];
    }
    else
    {
        UIAlertView* nonExistMsg = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select proper quiz scope" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nonExistMsg show];
        [self performSelector:@selector(dismissCurrentMessage:) withObject:nonExistMsg afterDelay:2.0];
    }
}

-(void)dismissCurrentMessage:(UIAlertView*)currentMessage
{
    [currentMessage dismissWithClickedButtonIndex:-1 animated:YES];
}

-(void)generateSetOfQuestions
{
    NSMutableArray* QuestionList = [[NSMutableArray alloc]init];
    
    //pick ten questions with answer
    NSMutableArray* possibleQA = [[NSMutableArray alloc] init];
    int remainingQA = 10;
    
    if ( [self.sourceQuestionAnswer count] >= remainingQA )
    {
        while (remainingQA > 0)
        {
            id possibleObject = [self.sourceQuestionAnswer objectAtIndex: arc4random() % [self.sourceQuestionAnswer count]];
            
            if (![possibleQA containsObject: possibleObject])
            {
                [possibleQA addObject: possibleObject];
                remainingQA --;
            }
        }
    }
    
    for(NSMutableArray* currentQuestion in possibleQA)
    {
        //Pick other three possible answers
        NSMutableArray* possibleAns = [[NSMutableArray alloc] init];
        [possibleAns addObject:[currentQuestion objectAtIndex:2]];
        int remainingA = 3;
        
        if ([self.sourceAnswer count] >= remainingA)
        {
            while (remainingA > 0)
            {
                id possibleObject = [self.sourceAnswer objectAtIndex: arc4random() % [self.sourceAnswer count]];
                
                if (![possibleAns containsObject:[possibleObject objectAtIndex:1]])
                {
                    [possibleAns addObject: [possibleObject objectAtIndex:1]];
                    remainingA --;
                }
            }
        }
        
        //Randomize the order
        for (int x = 0; x < [possibleAns count]; x++)
        {
            int randInt = (arc4random() % ([possibleAns count] - x)) + x;
            [possibleAns exchangeObjectAtIndex:x withObjectAtIndex:randInt];
        }
        
        //Form one question
        NSMutableArray* question = [[NSMutableArray alloc]init];
        [question addObject:[currentQuestion objectAtIndex:1]];
        [question addObject:[currentQuestion objectAtIndex:2]];
        
        for(NSString* currentAns in possibleAns)
        {
            [question addObject:currentAns];
        }
        
        [QuestionList addObject:question];
    }
    
    QuizQuestionController* firstQuestion = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizQuestion"];
    NSMutableArray* currentQuestion = [QuestionList objectAtIndex:0];
    NSString* question = [currentQuestion objectAtIndex:0];
    NSString* answer = [currentQuestion objectAtIndex:1];
    NSString* pAnsOne = [currentQuestion objectAtIndex:2];
    NSString* pAnsTwo = [currentQuestion objectAtIndex:3];
    NSString* pAnsThree = [currentQuestion objectAtIndex:4];
    NSString* pAnsFour = [currentQuestion objectAtIndex:5];
    [firstQuestion setParameters: question :answer :pAnsOne :pAnsTwo :pAnsThree :pAnsFour];
    [QuestionList removeObject:currentQuestion];
    [firstQuestion setRemainingQuestions:QuestionList];
    [firstQuestion setCurrentScore:0];
    [firstQuestion setResultList:[[NSMutableArray alloc]init]];
    
    [self.navigationController pushViewController:firstQuestion animated:YES];
}

-(void)initializeSubviews
{
    [self initializeChapterList];
    [self initializeSwitchStates];
    [self initializePeriodicTableView];
    [self initializeSyllabusView];
    [self initializeSyllabusTable];
    [self initializeStartView];
    [self.syllabusTable setHidden:YES];
}

-(void)goBackToMain
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) switchIsChanged:(UISwitch *)paramSender{
    
    if ([paramSender isOn])
    {
        [self.syllabusTable setHidden:NO];
        CGRect frame = self.startView.frame;
        frame.origin.y = self.view.frame.size.height - 40.0;
        self.startView.frame = frame;
    }
    else
    {
        [self.syllabusTable setHidden:YES];
        [self offAllChapters];
        CGRect frame = self.startView.frame;
        frame.origin.y = self.syllabusView.frame.origin.y + self.syllabusView.frame.size.height;
        self.startView.frame = frame;
    }
    [self.syllabusTable reloadData];
}

-(void)offAllChapters
{
    for(int i=0; i<17; i++)
    {
        [self.switchStates replaceObjectAtIndex:i withObject:@"OFF"];
    }
}

-(void)initializeChapterList
{
    if(self.chapterArray != NULL)
        return;
    self.chapterArray = [[NSMutableArray alloc]init];
    [self.chapterArray addObject:@"Fundamentals of Chemistry"];
    [self.chapterArray addObject:@"Atomic Structure"];
    [self.chapterArray addObject:@"Periodic Table"];
    [self.chapterArray addObject:@"Properties of Elements in the Periodic Table"];
    [self.chapterArray addObject:@"Stoichiomery"];
    [self.chapterArray addObject:@"Models of Chemistry Bonding"];
    [self.chapterArray addObject:@"Structure and Shapes of Molecules"];
    [self.chapterArray addObject:@"Gases and Solutions"];
    [self.chapterArray addObject:@"Chemical Energentics and Thermodynamics"];
    [self.chapterArray addObject:@"Types of Chemical Reactions"];
    [self.chapterArray addObject:@"Chemical Kinetics"];
    [self.chapterArray addObject:@"Chemical Equilibrium"];
    [self.chapterArray addObject:@"Alkanes and Alkenes"];
    [self.chapterArray addObject:@"Alkynes, Aromatics and Functional Groups"];
    [self.chapterArray addObject:@"Common Classes of Organic Reactions"];
    [self.chapterArray addObject:@"Stereochemistry"];
    [self.chapterArray addObject:@"Molecules of Life"];
}

-(void)initializeSwitchStates
{
    if(self.switchStates != NULL)
        return;
    self.switchStates = [[NSMutableArray alloc]init];
    
    for(int i=0; i<17; i++)
    {
        [self.switchStates addObject:@"OFF"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel* chapter = nil;
    UILabel* content = nil;
    UISwitch* indicator = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        chapter = [[UILabel alloc]init];
        chapter.tag = 1;
        
        content = [[UILabel alloc]init];
        content.tag = 2;
        
        indicator = [[UISwitch alloc]initWithFrame:CGRectZero];
        indicator.tag = 3;
        
        [cell.contentView addSubview:chapter];
        [cell.contentView addSubview:content];
        [cell.contentView addSubview:indicator];
    }
    else
    {
        chapter = (UILabel*)[cell.contentView viewWithTag:1];
        content = (UILabel*)[cell.contentView viewWithTag:2];
        indicator = (UISwitch*)[cell.contentView viewWithTag:3];
    }

    chapter.frame = CGRectMake(10.0, 0.0, 80.0, 30.0);
    [chapter setBackgroundColor:[UIColor clearColor]];
    chapter.font = [UIFont boldSystemFontOfSize:12.5];
    NSMutableString* chapterTitle = [[NSMutableString alloc]initWithString:@"Chapter "];
    [chapterTitle appendFormat:@"%d",indexPath.item + 1];
    chapter.text = chapterTitle;
    chapter.numberOfLines = 0;
    [chapter sizeToFit];
    chapter.frame = CGRectMake(chapter.frame.origin.x, (cell.contentView.frame.size.height - chapter.frame.size.height)/2, chapter.frame.size.width, chapter.frame.size.height);
    
    CGFloat contentOrigin = chapter.frame.origin.x + chapter.frame.size.width + 5.0;
    content.frame = CGRectMake(contentOrigin, 0.0, 4 * (cell.contentView.frame.size.width - contentOrigin) / 6, 30.0);
    [content setBackgroundColor:[UIColor clearColor]];
    content.font = [UIFont boldSystemFontOfSize:12.5];
    NSMutableString* contentString = [[NSMutableString alloc]initWithString:(NSString*)[self.chapterArray objectAtIndex:indexPath.item]];
    content.text = contentString;
    content.numberOfLines = 0;
    [content sizeToFit];
    content.frame = CGRectMake(content.frame.origin.x, (cell.contentView.frame.size.height - content.frame.size.height)/2, content.frame.size.width, content.frame.size.height);
    
    indicator.transform = CGAffineTransformMakeScale(0.75, 0.75);
    CGRect frame = indicator.frame;
    frame.origin.x = cell.contentView.frame.size.width - 50.0;
    frame.origin.y = (cell.contentView.frame.size.height - frame.size.height) / 2;
    indicator.frame = frame;
    [indicator addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];

    if([[self.switchStates objectAtIndex:indexPath.row]isEqualToString:@"ON"])
    {
        indicator.on = YES;
    }
    else
    {
        indicator.on = NO;
    }

    return cell;
}

-(void)stateChanged:(UISwitch*)sender
{
    UITableViewCell* parentCell;
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        parentCell = (UITableViewCell*)[[[sender superview]superview]superview];
    }
    else
    {
        parentCell = (UITableViewCell*)[[sender superview]superview];
    }
    
    NSIndexPath* currentIndexPath = [self.syllabusTable indexPathForCell:parentCell];
    
    if(sender.on)
    {
        [self.switchStates replaceObjectAtIndex:currentIndexPath.row withObject:@"ON"];
    }
    else
    {
        [self.switchStates replaceObjectAtIndex:currentIndexPath.row withObject:@"OFF"];
    }
}

//All about interface orientation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
