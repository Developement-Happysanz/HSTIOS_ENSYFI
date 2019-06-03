//
//  TeacherClasstestViewMark.m
//  EducationApp
//
//  Created by HappySanz on 09/10/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import "TeacherClasstestViewMark.h"

@interface TeacherClasstestViewMark ()
{
    AppDelegate *appDel;
    NSArray *stat;
    
    NSMutableArray *marks;
    NSMutableArray *name;
}
@end

@implementation TeacherClasstestViewMark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    stat =@[@"1"];
    marks = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.tableView.hidden = YES;
    NSString *strserver_id;
    NSString *class_local_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"localid_key"];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:@"ENSIFY.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *rs = [database executeQuery:@"Select distinct server_hw_id from table_create_homework_class_test where id = ? ",class_local_id];
    
    if(rs)
    {
        while ([rs next])
        {
            NSLog(@"mark_status :%@",[rs stringForColumn:@"server_hw_id"]);
            strserver_id = [rs stringForColumn:@"server_hw_id"];
        }
    }
    
    [database close];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:strserver_id forKey:@"hw_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    NSString *get_all_classes = @"/apiteacher/disp_Ctestmarks/";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,get_all_classes, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         
         NSString *msg = [responseObject objectForKey:@"msg"];
         NSString *status = [responseObject objectForKey:@"status"];
         
         if ([msg isEqualToString:@"View Class Test"] && [status isEqualToString:@"success"])
         {
             NSArray *ctestmarkDetails = [responseObject objectForKey:@"ctestmarkDetails"];
             [marks insertObject:@"Select" atIndex:0];
             [name insertObject:@"Select" atIndex:0];
             for (int i =0 ; i < [ctestmarkDetails count]; i++)
             {
                 NSDictionary *dict = [ctestmarkDetails objectAtIndex:i];
                 NSString *strMarks = [dict objectForKey:@"marks"];
                 NSString *strName = [dict objectForKey:@"name"];
                 [marks addObject:strMarks];
                 [name addObject:strName];
             }
             self.tableView.hidden = NO;
             [self.tableView reloadData];
             
         }
         else
         {
             UIAlertController *alert= [UIAlertController
                                        alertControllerWithTitle:@"ENSYFI"
                                        message:@""
                                        preferredStyle:UIAlertControllerStyleAlert];
             
             UIAlertAction *ok = [UIAlertAction
                                  actionWithTitle:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      
                                  }];
             
             [alert addAction:ok];
             [self presentViewController:alert animated:YES completion:nil];
         }
        
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [name count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        TeacherClasstestViewMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"static" forIndexPath:indexPath];
        NSString *str = [stat objectAtIndex:indexPath.row];
        NSLog(@"%@",str);
        return cell;
    }
    else
    {
        TeacherClasstestViewMarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dynamic" forIndexPath:indexPath];
        cell.markLabel.text = [marks objectAtIndex:indexPath.row];
        cell.studentnameLabel.text = [name objectAtIndex:indexPath.row];
        return cell;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
