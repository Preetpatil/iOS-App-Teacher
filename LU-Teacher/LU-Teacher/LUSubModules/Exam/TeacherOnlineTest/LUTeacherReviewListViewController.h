//
//  LUTeacherReviewListViewController.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LUHeader.h"


@interface LUTeacherReviewListViewController : UIViewController<UITableViewDataSource,LUDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reviewExam:(id)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end
