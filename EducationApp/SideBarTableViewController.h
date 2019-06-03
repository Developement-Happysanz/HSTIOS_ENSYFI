//
//  SideBarTableViewController.h
//  EducationApp
//
//  Created by HappySanz on 12/04/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarTableViewController : UITableViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
