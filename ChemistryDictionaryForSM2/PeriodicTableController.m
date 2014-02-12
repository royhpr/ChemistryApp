//
//  PeriodicTableController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 5/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "PeriodicTableController.h"

@interface PeriodicTableController ()

@property(strong,nonatomic)UIImageView* home;
@property(strong,nonatomic)UIImageView* periodicTableImageView;

@property(nonatomic,readwrite)CGFloat widthUnit;
@property(nonatomic,readwrite)CGFloat heightUnit;
@property(nonatomic,readwrite)int elementOrder;
@property(nonatomic,readwrite)int touchedElementCoordinateX;
@property(nonatomic,readwrite)int touchedElementCoordinateY;

@property(nonatomic,readwrite)NSMutableArray* periodicTableElementList;
@property(nonatomic,readwrite)DictionaryDB* database;
@property(nonatomic,readwrite)PeriodicTableElementModel* tappedElement;

@property(nonatomic,readwrite)UIPinchGestureRecognizer* pinchRecognizer;
@property(nonatomic,readwrite)UITapGestureRecognizer* singleTapRecognizer;
@property(nonatomic,readwrite)UITapGestureRecognizer* doubleTapRecognizer;

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@property(strong,nonatomic)UIImage* scrollViewImage;

@end

@implementation PeriodicTableController

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
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    self.navigationItem.hidesBackButton = YES;
    
    self.home =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    self.home.frame=CGRectMake(0, 0, 30.0, 30.0);
    self.home.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* homeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMainInterface)];
    [homeTap setNumberOfTapsRequired:1];
    [self.home addGestureRecognizer:homeTap];
    
    UIBarButtonItem* homeButton = [[UIBarButtonItem alloc]initWithCustomView:self.home];
    self.navigationItem.rightBarButtonItem = homeButton;
   
    //set up left item
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    title.font = [UIFont boldSystemFontOfSize:20.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    title.text = @"Periodic Table 周期表";
    UIBarButtonItem* leftNavButton = [[UIBarButtonItem alloc]initWithCustomView:title];
    self.navigationItem.leftBarButtonItem = leftNavButton;
    
    [self initializeDatabase];
}

-(void)initializeDatabase
{
    self.periodicTableElementList = [[NSMutableArray alloc]init];
    self.periodicTableElementList = [NSMutableArray arrayWithArray:[[DictionaryDB database]periodicTableElementList]];
}


