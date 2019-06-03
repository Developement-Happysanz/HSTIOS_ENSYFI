//
//  PopViewController.h
//  EducationApp
//
//  Created by HappySanz on 10/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *fatherBtnOtlet;
@property (strong, nonatomic) IBOutlet UIButton *motherBtnOtlet;
@property (strong, nonatomic) IBOutlet UILabel *motherOtlet;
@property (strong, nonatomic) IBOutlet UILabel *fatherOtlet;
@property (strong, nonatomic) IBOutlet UILabel *ofcPhonelabel;
@property (strong, nonatomic) IBOutlet UILabel *homeLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *ocupationLabel;
@property (strong, nonatomic) IBOutlet UILabel *mailLabel;
@property (strong, nonatomic) IBOutlet UILabel *adressLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)motherBtn:(id)sender;
- (IBAction)fatherBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *motherImg;
@property (strong, nonatomic) IBOutlet UIImageView *fatherImg;
@property (strong, nonatomic) IBOutlet UIView *subView;
@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)closeBtn:(id)sender;

@end
