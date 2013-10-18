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
    [self addSubviews];
}

- (void)addSubviews
{
    UIImage* titleLogo = [UIImage imageNamed:TITLE_LOGO];
    UIImage* nusLogo = [UIImage imageNamed:NUS_LOGO];
    UIImage* facultyLogo = [UIImage imageNamed:@"facultyinfo.png"];
    
    UIImageView* titleLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - titleLogo.size.width/2.5) / 2, self.view.frame.size.height / 6, titleLogo.size.width / 2.5, titleLogo.size.height / 2.5)];
    
    UIImageView* nusLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - nusLogo.size.width/2.5) / 2, titleLogoView.frame.origin.y + titleLogoView.frame.size.height + 80.0, nusLogo.size.width / 2.5, nusLogo.size.height / 2.5)];
    
    UIImageView* facultyLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - facultyLogo.size.width/2.5) / 2, nusLogoView.frame.origin.y + nusLogoView.frame.size.height, facultyLogo.size.width / 2.5, facultyLogo.size.height / 2.5)];
    
    [titleLogoView setImage:titleLogo];
    [nusLogoView setImage:nusLogo];
    [facultyLogoView setImage:facultyLogo];
    
    titleLogoView.userInteractionEnabled = YES;
    nusLogoView.userInteractionEnabled = YES;
    facultyLogoView.userInteractionEnabled = YES;
    
    [[self view]addSubview:titleLogoView];
    [[self view]addSubview:nusLogoView];
    [[self view]addSubview:facultyLogoView];
    
    UITapGestureRecognizer* singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNext:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)goNext:(UIGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"FromFrontToInstruction" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


@end
