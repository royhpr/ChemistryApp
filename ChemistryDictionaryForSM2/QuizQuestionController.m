//
//  QuizQuestionController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 13/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "QuizQuestionController.h"

@interface QuizQuestionController ()

@property(nonatomic,readwrite)NSString* question;
@property(nonatomic,readwrite)NSString* answer;
@property(nonatomic,readwrite)NSString* pAnsOne;
@property(nonatomic,readwrite)NSString* pAnsTwo;
@property(nonatomic,readwrite)NSString* pAnsThree;
@property(nonatomic,readwrite)NSString* pAnsFour;
@property(nonatomic,readwrite)int score;

@property(nonatomic,readwrite)NSMutableArray* remainingQuestionParameters;

@property(strong,nonatomic)UILabel* scoreView;
@property(strong,nonatomic)UILabel* questionView;
@property(strong,nonatomic)UIButton* answerOneView;
@property(strong,nonatomic)UIButton* answerTwoView;
@property(strong,nonatomic)UIButton* answerThreeView;
@property(strong,nonatomic)UIButton* answerFourView;

@property(nonatomic,readwrite)NSMutableArray* result;

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@property(nonatomic,readwrite)BOOL isFirstTryCorrect;

@end

@implementation QuizQuestionController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setParameters:(NSString*)newQuestion : (NSString*)newAnswer : (NSString*)newPAnsOne : (NSString*)newPAnsTwo : (NSString*)newPAnsThree : (NSString*)newPAnsFour
{
    self.question = newQuestion;
    self.answer = newAnswer;
    self.pAnsOne = newPAnsOne;
    self.pAnsTwo = newPAnsTwo;
    self.pAnsThree = newPAnsThree;
    self.pAnsFour = newPAnsFour;
}

-(void)setResultList:(NSMutableArray*)currentResult
{
    self.result = [NSMutableArray arrayWithArray:currentResult];
}

-(void)setRemainingQuestions:(NSMutableArray*)remaining
{
    self.remainingQuestionParameters = [NSMutableArray arrayWithArray:remaining];
}

-(void)setCurrentScore:(int)myScore
{
    self.score = myScore;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIView* rightItems = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 40)];
    rightItems.userInteractionEnabled = YES;
    
    //back
    UIImageView* backView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backView.frame=CGRectMake(0, 0, 40, 40);
    backView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToQuizMainInterface)];
    [singleTapBack setNumberOfTapsRequired:1];
    [backView addGestureRecognizer:singleTapBack];
    
    //home
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(45, 0, 40, 40);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnToMain)];
    [singleTapHome setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTapHome];
    
    //add to view items
    [rightItems addSubview:backView];
    [rightItems addSubview:homeView];
    
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:rightItems];
    self.navigationItem.rightBarButtonItem = navButton;
    
    //set up left item
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    title.font = [UIFont boldSystemFontOfSize:20.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    title.text = @"Quiz 测试";
    UIBarButtonItem* leftNavButton = [[UIBarButtonItem alloc]initWithCustomView:title];
    self.navigationItem.leftBarButtonItem = leftNavButton;
    
    self.isFirstTryCorrect = YES;
}

-(void)goBackToQuizMainInterface
{
    for (UIViewController* currentController in self.navigationController.viewControllers)
    {
        if ([currentController isKindOfClass:[QuizController class]] )
        {
            QuizController* quizViewController = (QuizController*)currentController;
            [self.navigationController popToViewController:quizViewController animated:YES];
        }
    }
}

