//
//  ClassTestHomeWorkFirstView.h
//  EducationApp
//
//  Created by Happy Sanz Tech on 28/06/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassTestHomeWorkFirstView : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)detailBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
