//
//  SyllabusController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 21/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "SyllabusController.h"
#import "ChapterController.h"

@interface SyllabusController ()

@property(nonatomic,readwrite)NSMutableArray* chapterArray;

@end

@implementation SyllabusController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    UIImageView* homeView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
    homeView.frame=CGRectMake(0, 0, 40, 40);
    homeView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToMainInterface)];
    [singleTap setNumberOfTapsRequired:1];
    [homeView addGestureRecognizer:singleTap];
    
    UIBarButtonItem* homeButton = [[UIBarButtonItem alloc]initWithCustomView:homeView];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    CGRect frame = CGRectMake(0, 0, [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.0f]}].width, 44.0);
    UILabel* label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    label.text = @"Syllabus 教学大纲";
    
    [self initializeChapterList];
}

-(void)initializeChapterList
{
    self.chapterArray = [[NSMutableArray alloc]init];
    [self.chapterArray addObject:@"Fundamentals of Chemistry"];
    [self.chapterArray addObject:@"Atomic Structure"];
    [self.chapterArray addObject:@"Periodic Table"];
    [self.chapterArray addObject:@"Properties of Elements in the Periodic Table"];
    [self.chapterArray addObject:@"Stoichiomery"];
    [self.chapterArray addObject:@"Models of Chemistry Bonding"];
    [self.chapterArray addObject:@"Structure and Shapes of Molecules"];
    [self.chapterArray addObject:@"Gases and Solutions"];
    [self.chapterArray addObject:@"Chemical Energentics and Thermodynamics"];
    [self.chapterArray addObject:@"Types of Chemical Reactions"];
    [self.chapterArray addObject:@"Chemical Kinetics"];
    [self.chapterArray addObject:@"Chemical Equilibrium"];
    [self.chapterArray addObject:@"Alkanes and Alkenes"];
    [self.chapterArray addObject:@"Alkynes, Aromatics and Functional Groups"];
    [self.chapterArray addObject:@"Common Classes of Organic Reactions"];
    [self.chapterArray addObject:@"Stereochemistry"];
    [self.chapterArray addObject:@"Molecules of Life"];
}

-(void)goBackToMainInterface
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UILabel* chapter = [[UILabel alloc]init];
        chapter.tag = 1;
        
        UILabel* content = [[UILabel alloc]init];
        content.tag = 2;
        
        [cell.contentView addSubview:chapter];
        [cell.contentView addSubview:content];
    }
    
    UILabel* chapter = (UILabel*)[cell viewWithTag:1];
    UILabel* content = (UILabel*)[cell viewWithTag:2];
    
    chapter.frame = CGRectMake(10.0, 0.0, 80.0, 30.0);
    NSMutableString* chapterTitle = [[NSMutableString alloc]initWithString:@"Chapter "];
    [chapterTitle appendFormat:@"%d",indexPath.item + 1];
    chapter.text = chapterTitle;
    [chapter setBackgroundColor:[UIColor clearColor]];
    chapter.font = [UIFont boldSystemFontOfSize:12.5];
    chapter.numberOfLines = 0;
    [chapter sizeToFit];
    
    CGFloat contentOrigin = chapter.frame.origin.x + chapter.frame.size.width + 5.0;
    content.frame = CGRectMake(contentOrigin, 0.0, cell.contentView.frame.size.width - contentOrigin, 30.0);
    NSMutableString* contentString = [[NSMutableString alloc]initWithString:(NSString*)[self.chapterArray objectAtIndex:indexPath.item]];
    content.text = contentString;
    [content setBackgroundColor:[UIColor clearColor]];
    content.font = [UIFont boldSystemFontOfSize:12.5];
    content.numberOfLines = 0;
    [content sizeToFit];
    
    chapter.frame = CGRectMake(chapter.frame.origin.x, (cell.contentView.frame.size.height - chapter.frame.size.height)/2, chapter.frame.size.width, chapter.frame.size.height);
    
    content.frame = CGRectMake(content.frame.origin.x, (cell.contentView.frame.size.height - content.frame.size.height)/2, content.frame.size.width, content.frame.size.height);

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentTableRow = indexPath.row;
    [self performSegueWithIdentifier:@"FromSyllabusToChapter" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromSyllabusToChapter"])
    {
        ChapterController* chapter = [segue destinationViewController];
        chapter.delegate = self;
        [chapter setChapterNumber:_currentTableRow];
    }
}

-(void)returnToMainInterface
{
    [_delegate returnToMainInterface];
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
