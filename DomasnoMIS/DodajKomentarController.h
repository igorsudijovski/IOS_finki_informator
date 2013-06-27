//
//  DodajKomentarController.h
//  DomasnoMIS
//
//  Created by etnc lab on 6/25/13.
//  Copyright (c) 2013 FINKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PredmetiDetaliController.h"

@interface DodajKomentarController : UIViewController <UITextViewDelegate>
@property (strong, nonatomic) NSString *idpredmet;
@property (strong, nonatomic) PredmetiDetaliController *parrent;
- (IBAction)backtocuh:(id)sender;
- (IBAction)insertCommentar:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *comment;

@end
