//
//  FrontPageController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 21/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "FrontPageController.h"
#import "Constant.h"

@interface FrontPageController ()

@end

@implementation FrontPageController

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
    [self addSubviews];
}

- (void)addSubviews
{
    UIImage* titleLogo = [UIImage imageNamed:TITLE_LOGO];
    UIImage* nusLogo = [UIImage imageNamed:NUS_LOGO];
    
    UIImageView* titleLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - titleLogo.size.width/2.5) / 2, self.view.frame.size.height / 6, titleLogo.size.width / 2.5, titleLogo.size.height / 2.5)];
    
    UIImageView* nusLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - nusLogo.size.width/2.5) / 2, self.view.frame.size.height - nusLogo.size.height / 2.5, nusLogo.size.width / 2.5, nusLogo.size.height / 2.5)];
    
    [titleLogoView setImage:titleLogo];
    [nusLogoView setImage:nusLogo];
    
    titleLogoView.userInteractionEnabled = YES;
    nusLogoView.userInteractionEnabled = YES;
    
    [[self view]addSubview:titleLogoView];
    [[self view]addSubview:nusLogoView];
    
    UISwipeGestureRecognizer* swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [[self view]addGestureRecognizer:swipeLeftGestureRecognizer];
    
    UITapGestureRecognizer* singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [titleLogoView addGestureRecognizer:singleTapGestureRecognizer];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)handleSwipeLeft:(UIGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"FromFrontToInstruction" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
