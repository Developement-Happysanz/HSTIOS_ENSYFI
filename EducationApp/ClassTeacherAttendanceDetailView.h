//
//  ClassTeacherAttendanceDetailView.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 19/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowPopViewController.h"

@interface ClassTeacherAttendanceDetailView : UIViewController<UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIButton *sendReportOulet;
@property (weak, nonatomic) IBOutlet UILabel *takenByLabel;
@property (weak, nonatomic) IBOutlet UILabel *noBasentLabel;
@property (weak, nonatomic) IBOutlet UILabel *noPresentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalStudentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendreportLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sendreportImg;
- (IBAction)viewAttendanceBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet ShowPopViewController *popupView;
@end
