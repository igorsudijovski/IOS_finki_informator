//
//  Twitter.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/26/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter
@synthesize array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    array = [[NSMutableArray alloc] initWithObjects:@"Na Fakultet",@"Konecno doma",@"Zavrsiv so seminarskata MIS", nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.array count]; }
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    NSUInteger row = [indexPath row]; 
    cell.textLabel.numberOfLines = 4;
    cell.textLabel.text = [array objectAtIndex:row];
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void) tableView:(UITableView *) tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TWTweetComposeViewController *tweetsheet = [[TWTweetComposeViewController alloc] init];
    [tweetsheet setInitialText:[array objectAtIndex:[indexPath row]]];;
    [self presentModalViewController:tweetsheet animated:YES];
    /*PredmetiController *nov = [[PredmetiController alloc] init];
     [self.navigationController pushViewController:nov animated:YES];*/
    //NSLog(@"%@",self.view.window.rootViewController.parentViewController);
    //[self.navigationController pushViewController:pr animated:YES];
}

- (IBAction)tweet:(id)sender {
    TWTweetComposeViewController *tweetsheet = [[TWTweetComposeViewController alloc] init];
    [tweetsheet setInitialText:@""];
    [self presentModalViewController:tweetsheet animated:YES];
}
@end
