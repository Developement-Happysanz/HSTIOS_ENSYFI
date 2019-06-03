//
//  TeachernotificationViewController.h
//  EducationApp
//
//  Created by HappySanz on 18/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationSendViewController : UIViewController<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *imgNotification;
@property (strong, nonatomic) IBOutlet UIButton *mailImgOtlet;
@property (strong, nonatomic) IBOutlet UIButton *imgSmsOtlet;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;
- (IBAction)smsImgButton:(id)sender;

- (IBAction)smsButton:(id)sender;
- (IBAction)mainImg:(id)sender;
- (IBAction)mailButton:(id)sender;
;
- (IBAction)notifiButton:(id)sender;
- (IBAction)notiImgButton:(id)sender;
- (IBAction)sendButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendOtlet;
- (IBAction)backBtn:(id)sender;

@end