-(void)returnToMain
{
    for (UIViewController* currentController in self.navigationController.viewControllers)
    {
        if ([currentController isKindOfClass:[ViewController class]] )
        {
            ViewController* mainViewController = (ViewController*)currentController;
            [self.navigationController popToViewController:mainViewController animated:YES];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self initializeScoreView];
    [self initializeQuestionView];
    [self initializeFirstAnswerView];
    [self initializeSecondAnswerView];
    [self initializeThirdAnswerView];
    [self initializeFourthAnswerView];
}

-(void)initializeScoreView
{
    self.scoreView = [[UILabel alloc]initWithFrame:CGRectMake(self.ViewSize.width - 150.0, self.ViewOrigin.y, 150.0, 40.0)];
    [self.scoreView setTextAlignment:NSTextAlignmentCenter];
    [self.scoreView setBackgroundColor:[UIColor colorWithRed:98.0/255.0 green:153.0/255.0 blue:224.0/255.0 alpha:1]];
    [self.scoreView setTextColor:[UIColor blackColor]];
    [self.scoreView setFont:[UIFont systemFontOfSize:16.0]];
    self.scoreView.layer.cornerRadius = 5.0;
    [self.scoreView setText:[NSString stringWithFormat:@"Score: %d / 10",(int)self.score]];
    
    [self.view addSubview:self.scoreView];
}

-(void)initializeQuestionView
{
    self.questionView = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 300.0)/2, self.scoreView.frame.origin.y + self.scoreView.frame.size.height + 20.0, 300.0, 60.0)];
    [self.questionView setTextAlignment:NSTextAlignmentCenter];
    [self.questionView setBackgroundColor:[UIColor colorWithRed:169.0/255.0 green:192.0/255.0 blue:218.0/255.0 alpha:1]];
    [self.questionView setTextColor:[UIColor blackColor]];
    [self.questionView setFont:[UIFont systemFontOfSize:35.0]];
    self.questionView.layer.cornerRadius = 5.0;
    self.questionView.layer.borderColor = [UIColor colorWithRed:90.0/255.0 green:139.0/255.0 blue:196.0/255.0 alpha:1].CGColor;
    self.questionView.layer.borderWidth = 2.0;
    [self.questionView setText:self.question];
    [self.view addSubview:self.questionView];
}

-(void)initializeFirstAnswerView
{
    self.answerOneView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.answerOneView.tag = 1;
    [self.answerOneView addTarget:self action:@selector(checkAnswer:) forControlEvents:UIControlEventTouchDown];
    [self.answerOneView.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.answerOneView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.answerOneView.titleLabel setTextColor:[UIColor whiteColor]];
    [self.answerOneView setBackgroundColor:[UIColor colorWithRed:95.0/255.0 green:151.0/255.0 blue:223.0/225.0 alpha:1]];
    self.answerOneView.layer.borderWidth = 2.0;
    self.answerOneView.layer.borderColor = [UIColor colorWithRed:82.0/255.0 green:133.0/255.0 blue:193.0/255.0 alpha:1].CGColor;
    self.answerOneView.layer.cornerRadius = 5.0;
    
    [self.answerOneView setTitle:self.pAnsOne forState:UIControlStateNormal];
    self.answerOneView.frame = CGRectMake((self.view.frame.size.width - 300.0)/2, self.questionView.frame.origin.y + self.questionView.frame.size.height + 10.0, 300.0, 40.0);
    
    [self.view addSubview:self.answerOneView];
}

-(void)initializeSecondAnswerView
{
    self.answerTwoView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.answerTwoView.tag = 2;
    [self.answerTwoView addTarget:self action:@selector(checkAnswer:) forControlEvents:UIControlEventTouchDown];
    [self.answerTwoView.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.answerTwoView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.answerTwoView.titleLabel setTextColor:[UIColor whiteColor]];
    [self.answerTwoView setBackgroundColor:[UIColor colorWithRed:95.0/255.0 green:151.0/255.0 blue:223.0/225.0 alpha:1]];
    self.answerTwoView.layer.borderWidth = 2.0;
    self.answerTwoView.layer.borderColor = [UIColor colorWithRed:82.0/255.0 green:133.0/255.0 blue:193.0/255.0 alpha:1].CGColor;
    self.answerTwoView.layer.cornerRadius = 5.0;

    [self.answerTwoView setTitle:self.pAnsTwo forState:UIControlStateNormal];
    self.answerTwoView.frame = CGRectMake((self.view.frame.size.width - 300.0)/2, self.answerOneView.frame.origin.y + self.answerOneView.frame.size.height + 10.0, 300.0, 40.0);
    
    [self.view addSubview:self.answerTwoView];
}

-(void)initializeThirdAnswerView
{
    self.answerThreeView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.answerThreeView.tag = 3;
    [self.answerThreeView addTarget:self action:@selector(checkAnswer:) forControlEvents:UIControlEventTouchDown];
    [self.answerThreeView.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.answerThreeView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.answerThreeView.titleLabel setTextColor:[UIColor whiteColor]];
    [self.answerThreeView setBackgroundColor:[UIColor colorWithRed:95.0/255.0 green:151.0/255.0 blue:223.0/225.0 alpha:1]];
    self.answerThreeView.layer.borderWidth = 2.0;
    self.answerThreeView.layer.borderColor = [UIColor colorWithRed:82.0/255.0 green:133.0/255.0 blue:193.0/255.0 alpha:1].CGColor;
    self.answerThreeView.layer.cornerRadius = 5.0;

    [self.answerThreeView setTitle:self.pAnsThree forState:UIControlStateNormal];
    self.answerThreeView.frame = CGRectMake((self.view.frame.size.width - 300.0)/2, self.answerTwoView.frame.origin.y + self.answerTwoView.frame.size.height + 10.0, 300.0, 40.0);
    
    [self.view addSubview:self.answerThreeView];
}