-(void)searchTappedElement
{
    NSString* elementAtomicNumber = [NSString stringWithFormat:@"%d",self.elementOrder];
    BOOL isExist = NO;
    
    
    for(PeriodicTableElementModel* currentElement in self.periodicTableElementList)
    {
        if([currentElement.atomicNumber isEqualToString:elementAtomicNumber] && [currentElement.atomicNumber intValue] <= 40)
        {
            self.tappedElement = currentElement;
            isExist = YES;
            break;
        }
    }
    
    if(isExist)
    {
        [self performSegueWithIdentifier:@"FromPeriodicTableToElement" sender:self];
        
    }
    else
    {
        UIAlertView* nonExistMsg = [[UIAlertView alloc] initWithTitle:@"" message:@"Only Atomic Numbers 1 - 40 are available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [nonExistMsg show];
        [self performSelector:@selector(dismissCurrentMessage:) withObject:nonExistMsg afterDelay:5.0];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromPeriodicTableToElement"])
    {
        CustomNavigationController* elementController = [segue destinationViewController];
        [(PeriodicTableElementController*)elementController.topViewController setElementParameters:self.tappedElement];
    }
}

-(void)dismissCurrentMessage:(UIAlertView*)currentMessage
{
    [currentMessage dismissWithClickedButtonIndex:-1 animated:YES];
}

- (void)computeTheUnitSize
{
    CGFloat screenWidth = self.periodicTableImageView.frame.size.width;
    CGFloat screenHeight = self.periodicTableImageView.frame.size.height;
    
    self.widthUnit = screenWidth/18.0;
    self.heightUnit = screenHeight/10.0;
}

-(void)showElementList
{
    [self performSegueWithIdentifier:@"FromPeriodicTableToElementListView" sender:self];
}

- (void)checkFirstRow
{
    if(self.touchedElementCoordinateX == 18)
    {
        self.elementOrder = 2;
        [self searchTappedElement];
    }
    else if(self.touchedElementCoordinateX == 1)
    {
        self.elementOrder = 1;
        [self searchTappedElement];
    }
    else if(self.touchedElementCoordinateX >=4 && self.touchedElementCoordinateX <= 11)
    {
        [self showElementList];
    }
    else
    {
        return;
    }
}

-(void)checkSecondRow
{
    if(self.touchedElementCoordinateX == 1 || self.touchedElementCoordinateX == 2)
    {
        self.elementOrder = 2 + self.touchedElementCoordinateX;
        [self searchTappedElement];
    }
    else if(self.touchedElementCoordinateX >= 13 && self.touchedElementCoordinateX <= 18)
    {
        self.elementOrder = 2 + self.touchedElementCoordinateX - 10;
        [self searchTappedElement];
    }
    else if(self.touchedElementCoordinateX >=4 && self.touchedElementCoordinateX <= 11)
    {
        [self showElementList];
    }
    else
    {
        return;
    }
}

-(void)checkthirdRow
{
    if(self.touchedElementCoordinateX == 1 || self.touchedElementCoordinateX ==2)
    {
        self.elementOrder = 10 + self.touchedElementCoordinateX;
        [self searchTappedElement];
    }
    else if(self.touchedElementCoordinateX >= 13 && self.touchedElementCoordinateX <= 18)
    {
        self.elementOrder = self.touchedElementCoordinateX;
        [self searchTappedElement];
    }
    else
    {
        return;
    }
}

-(void)checkForthRow
{
    self.elementOrder = 18 + self.touchedElementCoordinateX;
    [self searchTappedElement];
}

-(void)checkFifthRow
{
    self.elementOrder = 36 + self.touchedElementCoordinateX;
    [self searchTappedElement];
}

-(void)checkSixthRow
{
    if(self.touchedElementCoordinateX == 1 || self.touchedElementCoordinateX == 2)
    {
        self.elementOrder = 54 + self.touchedElementCoordinateX;
    }
    else
    {
        self.elementOrder = 70 + self.touchedElementCoordinateX - 2;
    }
    [self searchTappedElement];
}

-(void)checkSeventhRow
{
    if(self.touchedElementCoordinateX == 1 || self.touchedElementCoordinateX ==2)
    {
        self.elementOrder = 86 + self.touchedElementCoordinateX;
    }
    else
    {
        self.elementOrder = 102 + self.touchedElementCoordinateX - 2;
    }
    [self searchTappedElement];
}

-(void)checkNinethRow
{
    if(self.touchedElementCoordinateX >= 3 && self.touchedElementCoordinateX <= 16)
    {
        self.elementOrder = 56 + self.touchedElementCoordinateX - 2;
        [self searchTappedElement];
    }
    else
    {
        return;
    }
}

-(void)checkTenthRow
{
    if(self.touchedElementCoordinateX >= 3 && self.touchedElementCoordinateX <= 16)
    {
        self.elementOrder = 88 + self.touchedElementCoordinateX - 2;
        [self searchTappedElement];
    }
    else
    {
        return;
    }
}

-(void)zoomOutToNormalSize:(UITapGestureRecognizer*)recognizer
{
    self.periodicTableScrollView.zoomScale = self.periodicTableScrollView.minimumZoomScale;
}

-(void)showSpecificElement:(UITapGestureRecognizer*)recognizer
{
    CGPoint currentTouchPoint = [recognizer locationInView:self.periodicTableScrollView];
    [self computeTheUnitSize];
    
    self.touchedElementCoordinateX = currentTouchPoint.x/self.widthUnit + 1;
    self.touchedElementCoordinateY = currentTouchPoint.y/self.heightUnit + 1;
    
    switch (self.touchedElementCoordinateY)
    {
        case 1:
            [self checkFirstRow];
            break;
        case 2:
            [self checkSecondRow];
            break;
        case 3:
            [self checkthirdRow];
            break;
        case 4:
            [self checkForthRow];
            break;
        case 5:
            [self checkFifthRow];
            break;
        case 6:
            [self checkSixthRow];
            break;
        case 7:
            [self checkSeventhRow];
            break;
        case 8:
    
            break;
        case 9:
            [self checkNinethRow];
            break;
        case 10:
            [self checkTenthRow];
            break;
            
        default:
            break;
    }
}

-(void)goBackToMainInterface
{
    ViewController *mainInterface = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    CustomNavigationController *MainNavigtionController = [[CustomNavigationController alloc] initWithRootViewController:mainInterface];
    
    [self.navigationController presentViewController:MainNavigtionController animated:NO completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configureInterfaceView];
    [self initializeBackgroundView];
    [self scaleScrollViewContent];
    [self centerScrollViewContents];
}

- (void)scaleScrollViewContent
{
    self.periodicTableScrollView.minimumZoomScale = 1.0;
    
    self.periodicTableScrollView.maximumZoomScale = 4.0;
    self.periodicTableScrollView.zoomScale = 1.0;
}

-(void)initializeBackgroundView
{
    CGRect frame = self.periodicTableScrollView.frame;
    frame.origin = self.ViewOrigin;
    frame.size = self.ViewSize;
    self.periodicTableScrollView.frame = frame;
    
    self.scrollViewImage = [UIImage imageNamed:@"fullperiodictable.jpg"];
    self.periodicTableImageView = [[UIImageView alloc] initWithImage:self.scrollViewImage];
    self.periodicTableImageView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=self.periodicTableScrollView.frame.size};
    self.periodicTableImageView.userInteractionEnabled = YES;
    
    [self.periodicTableScrollView setContentSize:CGSizeMake(self.scrollViewImage.size.width,self.scrollViewImage.size.height)];
    [self.periodicTableScrollView addSubview:self.periodicTableImageView];
    
    self.pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.periodicTableScrollView addGestureRecognizer:self.pinchRecognizer];
    
    self.singleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSpecificElement:)];
    [self.singleTapRecognizer setNumberOfTapsRequired:1];
    [self.periodicTableScrollView addGestureRecognizer:self.singleTapRecognizer];
    
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOutToNormalSize:)];
    [self.doubleTapRecognizer setNumberOfTapsRequired:2];
    [self.periodicTableImageView addGestureRecognizer:self.doubleTapRecognizer];
    
    [self.singleTapRecognizer requireGestureRecognizerToFail:self.doubleTapRecognizer];
}

- (void)centerScrollViewContents
{
    CGSize scrollViewSize = self.periodicTableScrollView.frame.size;
    CGRect contentsFrame = self.periodicTableImageView.frame;
    
    if (contentsFrame.size.width < scrollViewSize.width)
    {
        contentsFrame.origin.x = (scrollViewSize.width - contentsFrame.size.width) / 2.0f;
    }
    else
    {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < scrollViewSize.height)
    {
        contentsFrame.origin.y = (scrollViewSize.height - contentsFrame.size.height) / 2.0f;
    }
    else
    {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.periodicTableImageView.frame = contentsFrame;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.periodicTableImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // The scroll view has zoomed, so you need to re-center the contents
    [self centerScrollViewContents];
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.width);
        
        self.ViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.width);
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
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    return UIInterfaceOrientationLandscapeRight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
