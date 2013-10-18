//
//  ViewController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 20/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"

@interface ViewController ()

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeNavbar];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self addSubViews];
}

-(void)initializeNavbar
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    CGRect frame = CGRectMake(0, 0, [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}].width, 44.0);
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = @"SM2 Chemistry";
}

- (void)initializeImage
{
    _periodicTable = [UIImage imageNamed:PERIODIC_IMAGE];
    _syllabus = [UIImage imageNamed:SYLLUBAS_IMAGE];
    _searchDictionary = [UIImage imageNamed:SEARCH_DIC_IMAGE];
    _quiz = [UIImage imageNamed:QUIZ_IMAGE];
}

- (void)initializeFactors
{
    _xAxisLeft = ((self.ViewSize.width / 2 - _periodicTable.size.width / 2) / 2);
    _xAxisRight = _xAxisLeft + self.ViewSize.width / 2;
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        _yAxisUp = self.ViewSize.height / 2 - _periodicTable.size.height / 2 - 60.0 + self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    else
    {
        _yAxisUp = self.ViewSize.height / 2 - _periodicTable.size.height / 2 - 60.0 + self.navigationController.navigationBar.frame.size.height;
    }
    _yAxisDown = _yAxisUp + _periodicTable.size.height / 2 + 60.0 + 20.0;
    _imageWidth = _periodicTable.size.width / 2;
    _imageHeight = _periodicTable.size.height / 2;
    
    
    _labelYAxisUp = _yAxisUp + _imageHeight;
    _labelYAxisDown = _yAxisDown + _imageHeight;
    _labelXAxisLeft = _xAxisLeft - (TITLE_WIDTH - _imageWidth) / 2;
    _labelXAxisRight = _xAxisRight - (TITLE_WIDTH - _imageWidth) / 2;
}

- (void)initializeViews
{
    _periodicTableView = [[UIImageView alloc]initWithFrame:CGRectMake(_xAxisLeft, _yAxisUp, _imageWidth, _imageHeight)];
    _syllabusView = [[UIImageView alloc]initWithFrame:CGRectMake(_xAxisRight, _yAxisUp, _imageWidth, _imageHeight)];
    _searchDictionaryView = [[UIImageView alloc]initWithFrame:CGRectMake(_xAxisLeft, _yAxisDown, _imageWidth, _imageHeight)];
    _quizView = [[UIImageView alloc]initWithFrame:CGRectMake(_xAxisRight, _yAxisDown, _imageWidth, _imageHeight)];
    
    [_periodicTableView setImage:_periodicTable];
    [_syllabusView setImage:_syllabus];
    [_searchDictionaryView setImage:_searchDictionary];
    [_quizView setImage:_quiz];
    
    _periodicTableView.userInteractionEnabled = YES;
    _syllabusView.userInteractionEnabled = YES;
    _searchDictionaryView.userInteractionEnabled = YES;
    _quizView.userInteractionEnabled = YES;
    
    _periodicTableView.tag = 0;
    _syllabusView.tag = 1;
    _searchDictionaryView.tag = 2;
    _quizView.tag = 3;
}

