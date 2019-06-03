//
//  TeacherClassTestDetailView.h
//  EducationApp
//
//  Created by HappySanz on 06/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherClassTestDetailView : UIViewController
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *subjectTitle;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UITextView *detailsLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *markViewOtlet;

@end
