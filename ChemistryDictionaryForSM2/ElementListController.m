//
//  ElementListController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 12/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ElementListController.h"

@interface ElementListController ()

@end

@implementation ElementListController

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
	
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    
    UIView* rightItems = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 65, 30)];
    rightItems.userInteractionEnabled = YES;
    
    //back
    UIImageView* backView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backView.frame=CGRectMake(0, 0, 30, 30);
    backView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToTable)];
    [singleTapBack setNumberOfTapsRequired:1];
    [backView addGestureRecognizer:singleTapBack];
    
    //home
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(35, 0, 30, 30);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapHome = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMain)];
    [singleTapHome setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTapHome];
    
    //add to view items
    [rightItems addSubview:backView];
    [rightItems addSubview:homeView];
    
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:rightItems];
    self.navigationItem.rightBarButtonItem = navButton;
    
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
}

-(void)goBackToMain
{
    ViewController *portraitViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    CustomNavigationController *newNavigtionController = [[CustomNavigationController alloc] initWithRootViewController:portraitViewController];
    
    [self.navigationController presentViewController:newNavigtionController animated:NO completion:nil];
}

-(void)goBackToTable
{
    CustomNavigationController *newNavigtionController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeriodicTableViewNav"];
    
    [self.navigationController presentViewController:newNavigtionController animated:NO completion:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.currentScrollView.frame = self.view.frame;
    self.currentListWebView.frame = CGRectMake(-self.view.frame.size.width/2,0,self.view.frame.size.width*2.0,self.view.frame.size.height);
    self.currentScrollView.contentSize = self.currentListWebView.frame.size;
    
    self.currentScrollView.userInteractionEnabled = YES;
    self.currentListWebView.userInteractionEnabled = YES;
    
    [self.currentListWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"periodic_table_element" ofType:@"html"]isDirectory:NO]]];
    self.currentListWebView.scalesPageToFit = NO;
    
    //gesture
//    self.currentScrollView.contentSize = self.currentScrollView.frame.size;
//    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:nil];
//    
//    UITapGestureRecognizer* doubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomOut:)];
//    [doubleTapRecognizer setNumberOfTapsRequired:2];
//    [doubleTapRecognizer setNumberOfTouchesRequired:2];
//    
//    CGRect scrollViewFrame = self.currentScrollView.frame;
//    CGFloat scaleWidth = scrollViewFrame.size.width / self.currentScrollView.contentSize.width;
//    CGFloat scaleHeight = scrollViewFrame.size.height / self.currentScrollView.contentSize.height;
//    CGFloat minScale = MIN(scaleWidth, scaleHeight);
//    self.currentScrollView.minimumZoomScale = minScale;
//    self.currentScrollView.maximumZoomScale = 2.0f;
//    self.currentScrollView.zoomScale = 1.8f;
//    
//    [self.currentScrollView addGestureRecognizer:pinchRecognizer];
//    [self.currentScrollView addGestureRecognizer:doubleTapRecognizer];
}

-(void)zoomOut
{
    self.currentScrollView.zoomScale = 1.0;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.currentListWebView;
}


//All about interface orientation
- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
    return UIInterfaceOrientationLandscapeLeft;
}

//web view delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    // load error, hide the activity indicator in the status bar
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    
    NSString* errorString = [NSString stringWithFormat:
                             
                             @"<html><center><font size=+1 color='black'><br><br><br>An error occurred:<br>%@</font></center></html>",
                             
                             error.localizedDescription];
    
    [self.currentListWebView loadHTMLString:errorString baseURL:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
