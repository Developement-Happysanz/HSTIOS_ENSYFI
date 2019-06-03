//
//  AdminEventTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 18/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminEventTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *eventdate;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@end
