//
//  LUTeacherCalendarDataSource.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUTeacherCalendarDataSource.h"

#import "LUTimeTableSampleCalendarEvent.h"
@interface LUTeacherCalendarDataSource ()

@property (strong, nonatomic) NSMutableArray *events;


@end


@implementation LUTeacherCalendarDataSource
{
    int day;
    int hour;
    int durationHour;
    int durationMinutes;
    int startMinutes;
    NSMutableArray *periodCount;
    NSMutableArray *details;
    BOOL enableToday;
    NSArray *userLoginList;
    NSString *token;
    NSMutableArray *DayId, *DayName, *testdata, *SubjectName, *ClassName, *ScheduleFromTime, *ScheduleToTime;
    NSMutableArray *todaySubject, *todayClassName, *todayStartTime, *todayEndTime;
    NSString*userRoleName;
}

- (void)awakeFromNib
{
    enableToday = NO;
    _events = [[NSMutableArray alloc] init];
    periodCount = [[NSMutableArray alloc] init];
    DayId = [[NSMutableArray alloc] init];
    DayName = [[NSMutableArray alloc] init];
    testdata = [[NSMutableArray alloc] init];
    SubjectName = [[NSMutableArray alloc] init];
    ClassName = [[NSMutableArray alloc] init];
    ScheduleFromTime = [[NSMutableArray alloc] init];
    ScheduleToTime = [[NSMutableArray alloc] init];
    details = [[NSMutableArray alloc] init];
    todaySubject = [[NSMutableArray alloc] init];
    todayClassName = [[NSMutableArray alloc] init];
    todayStartTime= [[NSMutableArray alloc] init];
    todayEndTime= [[NSMutableArray alloc] init];
    
    NSDictionary *mainResponse = [LUOperation getSharedInstance].userProfileDetails;
    
    NSDictionary *secondResponse = [mainResponse objectForKey:@"item"];
    
    userRoleName = [secondResponse objectForKey:@"RoleName"];
    
    if ([userRoleName isEqualToString:@"Teacher"])
    {
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton teacherTimeTableList: Time_table ];
    }
    
    else if ([userRoleName isEqualToString:@"Student"])
    {
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        sharedSingleton.LUDelegateCall=self;
        [sharedSingleton teacherTimeTableList: Timetable_Link ];
    }
    
    
    _todayHeader.layer.masksToBounds = false;
    _todayHeader.layer.shadowColor = [UIColor blackColor].CGColor;
    _todayHeader.layer.shadowOffset = CGSizeMake(2,2);
    _todayHeader.layer.shadowOpacity = 0.50;
    _todayHeader.layer.shadowRadius = 1.0;

    
    
  //  timeTableList
}

-(void)today
{
    //    enableToday = YES;
    //    [_events removeAllObjects];
    //    [self getData:@"today"];
}

- (void)generateSampleData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSUInteger idx = 0; idx < periodCount.count; idx++)
        {
            NSDictionary *period = [periodCount objectAtIndex:idx];
            //SubjectName ScheduleFromTime ScheduleToTime
            if ([[period allKeys] containsObject:@"details"])
            {
                [details addObject:[period objectForKey:@"details"]];
            }
            else
            {
                [details addObject:@""];
            }
            NSString *subName = [period objectForKey:@"SubjectName"];
            day = [self weekday: [period objectForKey:@"DayName"]];
            NSString *dateStartString = [period objectForKey:@"ScheduleFromTime"];
            NSString *dateEndString = [period objectForKey:@"ScheduleToTime"];
            hour = [[[dateStartString substringWithRange:NSMakeRange(0, 2)] stringByReplacingOccurrencesOfString:@":" withString:@"" ]intValue]-1;
            durationHour = 1;
            durationMinutes =[[period objectForKey:@"Duration"] intValue];
            startMinutes =[[[dateStartString substringWithRange:NSMakeRange(2, 3)]
                            stringByReplacingOccurrencesOfString:@":" withString:@"" ]intValue];
            LUTimeTableSampleCalendarEvent *event = [LUTimeTableSampleCalendarEvent randomEvent:subName randomDay:day randomHour:hour randomStartTime:dateStartString randomEndTime:dateEndString   randomDuration:durationHour randomDurationMinutes:durationMinutes randomStartDurationMinutes:startMinutes];
            
            [self.events addObject:event];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveTestNotification" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveTestNotification" object:nil];
    });
}

