//
//  OglasnaController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/27/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OglasnaController : UIViewController <UITableViewDelegate, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *oglasna;
@property (strong, nonatomic) IBOutlet UITableView *oglasnaTable;

@end
