//
//  ClassTestDetailViewController.h
//  EducationApp
//
//  Created by HappySanz on 20/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTestDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabelline;
@property (strong, nonatomic) IBOutlet UILabel *remarksLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *remarksOtlet;
@property (strong, nonatomic) IBOutlet UILabel *markLineLabel;
@property (strong, nonatomic) IBOutlet UITextView *remarks;
@property (weak, nonatomic) IBOutlet UILabel *markOutlet;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *subjectTitle;

@end
