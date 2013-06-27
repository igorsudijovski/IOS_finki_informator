//
//  OglasnaDetaliController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/27/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "OglasnaDetaliController.h"

@implementation OglasnaDetaliController
@synthesize vestiView;
@synthesize linkid;

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
    [vestiView setEditable:NO];
    dispatch_async(kBgQueue, ^{
        NSString *urllink = [[NSString alloc] initWithFormat:@"http://apache.finki.ukim.mk/raspored/fb-app/ios/oglasnaDetali.php?link=%@",linkid];
        NSURL *url = [NSURL URLWithString:urllink];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    // Do any additional setup after loading the view from its nib.
}

-(void) fetchedData:(NSData *) responseData{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    vestiView.text = [json objectForKey:@"items"];
    
}

- (void)viewDidUnload
{
    [self setVestiView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
