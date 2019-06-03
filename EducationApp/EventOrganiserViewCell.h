//
//  EventOrganiserViewCell.h
//  EducationApp
//
//  Created by HappySanz on 18/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventOrganiserViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *sub_event_name;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
