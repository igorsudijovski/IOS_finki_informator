//
//  StudiskiProgramiFirstController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/22/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudiskiProgramiFirstController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tabelaStudii;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;
@property (strong, nonatomic) NSMutableDictionary *predmeti;
@property  Boolean loaddata;


-(void) pushStack:(UIViewController *) controller;

@end