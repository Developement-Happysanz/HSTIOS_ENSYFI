//
//  AdminProfileView.h
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminProfileView : UIViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
- (IBAction)imageBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageBtnOtlet;
- (IBAction)changePaswrdBTn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *editBtnOtlet;
@property (weak, nonatomic) IBOutlet UILabel *userTypeName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@end
