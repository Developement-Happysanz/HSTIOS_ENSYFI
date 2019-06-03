//
//  TeacherTimeTableAddNotes.h
//  EducationApp
//
//  Created by HappySanz on 14/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherTimeTableAddNotes : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *classNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subjectnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *periodlabel;
@property (strong, nonatomic) IBOutlet UITextView *detailstxtview;
@property (strong, nonatomic) IBOutlet UIButton *submitBtnOtlet;
- (IBAction)submitBtn:(id)sender;
- (IBAction)backBtn:(id)sender;

@end
