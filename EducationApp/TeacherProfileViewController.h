//
//  TeacherProfileViewController.h
//  EducationApp
//
//  Created by HappySanz on 21/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface TeacherProfileViewController : UIViewController<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,PECropViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *userType;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;
- (IBAction)changePasswordBtn:(id)sender;
- (IBAction)teacherprofileBtn:(id)sender;
- (IBAction)imageViewBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageBtnOtlet;

@end
