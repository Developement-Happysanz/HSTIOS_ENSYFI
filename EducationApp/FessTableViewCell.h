//
//  FessTableViewCell.h
//  EducationApp
//
//  Created by HappySanz on 12/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FessTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dueTo;
@property (strong, nonatomic) IBOutlet UILabel *dueFrom;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *termName;

@end
