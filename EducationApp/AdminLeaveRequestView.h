//
//  AdminLeaveRequestView.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminLeaveRequestView : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarBtn;

@end
