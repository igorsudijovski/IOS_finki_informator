//
//  DodajKomentarController.m
//  DomasnoMIS
//
//  Created by etnc lab on 6/25/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#import "DodajKomentarController.h"
#import "PredmetiDetaliController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DodajKomentarController
@synthesize comment;
@synthesize idpredmet;
@synthesize parrent;

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
    comment.delegate = self;
    comment.layer.borderWidth = 4.0f;
    comment.layer.borderColor = [[UIColor grayColor] CGColor];
    comment.layer.cornerRadius = 15;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setComment:nil];
    [self setComment:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range     replacementString:(NSString *)string
{
    if (textField.text.length > 250 && range.length == 0)
        return NO;
    return YES;
}

- (IBAction)backtocuh:(id)sender {
    [comment resignFirstResponder];
}

- (IBAction)insertCommentar:(id)sender {
    dispatch_async(kBgQueue, ^{
        NSString *nov = [comment.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *urllink = [[NSString alloc] initWithFormat:@"http://finkiservices.zzl.org/addComment.php?id=%@&comment=%@",idpredmet,nov];
        NSURL *url = [NSURL URLWithString:urllink];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

-(void) fetchedData:(NSData *) responseData{
    NSError *error;
    NSString *message = [[NSString alloc] initWithFormat: @"Успешно е пратен вашиот коментар"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Успешно"
                                                    message:message
                                                   delegate:nil cancelButtonTitle:@"Во ред"
                                          otherButtonTitles:nil];
    [alert show];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

    parrent.comments = [[NSMutableArray alloc] initWithArray:json];
    [parrent.tableComments reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
