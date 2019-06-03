//
//  AdminODTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminODTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *toDate;
@property (strong, nonatomic) IBOutlet UILabel *fromdate;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end
