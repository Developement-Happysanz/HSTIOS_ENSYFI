//
//  StudentinfoViewController.h
//  EducationApp
//
//  Created by HappySanz on 06/07/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentinfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
