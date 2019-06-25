//
//  TeachersTimeTableView.h
//  EducationApp
//
//  Created by HappySanz on 12/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface TeachersTimeTableView : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
