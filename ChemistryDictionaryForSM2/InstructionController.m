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
    
//    UIImageView* instructionView = [[UIImageView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, self.ViewOrigin.y + 5.0, instructionImage.size.width/scaleFactor, instructionImage.size.height/scaleFactor)];
    UIImageView* instructionView = [[UIImageView alloc]initWithFrame:CGRectZero];
    instructionView.frame = CGRectMake(self.ViewOrigin.x, (self.ViewSize.height-instructionImage.size.height/scaleFactor)/2.0, instructionImage.size.width/scaleFactor, instructionImage.size.height/scaleFactor);
    
    [instructionView setImage:instructionImage];
    [[self view]addSubview:instructionView];
    
    UITapGestureRecognizer* tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goNext:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    
    [[self view]addGestureRecognizer:tapGestureRecognizer];
//    UIImage* chineseVersion = [UIImage imageNamed:CHINESE_VERSION];
//    UIImage* contributor = [UIImage imageNamed:CONTRIBUTORS];
//    float chineseHeight = chineseVersion.size.height * self.ViewSize.width / chineseVersion.size.width;
//    float englishHeight = englishVersion.size.height * self.ViewSize.width / englishVersion.size.width;
//    float contributorWidth = self.ViewSize.width * 3 / 4;
//    float contributorHeight = contributor.size.height * contributorWidth / contributor.size.width;
    
    
    
    
//    UIImageView* chineseVersionView = [[UIImageView alloc]initWithFrame:CGRectMake(self.ViewOrigin.x, englishVersionView.frame.origin.y + englishVersionView.frame.size.height + 5.0, self.ViewSize.width, chineseHeight)];
//    
//    UILabel* nextViewInstruction = [[UILabel alloc]initWithFrame:CGRectZero];
//    nextViewInstruction.text = @"Tap screen to continue";
//    [nextViewInstruction setTextColor:[UIColor lightGrayColor]];
//    [nextViewInstruction sizeToFit];
//    
//    CGRect frame = nextViewInstruction.frame;
//    frame.origin.x = (self.ViewSize.width - frame.size.width) / 2;
//    frame.origin.y = chineseVersionView.frame.origin.y + chineseVersionView.frame.size.height + 3.0;
//    nextViewInstruction.frame = frame;
//    
//    UIImageView* contributorView = [[UIImageView alloc]initWithFrame:CGRectMake((self.ViewSize.width - contributorWidth)/2.0, self.view.frame.size.height - contributorHeight - 5.0, contributorWidth, contributorHeight)];
//    
//    [englishVersionView setImage:englishVersion];
//    [chineseVersionView setImage:chineseVersion];
//    [contributorView setImage:contributor];
 
    
    
//    [[self view]addSubview:chineseVersionView];
//    [[self view]addSubview:nextViewInstruction];
//    [[self view]addSubview:contributorView];
    
    
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
