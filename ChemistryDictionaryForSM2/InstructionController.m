//
//  InstructionController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 21/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "InstructionController.h"
#import "Constant.h"

@interface InstructionController ()

@end

@implementation InstructionController

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
	// Do any additional setup after loading the view.
    [self addSubViews];
}

-(void)addSubViews
{
    UIImage* englishVersion = [UIImage imageNamed:ENGLISH_VERSION];
    UIImage* chineseVersion = [UIImage imageNamed:CHINESE_VERSION];
    UIImage* contributor = [UIImage imageNamed:CONTRIBUTORS];
    
    UIImageView* englishVersionView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - englishVersion.size.width/SCALE_DOWN_FACTOR) / 2, 0.0, englishVersion.size.width/SCALE_DOWN_FACTOR, englishVersion.size.height/SCALE_DOWN_FACTOR)];
    UIImageView* chineseVersionView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - chineseVersion.size.width/SCALE_DOWN_FACTOR) / 2, englishVersion.size.height/SCALE_DOWN_FACTOR, chineseVersion.size.width/SCALE_DOWN_FACTOR, chineseVersion.size.height/SCALE_DOWN_FACTOR)];
    UIImageView* contributorView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - contributor.size.width/SCALE_DOWN_FACTOR) / 2, self.view.frame.size.height - contributor.size.height/SCALE_DOWN_FACTOR - ELEMENT_COMPONENT_GAP, contributor.size.width/SCALE_DOWN_FACTOR, contributor.size.height/SCALE_DOWN_FACTOR)];
    
    [englishVersionView setImage:englishVersion];
    [chineseVersionView setImage:chineseVersion];
    [contributorView setImage:contributor];
 
    
    [[self view]addSubview:englishVersionView];
    [[self view]addSubview:chineseVersionView];
    [[self view]addSubview:contributorView];
    
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [[self view]addGestureRecognizer:swipeLeftGestureRecognizer];
}

- (void)handleSwipeLeft:(UIGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"FromInstructionToMain" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
