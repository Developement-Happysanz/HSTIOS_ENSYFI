//
//  SideTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 13/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *user_Image;
- (IBAction)ImageViewBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *imageBtnOtlet;

@end
