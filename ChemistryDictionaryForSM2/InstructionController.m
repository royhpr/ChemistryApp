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

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

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
}

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self addSubViews];
}

-(void)addSubViews
{
    UIImage* englishVersion = [UIImage imageNamed:ENGLISH_VERSION];
    UIImage* chineseVersion = [UIImage imageNamed:CHINESE_VERSION];
    UIImage* contributor = [UIImage imageNamed:CONTRIBUTORS];
    
    UIImageView* englishVersionView = [[UIImageView alloc]initWithFrame:CGRectMake((self.ViewSize.width - englishVersion.size.width/SCALE_DOWN_FACTOR) / 2, self.ViewOrigin.y + 10.0, englishVersion.size.width/SCALE_DOWN_FACTOR, englishVersion.size.height/SCALE_DOWN_FACTOR)];
    UIImageView* chineseVersionView = [[UIImageView alloc]initWithFrame:CGRectMake((self.ViewSize.width - chineseVersion.size.width/SCALE_DOWN_FACTOR) / 2, englishVersionView.frame.origin.y + englishVersionView.frame.size.height + 10.0, chineseVersion.size.width/SCALE_DOWN_FACTOR, chineseVersion.size.height/SCALE_DOWN_FACTOR)];
    UIImageView* contributorView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - contributor.size.width/SCALE_DOWN_FACTOR) / 2, self.view.frame.size.height - contributor.size.height/SCALE_DOWN_FACTOR - ELEMENT_COMPONENT_GAP, contributor.size.width/SCALE_DOWN_FACTOR, contributor.size.height/SCALE_DOWN_FACTOR)];
    
    [englishVersionView setImage:englishVersion];
    [chineseVersionView setImage:chineseVersion];
    [contributorView setImage:contributor];
 
    
    [[self view]addSubview:englishVersionView];
    [[self view]addSubview:chineseVersionView];
    [[self view]addSubview:contributorView];
    
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNext:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    
    [[self view]addGestureRecognizer:tapGestureRecognizer];
}

- (void)goNext:(UIGestureRecognizer*)recognizer
{
    [self performSegueWithIdentifier:@"FromInstructionToMain" sender:self];
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + [UIApplication sharedApplication].statusBarFrame.size.height);
        
        self.ViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
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
