//
//  ClassTeacherHomeWorkDetailViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 03/07/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTeacherHomeWorkDetailViewController : UIViewController
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descripitionLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teachetLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendOutlet;
- (IBAction)sendpopBtn:(id)sender;
- (IBAction)notificationBtn:(id)sender;
- (IBAction)mailBtn:(id)sender;
- (IBAction)smsBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mail_ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *smsImageView;
- (IBAction)closeBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@end
