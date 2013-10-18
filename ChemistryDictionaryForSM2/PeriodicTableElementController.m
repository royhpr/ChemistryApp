//
//  periodicTableElementController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 11/10/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "PeriodicTableElementController.h"

@interface PeriodicTableElementController ()

@property(nonatomic,strong)UILabel* chinese;
@property(nonatomic,strong)UIImageView* sound;
@property(nonatomic,strong)UILabel* pinyin;
@property(nonatomic,strong)UILabel* english;
@property(nonatomic,strong)UILabel* phanetic;
@property(nonatomic,strong)UILabel* description;
@property(nonatomic,strong)UILabel* physicalPropertyTitle;
@property(nonatomic,strong)UILabel* physicalPropertyBody;
@property(nonatomic,strong)UILabel* chemicalPropertyTitle;
@property(nonatomic,strong)UILabel* chemicalPropertyBody;
@property(nonatomic,strong)UIImageView* elementImage;

@property(nonatomic,strong)UIScrollView* mainScrollView;

@property(nonatomic,readwrite)CGPoint ViewOrigin;
@property(nonatomic,readwrite)CGSize ViewSize;

@end

@implementation PeriodicTableElementController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setElementParameters:(PeriodicTableElementModel*)currentElement
{

    self.element = currentElement;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.hidesBackButton = YES;
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    
    UIView* rightItems = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 40)];
    rightItems.userInteractionEnabled = YES;
    
    //back
    UIImageView* backView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backView.frame=CGRectMake(0, 0, 40, 40);
    backView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToTable)];
    [singleTapBack setNumberOfTapsRequired:1];
    [backView addGestureRecognizer:singleTapBack];
    
    //home
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(45, 0, 40, 40);
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

-(void)viewDidAppear:(BOOL)animated
{
    [self configureInterfaceView];
    [self initializeScrollView];
    [self initializeSubViews];
}

-(void)playSound
{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    CFURLRef soundFileURL;
    soundFileURL = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef)self.element.atomicNumber, CFSTR("mp3"), NULL);
    UInt32 soundID;
    AudioServicesCreateSystemSoundID(soundFileURL, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void)initializeScrollView
{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    self.mainScrollView.userInteractionEnabled = YES;
    
    [self.view addSubview:self.mainScrollView];
}

- (void)initializeChineseLabel
{
    self.chinese = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.ViewOrigin.y + ELEMENT_START_POSITION_Y, 50.0, 50.0)];
    self.chinese.text = self.element.chinese;
    self.chinese.font = [UIFont boldSystemFontOfSize:20.0];
    self.chinese.numberOfLines = 0;
    [self.chinese setTextAlignment:NSTextAlignmentCenter];
    [self.chinese sizeToFit];
    
    [self.mainScrollView addSubview:self.chinese];
}

- (void)initializeSoundImage
{
    UIImage* image = [UIImage imageNamed:@"audiobutton.jpg"];
    self.sound = [[UIImageView alloc]initWithFrame:CGRectMake(self.chinese.frame.origin.x + self.chinese.frame.size.width + 40.0, self.ViewOrigin.y + ELEMENT_START_POSITION_Y, image.size.width/SCALE_DOWN_FACTOR, image.size.height/SCALE_DOWN_FACTOR)];
    [self.sound setImage:image];
    
    self.sound.frame = CGRectMake(self.view.frame.size.width - ELEMENT_START_POSITION_X - self.sound.frame.size.width, self.sound.frame.origin.y, self.sound.frame.size.width, self.sound.frame.size.height);
    
    UITapGestureRecognizer* tapToPlaySound = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playSound)];
    tapToPlaySound.numberOfTapsRequired = 1;
    tapToPlaySound.numberOfTouchesRequired = 1;
    [self.sound addGestureRecognizer:tapToPlaySound];
    self.sound.userInteractionEnabled = YES;
    
    [self.mainScrollView addSubview:self.sound];
}

- (void)initializePinyin
{
    self.pinyin = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.chinese.frame.origin.y + self.chinese.frame.size.height + 5.0, 50.0, 50.0)];
    self.pinyin.text = self.element.pinyin;
    self.pinyin.font = [UIFont boldSystemFontOfSize:16.0];
    self.pinyin.numberOfLines = 0;
    [self.pinyin setTextAlignment:NSTextAlignmentCenter];
    [self.pinyin sizeToFit];
    
    if(self.pinyin.frame.size.width > self.chinese.frame.size.width)
    {
        self.chinese.frame = CGRectMake(self.chinese.frame.origin.x + ((self.pinyin.frame.size.width - self.chinese.frame.size.width)/2), self.chinese.frame.origin.y, self.chinese.frame.size.width, self.chinese.frame.size.height);
    }
    
    [self.mainScrollView addSubview:self.pinyin];
}

