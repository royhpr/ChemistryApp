//
//  ChapterController.m
//  ChemistryDictionaryForSM2
//
//  Created by Huang Purong on 22/9/13.
//  Copyright (c) 2013 Huang Purong. All rights reserved.
//

#import "ChapterController.h"

@interface ChapterController ()

@end

@implementation ChapterController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.hidesBackButton = YES;
    
    UIView* rightItems = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85, 40)];
    rightItems.userInteractionEnabled = YES;
    
    //back
    UIImageView* backView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    backView.frame=CGRectMake(0, 0, 40, 40);
    backView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* singleTapBack = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBackToSyllabus)];
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
}

-(void)goBackToMain
{
    [_delegate returnToMainInterface];
}

-(void)goBackToSyllabus
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setChapterNumber: (int)currentChapterNumber
{
    _chapterNumber = currentChapterNumber + 1;
    [self updateCurrentTitle];
}

-(void)updateCurrentTitle
{
    UIView* leftItem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 220, 40)];
    title.font = [UIFont boldSystemFontOfSize:13.0];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor whiteColor];
    [title setLineBreakMode:NSLineBreakByWordWrapping];
    [title setNumberOfLines:2];
    switch (_chapterNumber)
    {
        case 1:
            title.text = CHAPTER_1;
            break;
        case 2:
            title.text = CHAPTER_2;
            break;
        case 3:
            title.text = CHAPTER_3;
            break;
        case 4:
            title.text = CHAPTER_4;
            break;
        case 5:
            title.text = CHAPTER_5;
            break;
        case 6:
            title.text = CHAPTER_6;
            break;
        case 7:
            title.text = CHAPTER_7;
            break;
        case 8:
            title.text = CHAPTER_8;
            break;
        case 9:
            title.text = CHAPTER_9;
            break;
        case 10:
            title.text = CHAPTER_10;
            break;
        case 11:
            title.text = CHAPTER_11;
            break;
        case 12:
            title.text = CHAPTER_12;
            break;
        case 13:
            title.text = CHAPTER_13;
            break;
        case 14:
            title.text = CHAPTER_14;
            break;
        case 15:
            title.text = CHAPTER_15;
            break;
        case 16:
            title.text = CHAPTER_16;
            break;
        case 17:
            title.text = CHAPTER_17;
            break;
            
        default:
            break;
    }
    [leftItem addSubview:title];
    UIBarButtonItem* navButton = [[UIBarButtonItem alloc]initWithCustomView:leftItem];
    self.navigationItem.leftBarButtonItem = navButton;
}

-(void)populateElementList
{
    _currentChapterElements = [[NSMutableArray alloc]init];
    _database = [NSArray arrayWithArray:[[DictionaryDB database]elementList]];
    
    for(ElementModel* currentElement in _database)
    {
        NSString* number = [NSString stringWithFormat:@"%d",_chapterNumber];
        
        if([number isEqualToString:currentElement.chapter])
        {
            [_currentChapterElements addObject:currentElement.elementEnglish];
        }
    }
    
    if(_currentChapterElements.count != 0)
    {
        NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"" ascending:YES];
        NSArray* sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        [_currentChapterElements sortUsingDescriptors:sortDescriptors];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return _searchResult.count;
    }
    return _currentChapterElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* element;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        element = [_searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        element = [_currentChapterElements objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = element;
    
    return cell;
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    _searchResult = (NSMutableArray*)[_currentChapterElements filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    return YES;
}

-(void)returnToMainInterface
{
    [_delegate returnToMainInterface];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        _selectedElement = [_searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        _selectedElement = [_currentChapterElements objectAtIndex:indexPath.row];
    }
    
    [self performSegueWithIdentifier:@"FromChapterToElement" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"FromChapterToElement"])
    {
        ElementController* element = [segue destinationViewController];
        element.delegate = self;
        [element setCurrentTitle:_currentTitle];
        for(ElementModel* currentElement in _database)
        {
            if([currentElement.chapter isEqualToString: [NSString stringWithFormat:@"%d", _chapterNumber]] && [currentElement.elementEnglish isEqualToString:_selectedElement])
            {
                [element setElementDetails:currentElement.elementEnglish :currentElement.elementChinese :currentElement.phanetic :currentElement.pinyin :currentElement.descriptionEnglish :currentElement.descriptionChinese];
            }
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self populateElementList];
}

@end