-(void)teachetTimeTableList:(NSArray *)timetablelist
{
                                                            for (int i=0; i<[timetablelist count]; i++)
                                                           {
                                                               NSDictionary *firstResponse = [timetablelist objectAtIndex:i];
                                                               [DayId addObject:[firstResponse objectForKey:@"DayId"]];
                                                               [DayName addObject:[firstResponse objectForKey:@"DayName"]];
                                                               [testdata addObject:[firstResponse objectForKey:@"TimetableData"]];
                                                           }
                                                           
                                                           for (int i=0; i<[testdata count]; i++)
                                                           {
                                                               
                                                               NSArray *temp = [testdata objectAtIndex:i];
                                                               if ( [temp isKindOfClass:[NSArray class]])
                                                               {
                                                                   
                                                                   
                                                                   for (int j=0; j< temp.count; j++)
                                                                   {
                                                                       NSDictionary *secondResponse = [temp objectAtIndex:j];
                                                                       [periodCount addObject:secondResponse];
                                                                      
                                                                   }
                                                               }
                                                           }
    
                                                           [self generateSampleData];
    

}

-(int)weekday:(NSString*)weekday
{
    if ([weekday isEqualToString:@"Monday"])
    {
        day = Monday;
    }else if ([weekday isEqualToString:@"Tuesday"])
    {
        day = Tuesday;
    }
    else if ([weekday isEqualToString:@"Wednesday"])
    {
        day = Wednesday;
    }
    else if ([weekday isEqualToString:@"Thursday"])
    {
        day = Thursday;
    }
    else if ([weekday isEqualToString:@"Friday"])
    {
        day = Friday;
    }
    else if ([weekday isEqualToString:@"Saturday"])
    {
        day = Saturday;
    }
    else if ([weekday isEqualToString:@"Sunday"])
    {
        day = Sunday;
    }
    return day;
}
#pragma mark - LUTeacherCalendarDataSource

// The layout object calls these methods to identify the events that correspond to
// a given index path or that are visible in a certain rectangle

- (id<LUTimeTableCalendarEvent>)eventAtIndexPath:(NSIndexPath *)indexPath
{
    return self.events[indexPath.item];
}


- (NSArray *)indexPathsOfEventsBetweenMinDayIndex:(NSInteger)minDayIndex maxDayIndex:(NSInteger)maxDayIndex minStartHour:(NSInteger)minStartHour maxStartHour:(NSInteger)maxStartHour
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    [self.events enumerateObjectsUsingBlock:^(id event, NSUInteger idx, BOOL *stop) {
        if ([event day] >= minDayIndex && [event day] <= maxDayIndex && [event startHour] >= minStartHour && [event startHour] <= maxStartHour)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
            [indexPaths addObject:indexPath];
        }
    }];
    return indexPaths;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<LUTimeTableCalendarEvent> event = self.events[indexPath.item];
    LUTimeTableCalendarEventCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarEventCell" forIndexPath:indexPath];
    if (self.configureCellBlock) {
        self.configureCellBlock(cell, indexPath, event);
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LUHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LUHeaderView" forIndexPath:indexPath];
    if (self.configureHeaderViewBlock) {
        self.configureHeaderViewBlock(headerView, kind, indexPath);
    }
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (enableToday )
    {
        NSDictionary *temp = [details objectAtIndex:indexPath.row];
        if (![temp  isEqual: @""])
        {
            NSArray *tempDetail =[temp allValues];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"detailAction" object:tempDetail];
        }
    }
}



@end

