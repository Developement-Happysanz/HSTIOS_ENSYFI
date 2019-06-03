//
//  EventDiscripitionViewController.h
//  EducationApp
//
//  Created by HappySanz on 18/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDiscripitionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *eventdescrp;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
- (IBAction)backButton:(id)sender;
- (IBAction)OrganiserButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *eventdiscrpDateLabel;

@end
