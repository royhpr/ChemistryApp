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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self addSubViews];
    [self initializeNavbar];
}

-(void)initializeNavbar
{
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationItem.hidesBackButton = YES;
}

-(void)LogoutCurrentApp
{
    
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
    _viewHeight = [self view].frame.size.height - 80.0;
    _xAxisLeft = (([self view].frame.size.width / 2 - _periodicTable.size.width / 2) / 2);
    _xAxisRight = _xAxisLeft + [self view].frame.size.width / 2;
    _yAxisUp = ((_viewHeight / 2 - _periodicTable.size.height / 2) / 2);
    _yAxisDown = _yAxisUp + _viewHeight / 2;
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
    [_periodicLabel setTextAlignment:NSTextAlignmentCenter];
    
    _syllabusLabel.text = SYLLABUS_LABEL;
    _syllabusLabel.numberOfLines = 0;
    [_syllabusLabel setTextAlignment:NSTextAlignmentCenter];
    
    _searchDictionaryLabel.text = SEARCH_DIC_LABEL;
    _searchDictionaryLabel.numberOfLines = 0;
    [_searchDictionaryLabel setTextAlignment:NSTextAlignmentCenter];
    
    _quizLabel.text = QUIZ_LABEL;
    _quizLabel.numberOfLines = 0;
    [_quizLabel setTextAlignment:NSTextAlignmentCenter];
    
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
    switch (reconizer.view.tag)
    {
        case 0:
        case 4:
            
            break;
        case 1:
        case 5:
            [self performSegueWithIdentifier:@"FromMainToSyllabus" sender:self];
            break;
        case 2:
        case 6:
            
            break;
        case 3:
        case 7:
            
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
}

-(void)returnToMainInterface
{
    [self.navigationController popToViewController:self animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
