//
//  StudentProfileInfoController.h
//  EducationApp
//
//  Created by HappySanz on 11/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentProfileInfoController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *studentImg;
@property (strong, nonatomic) IBOutlet UILabel *registered;
@property (strong, nonatomic) IBOutlet UILabel *parentStatus;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *recordSheet;
@property (strong, nonatomic) IBOutlet UILabel *tc;
@property (strong, nonatomic) IBOutlet UILabel *promotionStatus;
@property (strong, nonatomic) IBOutlet UILabel *previousSchool;
@property (strong, nonatomic) IBOutlet UILabel *secondaryMail;
@property (strong, nonatomic) IBOutlet UILabel *mail;
@property (strong, nonatomic) IBOutlet UILabel *secondaryMobile;
@property (strong, nonatomic) IBOutlet UILabel *mobile;
@property (strong, nonatomic) IBOutlet UILabel *laungage;
@property (strong, nonatomic) IBOutlet UILabel *motherTongue;
@property (strong, nonatomic) IBOutlet UILabel *parentOrGuardianId;
@property (strong, nonatomic) IBOutlet UILabel *parentOrguardian;
@property (strong, nonatomic) IBOutlet UILabel *comunity;
@property (strong, nonatomic) IBOutlet UILabel *caste;
@property (strong, nonatomic) IBOutlet UILabel *religion;
@property (strong, nonatomic) IBOutlet UILabel *nationality;
@property (strong, nonatomic) IBOutlet UILabel *age;
@property (strong, nonatomic) IBOutlet UILabel *dob;
@property (strong, nonatomic) IBOutlet UILabel *gender;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *admisnDate;
@property (strong, nonatomic) IBOutlet UILabel *emsiNum;
@property (strong, nonatomic) IBOutlet UILabel *admisionYear;
@property (strong, nonatomic) IBOutlet UILabel *admisonNumber;
@property (strong, nonatomic) IBOutlet UILabel *admisionID;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
