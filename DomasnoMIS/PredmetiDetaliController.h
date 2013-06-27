//
//  PredmetiDetaliController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/25/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PullToRefreshView.h"


@interface PredmetiDetaliController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableComments;
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) NSString *idpredmet;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) UIWebView *pdf;
//@property (strong, nonatomic) PullToRefreshView *pull;
- (IBAction)dodajKomentar:(id)sender;

@end
