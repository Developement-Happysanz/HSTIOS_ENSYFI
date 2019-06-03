//
//  ViewController.h
//  EducationApp
//
//  Created by HappySanz on 03/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)frwdBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *frwdBtnOtlet;
@property (weak, nonatomic) IBOutlet UITextField *idTextfield;


@end