- (void)initializeEnglish
{
    self.english = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.pinyin.frame.origin.y + self.pinyin.frame.size.height + 10.0, 150.0, 150.0)];
    self.english.text = self.element.english;
    self.english.font = [UIFont boldSystemFontOfSize:20.0];
    self.english.numberOfLines = 0;
    [self.english setTextAlignment:NSTextAlignmentCenter];
    [self.english sizeToFit];
    
    [self.mainScrollView addSubview:self.english];
}

- (void)initializePhanetic
{
    self.phanetic = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.english.frame.origin.y + self.english.frame.size.height + 5.0, 200.0, 200.0)];
    self.phanetic.text = self.element.phanetic;
    self.phanetic.font = [UIFont boldSystemFontOfSize:16.0];
    self.phanetic.numberOfLines = 0;
    [self.phanetic setTextAlignment:NSTextAlignmentCenter];
    [self.phanetic sizeToFit];
    
    if(self.english.frame.size.width > self.phanetic.frame.size.width)
    {
        self.phanetic.frame = CGRectMake(self.phanetic.frame.origin.x + ((self.english.frame.size.width - self.phanetic.frame.size.width)/2), self.phanetic.frame.origin.y, self.phanetic.frame.size.width, self.phanetic.frame.size.height);
    }
    [self.mainScrollView addSubview:self.phanetic];
}

- (void)initializeDescription
{
    self.description = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.phanetic.frame.size.height + self.phanetic.frame.origin.y + 10.0, ELEMENT_DESCRIP_WIDTH, ELEMENT_DESCRIP_HEIGHT)];
    NSMutableString* description = [NSMutableString stringWithString:@"Atomic Number/原子序数: "];
    [description appendString:self.element.atomicNumber];
    [description appendString:NEW_LINE];
    [description appendString:@"Atomic Weight/原子量: "];
    [description appendString:self.element.atomicWeight];
    [description appendString:@" g/mol"];
    [description appendString:NEW_LINE];
    [description appendString:@"Electron Configuration/电子构型: "];
    [description appendString:self.element.electronConfig];
    [description appendString:NEW_LINE];
    [description appendString:NEW_LINE];
    self.description.text = description;
    self.description.numberOfLines = 0;
    [self.description setLineBreakMode:NSLineBreakByWordWrapping];
    [self.description setTextAlignment:NSTextAlignmentLeft];
    self.description.font = [UIFont fontWithName:APP_FONT size:13.0];
    [self.description sizeToFit];
    
    [self.mainScrollView addSubview:self.description];
}

- (void)initializePhysicalPropertyTitle
{
    self.physicalPropertyTitle = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.description.frame.origin.y + self.description.frame.size.height, 300.0, 30.0)];
    self.physicalPropertyTitle.text = @"Physical Properties/物理性质";
    self.physicalPropertyTitle.font = [UIFont boldSystemFontOfSize:16.0];
    self.physicalPropertyTitle.numberOfLines = 0;
    [self.physicalPropertyTitle sizeToFit];
    
    [self.mainScrollView addSubview:self.physicalPropertyTitle];
}

- (void)initializePhysicalPropertyBody
{
    self.physicalPropertyBody = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.physicalPropertyTitle.frame.size.height + self.physicalPropertyTitle.frame.origin.y, ELEMENT_DESCRIP_WIDTH, ELEMENT_DESCRIP_HEIGHT)];
    NSMutableString* descriptionPara2 = [NSMutableString stringWithString:@"Melting Point/熔点: "];
    [descriptionPara2 appendString:self.element.mp];
    [descriptionPara2 appendString:@" ℃"];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:@"Boiling Point/沸点: "];
    [descriptionPara2 appendString:self.element.bp];
    [descriptionPara2 appendString:@" ℃"];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:@"Heat of Fusion/熔化热: "];
    [descriptionPara2 appendString:self.element.heatFusion];
    [descriptionPara2 appendString:@" kJ/mol"];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:@"Heat of Vaporization/汽化热: "];
    [descriptionPara2 appendString:self.element.heatVaporization];
    [descriptionPara2 appendString:@" kJ/mol"];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:@"Density at 20 ℃/20 ℃的密度: "];
    [descriptionPara2 appendString:self.element.density];
    [descriptionPara2 appendString:@" g/cm^3"];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:@"Phase at Room Temperature/在室温下的相: "];
    [descriptionPara2 appendString:self.element.phase];
    [descriptionPara2 appendString: NEW_LINE];
    [descriptionPara2 appendString:@"Element Classification/元素分类: "];
    [descriptionPara2 appendString:self.element.elementClassification];
    [descriptionPara2 appendString:NEW_LINE];
    [descriptionPara2 appendString:NEW_LINE];
    self.physicalPropertyBody.text = descriptionPara2;
    self.physicalPropertyBody.numberOfLines = 0;
    [self.physicalPropertyBody setLineBreakMode:NSLineBreakByWordWrapping];
    [self.physicalPropertyBody setTextAlignment:NSTextAlignmentLeft];
    self.physicalPropertyBody.font = [UIFont fontWithName:APP_FONT size:13.0];
    [self.physicalPropertyBody sizeToFit];
    
    [self.mainScrollView addSubview:self.physicalPropertyBody];
}

