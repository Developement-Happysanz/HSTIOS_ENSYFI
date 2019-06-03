//
//  AdminExamViewController.h
//  EducationApp
//
//  Created by HappySanz on 22/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminExamViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,NIDropDownDelegate>
{
    NIDropDown *dropDown;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)sectionBtn:(id)sender;
- (IBAction)classBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sectionOtlet;
@property (strong, nonatomic) IBOutlet UIButton *classOtlet;

@end
