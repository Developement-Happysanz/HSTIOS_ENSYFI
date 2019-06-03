//
//  AdminTeacherProfileView.h
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTeacherProfileView : UIViewController
- (IBAction)timeTableBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *teacher_id;
@property (strong, nonatomic) IBOutlet UILabel *subjectName;
@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *sec_Phone;
@property (strong, nonatomic) IBOutlet UILabel *secyionName;
@property (strong, nonatomic) IBOutlet UILabel *sec_Email;
@property (strong, nonatomic) IBOutlet UILabel *religion;
@property (strong, nonatomic) IBOutlet UILabel *qualification;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *comunityClass;
@property (strong, nonatomic) IBOutlet UILabel *classTeacher;
@property (strong, nonatomic) IBOutlet UILabel *className;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UIButton *timetablebtnOtlet;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

@end