- (void)initializeLabels
{
    _periodicLabel = [[UILabel alloc]initWithFrame:CGRectMake(_labelXAxisLeft, _labelYAxisUp, TITLE_WIDTH, TITLE_HEIGHT)];
    _syllabusLabel = [[UILabel alloc]initWithFrame:CGRectMake(_labelXAxisRight, _labelYAxisUp, TITLE_WIDTH, TITLE_HEIGHT)];
    _searchDictionaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(_labelXAxisLeft, _labelYAxisDown, TITLE_WIDTH, TITLE_HEIGHT)];
    _quizLabel = [[UILabel alloc]initWithFrame:CGRectMake(_labelXAxisRight, _labelYAxisDown, TITLE_WIDTH, TITLE_HEIGHT)];
    
    _periodicLabel.text = PERIODIC_LABEL;
    _periodicLabel.numberOfLines = 0;
    [_periodicLabel sizeToFit];
    [_periodicLabel setTextAlignment:NSTextAlignmentCenter];
    _periodicLabel.frame = CGRectMake(_periodicTableView.frame.origin.x - (_periodicLabel.frame.size.width - _periodicTableView.frame.size.width)/2, _periodicLabel.frame.origin.y, _periodicLabel.frame.size.width, _periodicLabel.frame.size.height);
    
    _syllabusLabel.text = SYLLABUS_LABEL;
    _syllabusLabel.numberOfLines = 0;
    [_syllabusLabel sizeToFit];
    [_syllabusLabel setTextAlignment:NSTextAlignmentCenter];
    _syllabusLabel.frame = CGRectMake(_syllabusView.frame.origin.x + (_syllabusView.frame.size.width - _syllabusLabel.frame.size.width)/2.0, _syllabusLabel.frame.origin.y, _syllabusLabel.frame.size.width, _syllabusLabel.frame.size.height);
    
    _searchDictionaryLabel.text = SEARCH_DIC_LABEL;
    _searchDictionaryLabel.numberOfLines = 0;
    [_searchDictionaryLabel sizeToFit];
    [_searchDictionaryLabel setTextAlignment:NSTextAlignmentCenter];
    _searchDictionaryLabel.frame = CGRectMake(_searchDictionaryView.frame.origin.x - (_searchDictionaryLabel.frame.size.width - _searchDictionaryView.frame.size.width)/2, _searchDictionaryLabel.frame.origin.y, _searchDictionaryLabel.frame.size.width, _searchDictionaryLabel.frame.size.height);
    
    _quizLabel.text = QUIZ_LABEL;
    _quizLabel.numberOfLines = 0;
    [_quizLabel sizeToFit];
    [_quizLabel setTextAlignment:NSTextAlignmentCenter];
    _quizLabel.frame = CGRectMake(_quizView.frame.origin.x + (_quizView.frame.size.width - _quizLabel.frame.size.width)/2.0, _quizLabel.frame.origin.y, _quizLabel.frame.size.width, _quizLabel.frame.size.height);
    
    _periodicLabel.tag = 4;
    _syllabusLabel.tag = 5;
    _searchDictionaryLabel.tag = 6;
    _quizLabel.tag = 7;
}

- (void)addGestureRecognizer
{
    [_syllabusView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_periodicTableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_searchDictionaryView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_quizView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
   
    [_periodicLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_syllabusLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_searchDictionaryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
    [_quizLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)]];
}

- (void)addSubViews
{
    [self initializeImage];
    
    [self initializeFactors];
    
    [self initializeViews];
    
    [self initializeLabels];
    
    [self addGestureRecognizer];
    
    
    [[self view]addSubview:_periodicTableView];
    [[self view]addSubview:_syllabusView];
    [[self view]addSubview:_searchDictionaryView];
    [[self view]addSubview:_quizView];
    
    [[self view]addSubview:_periodicLabel];
    [[self view]addSubview:_syllabusLabel];
    [[self view]addSubview:_searchDictionaryLabel];
    [[self view]addSubview:_quizLabel];
}

-(void)handleSingleTap:(UITapGestureRecognizer*)reconizer
{
    CustomNavigationController *newNavigtionController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeriodicTableViewNav"];

    switch (reconizer.view.tag)
    {
        case 0:
        case 4:
            [self.navigationController presentViewController:newNavigtionController animated:NO completion:NULL];
            break;
        case 1:
        case 5:
            [self performSegueWithIdentifier:@"FromMainToSyllabus" sender:self];
            break;
        case 2:
        case 6:
            [self performSegueWithIdentifier:@"FromMainToDictionary" sender:self];
            break;
        case 3:
        case 7:
            [self performSegueWithIdentifier:@"FromMainToQuiz" sender:self];
            break;
            
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromMainToSyllabus"])
    {
        SyllabusController* syllabus = [segue destinationViewController];
        syllabus.delegate = self;
    }
    else if([[segue identifier] isEqualToString:@"FromMainToDictionary"])
    {
        DictionaryController* dictionary = [segue destinationViewController];
        dictionary.delegate = self;
    }
}

-(void)returnToMainInterface
{
    [self.navigationController popToViewController:self animated:YES];
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
        
        self.ViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height);
    }
    else
    {
        self.ViewOrigin = self.view.frame.origin;
        
        self.ViewSize = self.view.frame.size;
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
