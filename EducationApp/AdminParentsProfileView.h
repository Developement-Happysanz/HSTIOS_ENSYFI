//
//  AdminParentsProfileView.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminParentsProfileView : UIViewController
- (IBAction)viewStudentinfo:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *officePhone;
@property (strong, nonatomic) IBOutlet UILabel *homePhone;
@property (strong, nonatomic) IBOutlet UILabel *mobilelabel;
@property (strong, nonatomic) IBOutlet UILabel *incomelabel;
@property (strong, nonatomic) IBOutlet UILabel *occupationLabel;
@property (strong, nonatomic) IBOutlet UILabel *maillabel;
@property (strong, nonatomic) IBOutlet UILabel *addresslabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)fatherBtn:(id)sender;
- (IBAction)guardianBtn:(id)sender;
- (IBAction)motherBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *guardianImg;
@property (strong, nonatomic) IBOutlet UIImageView *motherImg;
@property (strong, nonatomic) IBOutlet UIImageView *fatherImg;

@end
