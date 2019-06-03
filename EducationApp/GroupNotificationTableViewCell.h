//
//  GroupNotificationTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 08/05/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *Lead;

@end
