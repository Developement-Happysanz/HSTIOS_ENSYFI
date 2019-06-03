//
//  AdminStudentViewController.h
//  EducationApp
//
//  Created by HappySanz on 19/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"


@interface AdminStudentViewController : UIViewController<UIGestureRecognizerDelegate,NIDropDownDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)sectionBtn:(id)sender;
- (IBAction)classBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionBtnOtlet;
@property (strong, nonatomic) IBOutlet UIButton *classBtnOtlet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

