//
//  ShowPopViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 20/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassTeacherAttendanceDetailView.h"

@interface ShowPopViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *sendOutlet;
- (IBAction)sendBtn:(id)sender;
- (IBAction)notificationBtn:(id)sender;
- (IBAction)mailBtn:(id)sender;
- (IBAction)smsBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mail_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smsImageView;
- (IBAction)closeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *popupView;
@end
