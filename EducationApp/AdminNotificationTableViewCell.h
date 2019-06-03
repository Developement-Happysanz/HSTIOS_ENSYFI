//
//  AdminNotificationTableViewCell.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/03/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminNotificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *notesTxtView;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
