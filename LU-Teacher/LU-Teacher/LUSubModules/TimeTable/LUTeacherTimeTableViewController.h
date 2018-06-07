//
//  LUTeacherTimeTableViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#ifndef LUTeacherTimeTableViewController_h
#define LUTeacherTimeTableViewController_h


#endif /* LUTeacherTimeTableViewController_h */

#import <UIKit/UIKit.h>

#import "LUHeader.h"

#import "LUTeacherTodayCell.h"
#import "LUURLLink.h"
#define Today_time_table @"http://setumbrella.com/luservice/controller/api/studentController.php?Action=GetTodayTimeTableByTeacher"

#define Login @"http://setumbrella.com/luservice/controller/api/adminController.php?Action=login"

@interface LUTeacherTimeTableViewController : UIViewController<LUDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *teacherTimeTable;
//@property (strong, nonatomic) LUTeacherCalendarDataSource *calendarDataSource;
@property (weak, nonatomic) IBOutlet UITableView *todayTT;

@end
