//
//  OnDutyTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 12/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnDutyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *statusImg;
@property (strong, nonatomic) IBOutlet UILabel *toDate;
@property (strong, nonatomic) IBOutlet UILabel *fromdate;
@property (strong, nonatomic) IBOutlet UILabel *name;

@end
