//
//  CommunicationViewCell.h
//  EducationApp
//
//  Created by HappySanz on 18/05/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunicationViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *circularType;
@property (weak, nonatomic) IBOutlet UITextView *detailView;

@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
