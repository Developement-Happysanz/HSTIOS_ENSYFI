//
//  TeacherCollectionViewCell.h
//  EducationApp
//
//  Created by HappySanz on 13/09/17.
//  Copyright © 2017 Palpro Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeacherCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *title;

@end
