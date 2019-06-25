//
//  ProfileViewController.h
//  EducationApp
//
//  Created by HappySanz on 12/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface ProfileViewController : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverPresentationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,PECropViewControllerDelegate>
- (IBAction)changePaswrdBtn:(id)sender;
- (IBAction)fessBtn:(id)sender;
- (IBAction)studentBtn:(id)sender;
- (IBAction)guardianBtn:(id)sender;
- (IBAction)parentsinfoBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userTypeName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSArray *textFieldArray;
@property (weak) UIViewController *popupController;
- (IBAction)imageBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageBtnOtlet;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *parentView;
@property (strong, nonatomic) IBOutlet UIView *guardianView;
@property (strong, nonatomic) IBOutlet UIView *studentView;
@property (strong, nonatomic) IBOutlet UIView *feeView;


@end
