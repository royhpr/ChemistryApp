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

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

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
    
    [self performSelector:@selector(progressToNextView) withObject:self afterDelay:3.0];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self addSubviews];
}

-(void)progressToNextView
{
    [self performSegueWithIdentifier:@"FromFrontToInstruction" sender:self];
}


- (void)addSubviews
{
//    UIImage* titleLogo = [UIImage imageNamed:TITLE_LOGO];
//    UIImage* nusLogo = [UIImage imageNamed:NUS_LOGO];
//    UIImage* facultyLogo = [UIImage imageNamed:@"facultyinfo.png"];
//    
//    UIImageView* titleLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - titleLogo.size.width/8.0) / 2, self.view.frame.size.height / 6, titleLogo.size.width / 8.0, titleLogo.size.height / 8.0)];
//    
//    UIImageView* nusLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - nusLogo.size.width/2.5) / 2, titleLogoView.frame.origin.y + titleLogoView.frame.size.height + 80.0, nusLogo.size.width / 2.5, nusLogo.size.height / 2.5)];
//    
//    UIImageView* facultyLogoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - facultyLogo.size.width/2.5) / 2, nusLogoView.frame.origin.y + nusLogoView.frame.size.height, facultyLogo.size.width / 2.5, facultyLogo.size.height / 2.5)];
//    
//    [titleLogoView setImage:titleLogo];
//    [nusLogoView setImage:nusLogo];
//    [facultyLogoView setImage:facultyLogo];
//    
//    titleLogoView.userInteractionEnabled = YES;
//    nusLogoView.userInteractionEnabled = YES;
//    facultyLogoView.userInteractionEnabled = YES;
    
//    [[self view]addSubview:titleLogoView];
//    [[self view]addSubview:nusLogoView];
//    [[self view]addSubview:facultyLogoView];
    
    UIImage* frontPageImage = [UIImage imageNamed:@"frontpage.png"];
    float widthFactor = frontPageImage.size.width / self.ViewSize.width;
    float heightFactor = frontPageImage.size.height / self.ViewSize.height;
    float scaleFactor = widthFactor > heightFactor ? widthFactor:heightFactor;
    
    UIImageView* instructionView = [[UIImageView alloc]initWithFrame:CGRectZero];
    instructionView.frame = CGRectMake(self.ViewOrigin.x, (self.ViewSize.height-frontPageImage.size.height/scaleFactor)/2.0 + self.navigationController.navigationBar.frame.size.height, frontPageImage.size.width/scaleFactor, frontPageImage.size.height/scaleFactor);
    
    [instructionView setImage:frontPageImage];
    [[self view]addSubview:instructionView];

    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)goNext:(UIGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"FromFrontToInstruction" sender:self];
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height);
        
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
