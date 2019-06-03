//
//  TeacherOndutyViewController.h
//  EducationApp
//
//  Created by HappySanz on 15/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherOndutyViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    UIDatePicker *datePicker;
    CGFloat animatedDistance;
    
}
@property (strong, nonatomic) IBOutlet UIButton *requestOtlet;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextView *detailsTextView;
@property (strong, nonatomic) IBOutlet UITextField *endDateText;
@property (strong, nonatomic) IBOutlet UITextField *startDateText;

- (IBAction)backBtn:(id)sender;
- (IBAction)requestBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *endImg;
@property (strong, nonatomic) IBOutlet UIImageView *strtImg;
@property (strong, nonatomic) IBOutlet UILabel *enddateLabel;
@property (strong, nonatomic) IBOutlet UILabel *startdateLabel;
@property (strong, nonatomic) IBOutlet UITextField *resonText;
@property (nonatomic, assign) NSInteger datePickerType;
@end
