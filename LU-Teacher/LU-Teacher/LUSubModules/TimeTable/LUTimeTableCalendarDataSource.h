//
//  LUTimeTableCalendarDataSource.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTimeTableCalendarEvent.h"
#import "LUTimeTableCalendarEventCell.h"
#import "LUHeaderView.h"
#import "LUStudentTimeTableViewController.h"
#import "LUTimeTableDetailViewController.h"
typedef enum {
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
} Weekday;

typedef void (^ConfigureCellBlock)(LUTimeTableCalendarEventCell *cell, NSIndexPath *indexPath, id<LUTimeTableCalendarEvent> event);
typedef void (^ConfigureHeaderViewBlock)(LUHeaderView *LUHeaderView, NSString *kind, NSIndexPath *indexPath);

@interface LUTimeTableCalendarDataSource : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>//LUDelegate

@property (copy, nonatomic) ConfigureCellBlock configureCellBlock;
@property (copy, nonatomic) ConfigureHeaderViewBlock configureHeaderViewBlock;
@property (copy, nonatomic) NSMutableArray*DayIdArry;
@property (copy, nonatomic) NSDictionary*period;



- (id<LUTimeTableCalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour;
-(void)today;
@end
