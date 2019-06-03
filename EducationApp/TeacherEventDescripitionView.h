//
//  TeacherEventDescripitionView.h
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherEventDescripitionView : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *eventdescrp;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
- (IBAction)backButton:(id)sender;
- (IBAction)OrganiserButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *eventdiscrpDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewOrganiserOtlet;

@end
