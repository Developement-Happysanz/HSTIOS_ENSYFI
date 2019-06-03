//
//  TeacherCircularDetailViewController.h
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCircularDetailViewController : UIViewController
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *details;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *date;
@end
