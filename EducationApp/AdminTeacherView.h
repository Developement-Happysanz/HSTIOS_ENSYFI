//
//  AdminTeacherView.h
//  EducationApp
//
//  Created by HappySanz on 20/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminTeacherView : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
