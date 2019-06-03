//
//  NewTimeTableViewcontroller.m
//  EducationApp
//
//  Created by Happy Sanz Tech on 25/04/18.
//  Copyright © 2018 Palpro Tech. All rights reserved.
//

#import "NewTimeTableViewcontroller.h"

@interface NewTimeTableViewcontroller ()
{
    NSArray *dayArray;
    NSArray *listday_Array;
    NSMutableArray *class_id;
    NSMutableArray *from_time;
    NSMutableArray *is_break;
    NSMutableArray *name;
    NSMutableArray *period;
    NSMutableArray *subject_name;
    NSMutableArray *to_time;
    NSMutableArray *day;
    NSMutableArray *break_name;
    AppDelegate *appDel;
}
@property (readwrite) NSInteger selected_id;
@end

@implementation NewTimeTableViewcontroller


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarbutton setTarget: self.revealViewController];
        [self.sidebarbutton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    SWRevealViewController *revealController = [self revealViewController];
    UITapGestureRecognizer *tap = [revealController tapGestureRecognizer];
    tap.delegate = self;
    [self.view addGestureRecognizer:self.revealViewController.tapGestureRecognizer];
    
    class_id = [[NSMutableArray alloc]init];
    from_time = [[NSMutableArray alloc]init];
    is_break = [[NSMutableArray alloc]init];
    name = [[NSMutableArray alloc]init];
    period = [[NSMutableArray alloc]init];
    subject_name = [[NSMutableArray alloc]init];                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    to_time = [[NSMutableArray alloc]init];
    day = [[NSMutableArray alloc]init];
    break_name = [[NSMutableArray alloc]init];

    dayArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"timeTable_Days_id"];
    listday_Array = [[NSUserDefaults standardUserDefaults]objectForKey:@"timeTable_Days"];
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:listday_Array];
    _segmentedControl.frame = CGRectMake(0,0,self.view.bounds.size.width,55);
    _segmentedControl.selectionIndicatorHeight = 4.0f;
    _segmentedControl.backgroundColor = [UIColor colorWithRed:102/255.0f green:51/255.0f blue:102/255.0f alpha:1.0];
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentedControl.selectionStyle  = HMSegmentedControlSelectionStyleFullWidthStripe;
    _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
    [self.view addSubview:_segmentedControl];
    [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    NSString *firstObject = [listday_Array objectAtIndex:0];
    NSUInteger integer = [listday_Array indexOfObject:firstObject];
    NSString *day_id = dayArray[integer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"1" forKey:@"class_id"];
    [parameters setObject:day_id forKey:@"day_id"];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *disp_timetable = @"apimain/disp_timetable";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_timetable, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         [class_id removeAllObjects];
         [day removeAllObjects];
         [from_time removeAllObjects];
         [is_break removeAllObjects];
         [name removeAllObjects];
         [period removeAllObjects];
         [subject_name removeAllObjects];
         [to_time removeAllObjects];

         if ([msg isEqualToString:@"Timetable Days"])
         {
             NSArray *dataArray = [responseObject objectForKey:@"timeTable"];
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *data = [dataArray objectAtIndex:i];
                 NSString *strclass_id = [data valueForKey:@"class_id"];
                 NSString *strday = [data valueForKey:@"day_id"];
                 NSString *strfrom_time = [data valueForKey:@"from_time"];
                 NSString *stris_break = [data valueForKey:@"is_break"];
                 NSString *strname = [data valueForKey:@"name"];
                 NSString *strperiod = [data valueForKey:@"period"];
                 NSString *strsubject_name = [data valueForKey:@"subject_name"];
                 NSString *strto_time = [data valueForKey:@"to_time"];
                 NSString *strbreak_name = [data valueForKey:@"break_name"];
                 
                 NSDateFormatter *formatHora = [[NSDateFormatter alloc] init];
                 [formatHora setDateFormat:@"HH:mm:ss"];
                 NSDate *dateHora = [formatHora dateFromString:strfrom_time];
                 [formatHora setDateFormat:@"hh:mm a"];
                 NSString *fromTime = [formatHora stringFromDate:dateHora];
                 
                 NSDateFormatter *to_formatHora = [[NSDateFormatter alloc] init];
                 [to_formatHora setDateFormat:@"HH:mm:ss"];
                 NSDate *to_dateHora = [to_formatHora dateFromString:strto_time];
                 [to_formatHora setDateFormat:@"hh:mm a"];
                 NSString *toTime = [to_formatHora stringFromDate:to_dateHora];
                 
                 [class_id addObject:strclass_id];
                 [day addObject:strday];
                 [from_time addObject:fromTime];
                 [is_break addObject:stris_break];
                 [name addObject:strname];
                 [period addObject:strperiod];
                 [subject_name addObject:strsubject_name];
                 [to_time addObject:toTime];
                 [break_name addObject:strbreak_name];
             }
                 [self.tableView reloadData];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [period count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTimeTableTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.subjectName.text = [subject_name objectAtIndex:indexPath.row];
    cell.staffName.text = [name objectAtIndex:indexPath.row];
    NSString *strPeriod = [NSString stringWithFormat:@"%@%@",@"0",[period objectAtIndex:indexPath.row]];
    cell.period.text = strPeriod;
    NSString *time = [NSString stringWithFormat:@"%@ - %@",[from_time objectAtIndex:indexPath.row],[to_time objectAtIndex:indexPath.row]];
    cell.time.text = time;
    NSString *text = [is_break objectAtIndex:indexPath.row];
    if ([text isEqualToString:@"1"])
    {
        cell.subjectName.hidden = YES;
        cell.lineTwo.hidden = YES;
        cell.lineOne.hidden = YES;
        cell.period.hidden = YES;
        cell.time.hidden = YES;
        cell.statPeriodLabel.hidden = YES;
        cell.calenderImageview.hidden = YES;
        cell.staffName.hidden = YES;
        cell.breakLabel.hidden = NO;
        cell.breakLabel.text = [NSString stringWithFormat:@"%@ - %@",[break_name objectAtIndex:indexPath.row],time];
        cell.cellView.layer.cornerRadius = 5.0;
        cell.cellView.clipsToBounds = YES;
        cell.cellView.backgroundColor = [UIColor colorWithRed:231/255.0f green:167/255.0f blue:93/255.0f alpha:1.0];
    }
    else
    {
        cell.breakLabel.hidden = YES;
        cell.subjectName.hidden = NO;
        cell.staffName.hidden = NO;
        cell.lineTwo.hidden = NO;
        cell.lineOne.hidden = NO;
        cell.period.hidden = NO;
        cell.calenderImageview.hidden = NO;
        cell.statPeriodLabel.hidden = NO;
        cell.time.hidden = NO;        
        cell.cellView.layer.cornerRadius = 5.0;
        cell.cellView.clipsToBounds = YES;
        cell.cellView.backgroundColor = [UIColor whiteColor];
    }
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [is_break objectAtIndex:[indexPath row]];
    if ([text isEqualToString:@"1"])
    {
        return 75;
    }
    else
    {
       return 135;
    }
}
-(void)segmentAction:(UISegmentedControl *)sender
{
    _selected_id = _segmentedControl.selectedSegmentIndex;
    NSString *selected_day = [listday_Array objectAtIndex:_selected_id];
    NSUInteger integer = [listday_Array indexOfObject:selected_day];
    NSString *day_id = dayArray[integer];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:@"2" forKey:@"class_id"];
    [parameters setObject:day_id forKey:@"day_id"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    /* concordanate with baseurl */
    NSString *disp_timetable = @"apimain/disp_timetable";
    NSArray *components = [NSArray arrayWithObjects:baseUrl,appDel.institute_code,disp_timetable, nil];
    NSString *api = [NSString pathWithComponents:components];
    
    [manager POST:api parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@",responseObject);
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         NSString *msg = [responseObject objectForKey:@"msg"];
         [class_id removeAllObjects];
         [day removeAllObjects];
         [from_time removeAllObjects];
         [is_break removeAllObjects];
         [name removeAllObjects];
         [period removeAllObjects];
         [subject_name removeAllObjects];
         [to_time removeAllObjects];
         
         if ([msg isEqualToString:@"Timetable Days"])
         {
             NSArray *dataArray = [responseObject objectForKey:@"timeTable"];
             for (int i = 0;i < [dataArray count];i++)
             {
                 NSArray *data = [dataArray objectAtIndex:i];
                 NSString *strclass_id = [data valueForKey:@"class_id"];
                 NSString *strday = [data valueForKey:@"day_id"];
                 NSString *strfrom_time = [data valueForKey:@"from_time"];
                 NSString *stris_break = [data valueForKey:@"is_break"];
                 NSString *strname = [data valueForKey:@"name"];
                 NSString *strperiod = [data valueForKey:@"period"];
                 NSString *strsubject_name = [data valueForKey:@"subject_name"];
                 NSString *strto_time = [data valueForKey:@"to_time"];
                 
                 [class_id addObject:strclass_id];
                 [day addObject:strday];
                 [from_time addObject:strfrom_time];
                 [is_break addObject:stris_break];
                 [name addObject:strname];
                 [period addObject:strperiod];
                 [subject_name addObject:strsubject_name];
                 [to_time addObject:strto_time];
             }
                 [self.tableView reloadData];
         }
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error: %@", error);
     }];
}
@end