-(void)initializeChemicalPropertyTitle
{
    self.chemicalPropertyTitle = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.physicalPropertyBody.frame.origin.y + self.physicalPropertyBody.frame.size.height, 300.0, 30.0)];
    self.chemicalPropertyTitle.text = @"Chemical Properties/化学性质";
    self.chemicalPropertyTitle.font = [UIFont boldSystemFontOfSize:16.0];
    self.chemicalPropertyTitle.numberOfLines = 0;
    [self.chemicalPropertyTitle sizeToFit];
    
    [self.mainScrollView addSubview:self.chemicalPropertyTitle];
}

- (void)initializeChemicalPropertyBody
{
    self.chemicalPropertyBody = [[UILabel alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.chemicalPropertyTitle.frame.size.height + self.chemicalPropertyTitle.frame.origin.y, ELEMENT_DESCRIP_WIDTH, ELEMENT_DESCRIP_HEIGHT)];
    NSMutableString* description = [NSMutableString stringWithString:@"Oxidation State/氧化态: "];
    [description appendString:self.element.oxidationState];
    [description appendString:NEW_LINE];
    [description appendString:@"Electronegativity/电负性: "];
    [description appendString:self.element.electronegativity];
    [description appendString:@" (Pauling scale)"];
    [description appendString:NEW_LINE];
    [description appendString:@"Ionization Energy/电离能: "];
    [description appendString:self.element.ionizationEnergy];
    [description appendString:@" kJ/mol (1st)"];
    [description appendString:NEW_LINE];
    [description appendString:@"Atomic Radius/原子半径: "];
    [description appendString:self.element.atomicRadius];
    [description appendString:@" pm"];
    [description appendString:NEW_LINE];
    [description appendString:@"van der Waals Radius/范德华半径: "];
    [description appendString:self.element.vdwRadius];
    if(![self.element.vdwRadius isEqualToString:@"-"])
    {
        [description appendString:@" pm"];
    }
    [description appendString:NEW_LINE];
    [description appendString:NEW_LINE];
    self.chemicalPropertyBody.text = description;
    self.chemicalPropertyBody.numberOfLines = 0;
    [self.chemicalPropertyBody setLineBreakMode:NSLineBreakByWordWrapping];
    [self.chemicalPropertyBody setTextAlignment:NSTextAlignmentLeft];
    self.chemicalPropertyBody.font = [UIFont fontWithName:APP_FONT size:13.0];
    [self.chemicalPropertyBody sizeToFit];
    
    [self.mainScrollView addSubview:self.chemicalPropertyBody];
}

-(void)initializeElementImage
{
    NSMutableString* elementImageName = [NSMutableString stringWithString:self.element.atomicNumber];
    [elementImageName appendString:@".jpg"];
    UIImage* image = [UIImage imageNamed:elementImageName];
    self.elementImage = [[UIImageView alloc]initWithFrame:CGRectMake(ELEMENT_START_POSITION_X, self.chemicalPropertyBody.frame.origin.y + self.chemicalPropertyBody.frame.size.height, image.size.width/3.0, image.size.height/3.0)];
    [self.elementImage setImage:image];
    
    [self.mainScrollView addSubview:self.elementImage];
}


-(void)initializeSubViews
{
    [self initializeChineseLabel];
    [self initializeSoundImage];
    [self initializePinyin];
    [self initializeEnglish];
    [self initializePhanetic];
    [self initializeDescription];
    [self initializePhysicalPropertyTitle];
    [self initializePhysicalPropertyBody];
    [self initializeChemicalPropertyTitle];
    [self initializeChemicalPropertyBody];
    [self initializeElementImage];
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width, self.elementImage.frame.origin.y + self.elementImage.frame.size.height + 5.0);
    self.mainScrollView.minimumZoomScale = 1.0;
    self.mainScrollView.maximumZoomScale = 1.0;
    self.mainScrollView.zoomScale = 1.0;
}

-(void)goBackToMain
{
    ViewController *portraitViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    CustomNavigationController *newNavigtionController = [[CustomNavigationController alloc] initWithRootViewController:portraitViewController];
    
    [self.navigationController presentViewController:newNavigtionController animated:NO completion:nil];
}

-(void)goBackToTable
{
    PeriodicTableElementController *portraitViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeriodicTable"];
    CustomNavigationController *newNavigtionController = [[CustomNavigationController alloc] initWithRootViewController:portraitViewController];
    
    [self.navigationController presentViewController:newNavigtionController animated:NO completion:NULL];
}

- (void)configureInterfaceView
{
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.ViewOrigin = CGPointMake(0.0, self.view.frame.origin.y + self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
        
        self.ViewSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height);
    }
    else
    {
        self.ViewOrigin = self.view.frame.origin;
        
        self.ViewSize = self.view.frame.size;
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
