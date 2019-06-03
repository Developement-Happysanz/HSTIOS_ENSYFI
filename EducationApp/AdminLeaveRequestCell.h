//
//  AdminLeaveRequestCell.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminLeaveRequestCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UIImageView *timeImg;
@property (strong, nonatomic) IBOutlet UILabel *toTime;
@property (strong, nonatomic) IBOutlet UILabel *fromTime;
@property (strong, nonatomic) IBOutlet UILabel *toDate;
@property (strong, nonatomic) IBOutlet UILabel *fromDate;
@property (strong, nonatomic) IBOutlet UILabel *reson;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
