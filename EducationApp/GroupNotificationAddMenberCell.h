//
//  GroupNotificationAddMenberCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 10/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationAddMenberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
- (IBAction)groupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clickButtonOutlet;
@property (weak, nonatomic) IBOutlet UILabel *teacherId;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
