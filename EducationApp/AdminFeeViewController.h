//
//  AdminFeeViewController.h
//  EducationApp
//
//  Created by HappySanz on 25/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminFeeViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)sectionBTn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionOtlet;
- (IBAction)classBTn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *classOtlet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
