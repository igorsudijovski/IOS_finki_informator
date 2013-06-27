//
//  OglasnaController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/27/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "OglasnaController.h"
#import "ODRefreshControl.h"
#import "OglasnaDetaliController.h"

@implementation OglasnaController
@synthesize oglasnaTable;
@synthesize oglasna;

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
    // Do any additional setup after loading the view from its nib.
    oglasna = [[NSMutableArray alloc] init];
    ODRefreshControl *refresh = [[ODRefreshControl alloc] initInScrollView:oglasnaTable];
    [refresh addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    dispatch_async(kBgQueue, ^{
        NSURL *url = [NSURL URLWithString:@"http://apache.finki.ukim.mk/raspored/fb-app/ios/oglasna.php"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)viewDidUnload
{
    [self setOglasnaTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) fetchedData:(NSData *) responseData{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    oglasna = [[NSMutableArray alloc] initWithArray:[json objectForKey:@"items"]];
    [oglasnaTable reloadData];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        dispatch_async(kBgQueue, ^{
            NSURL *urlfetch = [NSURL URLWithString:@"http://apache.finki.ukim.mk/raspored/fb-app/ios/oglasna.php"];
            NSData *data = [NSData dataWithContentsOfURL:urlfetch];
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        });
        [refreshControl endRefreshing];
    });
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.oglasna count]; 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    NSUInteger row = [indexPath row]; 
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.text = [[oglasna objectAtIndex:row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[oglasna objectAtIndex:row] objectForKey:@"date"];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

#pragma mark -
#pragma mark Table View Delegate Methods
-(void) tableView:(UITableView *) tableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OglasnaDetaliController *oglasnadetali = [[OglasnaDetaliController alloc] init];
    oglasnadetali.linkid = [[oglasna objectAtIndex:[indexPath row]] objectForKey:@"linkid"];
    oglasnadetali.title = [[oglasna objectAtIndex:[indexPath row]] objectForKey:@"title"];
    [self.navigationController pushViewController:oglasnadetali animated:YES];
}
@end
