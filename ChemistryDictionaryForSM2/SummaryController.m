//
//  SummaryController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 14/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "SummaryController.h"

@interface SummaryController ()

@property(nonatomic,readwrite)int score;
@property(nonatomic,readwrite)NSMutableArray* allQuestionState;

@property(strong,nonatomic)UIView* scoreView;
@property(strong,nonatomic)UILabel* scoreTitleView;
@property(strong, nonatomic)UILabel* scoreContentView;
@property(strong, nonatomic)UITableView* resultView;

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@end

@implementation SummaryController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
}

-(void)setCurrentScore:(int)myScore
{
    self.score = myScore;
}

-(void)setQuestionState:(NSMutableArray*)allState
{
    self.allQuestionState = [NSMutableArray arrayWithArray:allState];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self initializeScoreView];
    [self initializeResultListView];
}

-(void)initializeScoreView
{
    self.scoreView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 165.0)/2, self.ViewOrigin.y + 10.0, 200.0, 60.0)];
    
    self.scoreTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, 120.0, 60.0)];
    [self.scoreTitleView setTextAlignment:NSTextAlignmentCenter];
    [self.scoreTitleView setBackgroundColor:[UIColor clearColor]];
    [self.scoreTitleView setTextColor:[UIColor blackColor]];
    [self.scoreTitleView setFont:[UIFont systemFontOfSize:20.0]];
    [self.scoreTitleView setText:@"Your Score: "];
    
    self.scoreContentView = [[UILabel alloc]initWithFrame:CGRectMake(120.0, 0.0, 45.0, 60.0)];
    [self.scoreContentView setTextAlignment:NSTextAlignmentCenter];
    [self.scoreContentView setBackgroundColor:[UIColor clearColor]];
    if(self.score < 5)
    {
        [self.scoreContentView setTextColor:[UIColor redColor]];
    }
    else
    {
        [self.scoreContentView setTextColor:[UIColor greenColor]];
    }
    [self.scoreContentView setFont:[UIFont systemFontOfSize:20.0]];
    [self.scoreContentView setText:[NSString stringWithFormat:@"%d/10",self.score]];
    
    [self.scoreView addSubview:self.scoreTitleView];
    [self.scoreView addSubview:self.scoreContentView];
    [self.view addSubview:self.scoreView];
}

-(void)initializeResultListView
{
    self.resultView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    CGRect frame = self.resultView.frame;
    frame.origin.x = self.ViewOrigin.x;
    frame.origin.y = self.scoreView.frame.origin.y + self.scoreView.frame.size.height + 10.0;
    frame.size.width = self.ViewSize.width;
    frame.size.height = 300.0;
    
    self.resultView.frame = frame;
    
    self.resultView.rowHeight = 30.0;
    self.resultView.scrollEnabled = YES;
    self.resultView.showsVerticalScrollIndicator = YES;
    self.resultView.userInteractionEnabled = YES;
    self.resultView.bounces = YES;
    self.resultView.delegate = self;
    self.resultView.dataSource = self;
    [self.resultView dequeueReusableCellWithIdentifier:@"Cell"];
    
    [self.view addSubview:self.resultView];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel* english = nil;
    UILabel* chinese = nil;

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        english = [[UILabel alloc]init];
        english.tag = 1;
        
        chinese = [[UILabel alloc]init];
        chinese.tag = 2;
        
        [cell.contentView addSubview:english];
        [cell.contentView addSubview:chinese];
    }
    else
    {
        english = (UILabel*)[cell.contentView viewWithTag:1];
        chinese = (UILabel*)[cell.contentView viewWithTag:2];
    }
    
    english.frame = CGRectMake(10.0, 0.0, cell.contentView.frame.size.width / 2, 30.0);
    [english setBackgroundColor:[UIColor clearColor]];
    english.font = [UIFont boldSystemFontOfSize:12.5];
    NSMutableString* englishContent = [[NSMutableString alloc]initWithString:[[self.allQuestionState objectAtIndex:indexPath.row]objectAtIndex:1]];

    english.text = englishContent;
        [english setTextAlignment:NSTextAlignmentLeft];
    
    
    chinese.frame = CGRectMake(cell.contentView.frame.size.width / 2.0, 0.0, cell.contentView.frame.size.width / 2.0 - 10.0, 30.0);
    [chinese setBackgroundColor:[UIColor clearColor]];
    chinese.font = [UIFont boldSystemFontOfSize:12.5];
    NSMutableString* chineseContent = [[NSMutableString alloc]initWithString:[[self.allQuestionState objectAtIndex:indexPath.row]objectAtIndex:0]];
    
    chinese.text = chineseContent;
    [chinese setTextAlignment:NSTextAlignmentRight];
    
    if([[[self.allQuestionState objectAtIndex:indexPath.row]objectAtIndex:2]isEqualToString:@"FALSE"])
    {
        [english setTextColor:[UIColor redColor]];
        [chinese setTextColor:[UIColor redColor]];
    }
    
    return cell;
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
