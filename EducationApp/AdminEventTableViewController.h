//
//  AdminEventTableViewController.h
//  EducationApp
//
//  Created by HappySanz on 18/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminEventTableViewController : UITableViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, strong) NSString *eventdisp;

@end
