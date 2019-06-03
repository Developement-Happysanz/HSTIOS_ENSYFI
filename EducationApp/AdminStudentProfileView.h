//
//  AdminStudentProfileView.h
//  EducationApp
//
//  Created by HappySanz on 19/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminStudentProfileView : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *registered;
@property (strong, nonatomic) IBOutlet UILabel *parentstatus;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *recordSheet;
@property (strong, nonatomic) IBOutlet UILabel *tc;
@property (strong, nonatomic) IBOutlet UILabel *promotionStatus;
@property (strong, nonatomic) IBOutlet UILabel *previousSchool;
@property (strong, nonatomic) IBOutlet UILabel *secondaryEmail;
@property (strong, nonatomic) IBOutlet UILabel *secondaryMobile;
@property (strong, nonatomic) IBOutlet UILabel *motherLanguage;
@property (strong, nonatomic) IBOutlet UILabel *parentRguardianId;
@property (strong, nonatomic) IBOutlet UILabel *parentRguardian;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *admisionDate;
@property (strong, nonatomic) IBOutlet UILabel *emsiNumber;
@property (strong, nonatomic) IBOutlet UILabel *admisionYear;
@property (strong, nonatomic) IBOutlet UILabel *admisionNumber;
- (IBAction)atendanceBtn:(id)sender;
- (IBAction)examBtn:(id)sender;
- (IBAction)clasTestBtn:(id)sender;
- (IBAction)feesBtn:(id)sender;

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *religion;
@property (strong, nonatomic) IBOutlet UILabel *parents_status;
@property (strong, nonatomic) IBOutlet UILabel *nationality;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *mobile;
@property (strong, nonatomic) IBOutlet UILabel *language;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *dob;
@property (strong, nonatomic) IBOutlet UILabel *comunity_class;
@property (strong, nonatomic) IBOutlet UILabel *comunity;
@property (strong, nonatomic) IBOutlet UILabel *admision_id;

@end
