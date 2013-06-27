//
//  PredmetiDetaliController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/25/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "PredmetiDetaliController.h"
#import "DodajKomentarController.h"
#import "ODRefreshControl.h"
//#import "PullToRefreshView.h"

@implementation PredmetiDetaliController
@synthesize tableComments;
@synthesize comments;
@synthesize idpredmet;
@synthesize url;
@synthesize pdf;
//@synthesize pull;

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
    
    
    /*pull = [[PullToRefreshView alloc] initWithScrollView:(UIScrollView *) self.tableComments];
    [pull setDelegate:self];
    [self.tableComments addSubview:pull];*/
    ODRefreshControl *refresh = [[ODRefreshControl alloc] initInScrollView:tableComments];
    NSString *nullstring = [[NSString alloc] initWithFormat:@"null"];
    [refresh addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    if(![nullstring isEqualToString:url]){
    UIBarButtonItem *openpdf = [[UIBarButtonItem alloc] initWithTitle:@"Детали" style:UIBarButtonItemStyleBordered target:self action:@selector(openpdffun)];
    self.navigationItem.rightBarButtonItem = openpdf;
    }
    dispatch_async(kBgQueue, ^{
        NSString *urllink = [[NSString alloc] initWithFormat:@"http://finkiservices.zzl.org/getComments.php?id=%@",idpredmet];
        NSURL *urlfetch = [NSURL URLWithString:urllink];
        NSData *data = [NSData dataWithContentsOfURL:urlfetch];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });

    // Do any additional setup after loading the view from its nib.
    
}
-(void) fetchedData:(NSData *) responseData{
    NSError *error;
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    comments = [[NSMutableArray alloc] initWithArray:json];
    [tableComments reloadData];
}

- (void)openpdffun{
    pdf = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,320,365)];
    NSURL *targetURL = [NSURL URLWithString:url];
    NSURLRequest *req = [NSURLRequest requestWithURL:targetURL];
    [pdf loadRequest:req];
    UIBarButtonItem *openpdf = [[UIBarButtonItem alloc] initWithTitle:@"Затвори" style:UIBarButtonItemStyleBordered target:self action:@selector(zatvoripdf)];
    self.navigationItem.rightBarButtonItem = openpdf;

    [self.view addSubview:pdf];
    //[self.navigationController pushViewController:webView animated:YES];
}
-(void) zatvoripdf{
    UIBarButtonItem *openpdf = [[UIBarButtonItem alloc] initWithTitle:@"Детали" style:UIBarButtonItemStyleBordered target:self action:@selector(openpdffun)];
    self.navigationItem.rightBarButtonItem = openpdf;
    pdf.hidden = YES;
}

- (void)viewDidUnload
{
    [self setTableComments:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dodajKomentar:(id)sender {
    DodajKomentarController *con = [[DodajKomentarController alloc] init];
    con.title = @"Коментари";
    con.idpredmet = idpredmet;
    con.parrent = self;
    [self.navigationController pushViewController:con animated:YES];
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        dispatch_async(kBgQueue, ^{
            NSString *urllink = [[NSString alloc] initWithFormat:@"http://finkiservices.zzl.org/getComments.php?id=%@",idpredmet];
            NSURL *urlfetch = [NSURL URLWithString:urllink];
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
    return [self.comments count]; }
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
    cell.textLabel.text = [comments objectAtIndex:row];
    return cell;
}



@end
