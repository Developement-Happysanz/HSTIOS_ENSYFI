//
//  AdminParentsViewController.h
//  EducationApp
//
//  Created by HappySanz on 24/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminParentsViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)sectionBtn:(id)sender;
- (IBAction)classBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *classOtlet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
