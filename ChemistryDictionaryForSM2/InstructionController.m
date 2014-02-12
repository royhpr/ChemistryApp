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
    UIImage* instructionImage = [UIImage imageNamed:INSTRUCTION_IMAGE];
    float widthFactor = instructionImage.size.width / self.ViewSize.width;
    float heightFactor = instructionImage.size.height / self.ViewSize.height;
    float scaleFactor = widthFactor > heightFactor ? widthFactor:heightFactor;
    
    UIImageView* instructionView = [[UIImageView alloc]initWithFrame:CGRectZero];
    instructionView.frame = CGRectMake(self.ViewOrigin.x, (self.ViewSize.height-instructionImage.size.height/scaleFactor)/2.0 + self.navigationController.navigationBar.frame.size.height, instructionImage.size.width/scaleFactor, instructionImage.size.height/scaleFactor);
    
    [instructionView setImage:instructionImage];
    [[self view]addSubview:instructionView];
    
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
