//
//  ODPermisionViewController.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 30/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ODPermisionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *acceptOutlet;
- (IBAction)acceptBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *declineOutlet;
- (IBAction)declineBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *decrptionTxtView;

@end
