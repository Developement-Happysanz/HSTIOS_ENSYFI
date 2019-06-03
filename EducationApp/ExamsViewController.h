//
//  ExamsViewController.h
//  EducationApp
//
//  Created by HappySanz on 15/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExamsViewController : UITableViewController<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *tableview;

@end