-(void)initializeFourthAnswerView
{
    self.answerFourView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.answerFourView.tag = 4;
    [self.answerFourView addTarget:self action:@selector(checkAnswer:) forControlEvents:UIControlEventTouchDown];
    [self.answerFourView.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.answerFourView setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.answerFourView.titleLabel setTextColor:[UIColor whiteColor]];
    [self.answerFourView setBackgroundColor:[UIColor colorWithRed:95.0/255.0 green:151.0/255.0 blue:223.0/225.0 alpha:1]];
    self.answerFourView.layer.borderWidth = 2.0;
    self.answerFourView.layer.borderColor = [UIColor colorWithRed:82.0/255.0 green:133.0/255.0 blue:193.0/255.0 alpha:1].CGColor;
    self.answerFourView.layer.cornerRadius = 5.0;

    [self.answerFourView setTitle:self.pAnsFour forState:UIControlStateNormal];
    self.answerFourView.frame = CGRectMake((self.view.frame.size.width - 300.0)/2, self.answerThreeView.frame.origin.y + self.answerThreeView.frame.size.height + 10.0, 300.0, 40.0);
    
    [self.view addSubview:self.answerFourView];
}

- (void)goNext
{
    if(self.remainingQuestionParameters.count != 0)
    {
        QuizQuestionController* nextQuestion = [self.storyboard instantiateViewControllerWithIdentifier:@"QuizQuestion"];
        NSMutableArray* currentQuestion = [self.remainingQuestionParameters objectAtIndex:0];
        NSString* question = [currentQuestion objectAtIndex:0];
        NSString* answer = [currentQuestion objectAtIndex:1];
        NSString* pAnsOne = [currentQuestion objectAtIndex:2];
        NSString* pAnsTwo = [currentQuestion objectAtIndex:3];
        NSString* pAnsThree = [currentQuestion objectAtIndex:4];
        NSString* pAnsFour = [currentQuestion objectAtIndex:5];
        [nextQuestion setParameters: question :answer :pAnsOne :pAnsTwo :pAnsThree :pAnsFour];
        [self.remainingQuestionParameters removeObject:currentQuestion];
        [nextQuestion setRemainingQuestions:self.remainingQuestionParameters];
        [nextQuestion setCurrentScore:self.score];
        [nextQuestion setResultList:self.result];
        
        [self.navigationController pushViewController:nextQuestion animated:YES];
    }
    else
    {
        SummaryController* summaryView = [self.storyboard instantiateViewControllerWithIdentifier:@"Summary"];
        [summaryView setCurrentScore:self.score];
        [summaryView setQuestionState:self.result];
        
        [self.navigationController pushViewController:summaryView animated:YES];
    }
}

-(void)checkAnswer:(UIButton*)sender
{
    NSString* possibleAns;
    
    switch (sender.tag)
    {
        case 1:
            possibleAns = self.pAnsOne;
            break;
        case 2:
            possibleAns = self.pAnsTwo;
            break;
        case 3:
            possibleAns = self.pAnsThree;
            break;
        case 4:
            possibleAns = self.pAnsFour;
            break;
            
        default:
            break;
    }
    
    NSMutableArray* currentQuestionState;
    if([possibleAns isEqualToString:self.answer])
    {
        if(self.isFirstTryCorrect)
        {
            self.score = self.score + 1;
            currentQuestionState = [NSMutableArray arrayWithObjects:self.question,self.answer,@"TRUE", nil];
        }
        else
        {
            currentQuestionState = [NSMutableArray arrayWithObjects:self.question,self.answer,@"FALSE",nil];
        }
        
        [self.result addObject:currentQuestionState];
        [self goNext];
    }
    else
    {
        self.isFirstTryCorrect = NO;
        
        sender.layer.borderColor = [UIColor redColor].CGColor;
    }
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
