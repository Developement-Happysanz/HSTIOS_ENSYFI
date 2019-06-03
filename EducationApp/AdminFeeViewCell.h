//
//  AdminFeeViewCell.h
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminFeeViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *feeID;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UILabel *toDate;
@property (strong, nonatomic) IBOutlet UILabel *fromdate;
@property (strong, nonatomic) IBOutlet UILabel *termName;

@end
