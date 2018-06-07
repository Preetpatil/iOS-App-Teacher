                                                                                                                                                                                                              //
//  LUTeacherTimeTableViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUTeacherTimeTableViewController.h"
#import "LUTeacherCalendarDataSource.h"
#import "LUHeaderView.h"

@implementation LUTeacherTimeTableViewController
{
        NSArray *color,*week,*arrayObject;
        NSMutableDictionary *subColor ,*todayColor;
        LUTeacherCalendarDataSource *dataSource;
        NSString *subForDetails;
        CGFloat initial;
    NSMutableArray *temp10;
      NSMutableArray *todaySubject, *todayClassName, *todayStartTime, *todayEndTime;
    NSString *token, *userRoleName;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    temp10 = [[NSMutableArray alloc]init];
    todaySubject = [[NSMutableArray alloc] init];
    todayClassName = [[NSMutableArray alloc] init];
    todayStartTime= [[NSMutableArray alloc] init];
    todayEndTime= [[NSMutableArray alloc] init];
    [self createHeader];
    week = @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    subColor = [[NSMutableDictionary alloc]init];
    todayColor = [[NSMutableDictionary alloc]init];
    color=[NSArray arrayWithObjects:
           [UIColor colorWithRed:77.0/255.0 green:171.0/255.0 blue:255.0/255.0 alpha:0.8],
           [UIColor colorWithRed:183.0/255.0 green:255.0/255.0 blue:189.0/255.0 alpha:0.8],
           [UIColor colorWithRed:255.0/255.0 green:124.0/255.0 blue:125.0/255.0 alpha:0.8],
           [UIColor colorWithRed:192.0/255.0 green:156.0/255.0 blue:255.0/255.0 alpha:0.8],
           [UIColor colorWithRed:227.0/255.0 green:50.0/255.0 blue:140.0/255.0 alpha:0.8],
           [UIColor colorWithRed:204.0/255.0 green:206.0/255.0 blue:0.0/255.0 alpha:0.8],
           [UIColor colorWithRed:0.0/255.0 green:165.0/255.0 blue:169.0/255.0 alpha:0.8],
           [UIColor colorWithRed:254.0/255.0 green:39.0/255.0 blue:18.0/255.0 alpha:0.8],
           [UIColor colorWithRed:204.0/255.0 green:206.0/255.0 blue:0.0/255.0 alpha:0.8],
           [UIColor colorWithRed:0.0/255.0 green:165.0/255.0 blue:169.0/255.0 alpha:0.8],
           nil];
    // Register NIB for supplementary views
    UINib *headerViewNib = [UINib nibWithNibName:@"LUHeaderView" bundle:nil];
    [self.teacherTimeTable registerNib:headerViewNib forSupplementaryViewOfKind:@"DayHeaderView" withReuseIdentifier:@"LUHeaderView"];
    [self.teacherTimeTable registerNib:headerViewNib forSupplementaryViewOfKind:@"HourHeaderView" withReuseIdentifier:@"LUHeaderView"];
    // Define cell and header view configuration
    dataSource = (LUTeacherCalendarDataSource *)self.teacherTimeTable.dataSource;
    dataSource.configureCellBlock = ^(LUTimeTableCalendarEventCell *cell, NSIndexPath *indexPath, id<LUTimeTableCalendarEvent> event) {
        cell.titleLabel.text = event.title;
        subForDetails = event.title;
        cell.timeLabel.text =[NSString stringWithFormat:@"%@-%@",event.startTime,event.endTime];
        
        cell.titleLabel.textColor=[UIColor whiteColor];
        if ([cell.titleLabel.text isEqualToString:@"Lunch"])
        {
            cell.backgroundColor = [UIColor grayColor];
            cell.layer.borderWidth = 0.0;
        }else if ([cell.titleLabel.text isEqualToString:@"Break"])
        {
            cell.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
            cell.layer.borderWidth = 0.0;
        }
        else
        {
            cell.layer.cornerRadius = 5;
            cell.backgroundColor = [color objectAtIndex:[self checkColor:cell.titleLabel.text]];
        }
    };
    dataSource.configureHeaderViewBlock = ^(LUHeaderView *LUHeaderView, NSString *kind, NSIndexPath *indexPath) {
        if ([kind isEqualToString:@"DayHeaderView"])
        {
            //LUHeaderView.titleLabel.text =[week objectAtIndex:indexPath.item];
        } else if ([kind isEqualToString:@"HourHeaderView"])
        {
            LUHeaderView.titleLabel.text = [NSString stringWithFormat:@"%2ld:00", indexPath.item + 1];
            initial = LUHeaderView.frame.origin.y;
            [self currentTime: [NSString stringWithFormat:@"%2ld", indexPath.item + 1]];
        }
    };
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveTestNotification:) name:@"receiveTestNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailAction:) name:@"detailAction" object:nil];

    // Do any additional setup after loading the view, typically from a nib.
    ///[self.navigationController setNavigationBarHidden:NO animated:NO];

    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(today)
                                   userInfo:nil
                                    repeats:NO];


}

-(void)today
{
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSLog(@"day of the week: %li", (long)[dateComponents weekday]);
    
    
    NSDictionary *mainResponse = [LUOperation getSharedInstance].userProfileDetails;
    
    NSDictionary *secondResponse = [mainResponse objectForKey:@"item"];
    
    userRoleName = [secondResponse objectForKey:@"RoleName"];
    
    if ([userRoleName isEqualToString:@"Teacher"])
    {
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        
        sharedSingleton.LUDelegateCall=self;
        
        [sharedSingleton populateTodayTable:Today_time_table dayNo:[NSString stringWithFormat:@"%li",(long)[dateComponents weekday]-1 ]];
    }
    
    else if ([userRoleName isEqualToString:@"Student"])
    {
        LUOperation *sharedSingleton = [LUOperation getSharedInstance];
        
        sharedSingleton.LUDelegateCall=self;
        
        [sharedSingleton populateTodayTable:TodayTimeTable_Link dayNo:[NSString stringWithFormat:@"%li",(long)[dateComponents weekday] ]];
    }

    
}

-(void)currentTime:(NSString*)now
{
    NSDate * hrmm = [NSDate date];
    NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
    [hourFormatter setDateFormat:@"HH"];
    NSDateFormatter *minuteFormatter = [[NSDateFormatter alloc] init];
    [minuteFormatter setDateFormat:@"mm"];
    NSString *hourString = [hourFormatter stringFromDate:hrmm];
    NSString *minuteString = [minuteFormatter stringFromDate:hrmm];
    CAShapeLayer *shapeLayer;
    UIBezierPath *path;
    
    if ([hourString isEqualToString:now])
    {
        [shapeLayer removeFromSuperlayer];
        [path removeAllPoints];
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(10.0, initial+[minuteString floatValue])];
        [path addLineToPoint:CGPointMake(1355.0, initial+[minuteString floatValue])];
        shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor redColor] CGColor];
        shapeLayer.lineWidth = 1.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        [self.teacherTimeTable.layer addSublayer:shapeLayer];
    }
}

- (void) receiveTestNotification:(NSNotification *)notification
{
    [self.teacherTimeTable reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.teacherTimeTable scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

-(void)createHeader
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(400, 150, 950, 80)];
        header.backgroundColor=[UIColor colorWithRed:1.00 green:0.85 blue:0.40 alpha:2.0];
        header.layer.masksToBounds = false;
        header.layer.shadowColor = [UIColor blackColor].CGColor;
        header.layer.shadowOffset = CGSizeMake(2,2);
        header.layer.shadowOpacity = 0.50;
        header.layer.shadowRadius = 1.0;
        [self.view addSubview:header];
        
        CGFloat width =header.bounds.size.width/8;
        CGFloat x =125;
        NSArray *day = @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *date = [NSDate date];
        
        UILabel *weekOfYear =[[UILabel alloc]initWithFrame:CGRectMake(10,header.bounds.size.height/2+15,width,21)];
        weekOfYear.text = [NSString stringWithFormat:@"%@ week",
                           [self getOrdinalStringFromInteger:[[calendar components: NSCalendarUnitWeekOfYear fromDate:date] weekOfYear]]];
        [weekOfYear setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [weekOfYear setTextAlignment:0];
        [header addSubview:weekOfYear];
        
        UILabel *ttLabel =[[UILabel alloc]initWithFrame:CGRectMake(header.bounds.size.width/2-50,header.bounds.size.height/2-30,120,21)];
        ttLabel.text = @"Week";
        [ttLabel setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        [ttLabel setTextAlignment:1];
        [header addSubview:ttLabel];
        
        
        for (int i=0;i<7;i++)
        {
            UILabel *loopWeek =[[UILabel alloc]initWithFrame:CGRectMake(x-50,header.bounds.size.height/2+15,width,21)];
            loopWeek.text = [day objectAtIndex:i];
            loopWeek.textColor = [UIColor blackColor];
            //loopWeek.backgroundColor = [UIColor lightGrayColor];
            [loopWeek setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            [loopWeek setTextAlignment:2];
            [header addSubview:loopWeek];
            x=x+width;
        }
    });
}

- (NSString *)getOrdinalStringFromInteger:(long)integer
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setNumberStyle:NSNumberFormatterOrdinalStyle];
    return [formatter stringFromNumber:[NSNumber numberWithInteger:integer]];
}

//-(void)todayAction
//{
//    [dataSource today ];
//}

-(NSInteger)checkColor:(NSString *)subjectName
{
    NSInteger  idx;
    if ([[subColor allKeys]containsObject:subjectName])
    {
        idx =[[subColor objectForKey:subjectName] integerValue];
    }
    else
    {
        [todayColor setObject:[NSString stringWithFormat:@"%lu",(unsigned long)subColor.count] forKey:subjectName];
        [subColor setObject:[NSString stringWithFormat:@"%lu",(unsigned long)subColor.count] forKey:subjectName];
        idx =[[subColor objectForKey:subjectName] integerValue];
    }
    return idx;
}

-(NSInteger)checkColorToday:(NSString *)subjectName
{
    NSInteger  idx;
    if ([[todayColor allKeys]containsObject:subjectName])
    {
        idx =[[todayColor objectForKey:subjectName] integerValue];
    }
    else
    {
        [todayColor setObject:[NSString stringWithFormat:@"%lu",(unsigned long)todayColor.count] forKey:subjectName];
        [subColor setObject:[NSString stringWithFormat:@"%lu",(unsigned long)subColor.count] forKey:subjectName];
        idx =[[todayColor objectForKey:subjectName] integerValue];
    }
    return idx;
}

-(void)getData:(NSString *)key
{
    //Teacher Login
    // 1
    NSURL *url = [NSURL URLWithString:Login];
    // 2
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 3
    NSDictionary *loginCredentials = @{@"username": @"allen@gmail.com", @"password":@"rakesh", @"RoleName":@"Teacher"};
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:loginCredentials options:kNilOptions error:&error];
    [request setHTTPBody:data];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData *data,NSURLResponse *response,NSError *error)
                                  { dispatch_async(dispatch_get_main_queue(),
                                                   ^{
                                                       if (!error)
                                                       {
                                                           NSLog(@"Status code: %li", (long)((NSHTTPURLResponse *)response).statusCode);
                                                        NSDictionary *userLoginList = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                           token = [[userLoginList valueForKey:@"item"] valueForKey:@"Token"];
                                                       }
                                                       else
                                                       {
                                                           NSLog(@"Error: %@", error.localizedDescription);
                                                       }
                                                   });
                                  }];
    [task resume];
}

- (void) displayTodayTimetable: (NSArray *)todayTimeTable{
    
    for(int i=0 ; i <[todayTimeTable count]; i++)
    {
        NSDictionary *firstResponse = [todayTimeTable objectAtIndex:i];
        [todayClassName addObject:[firstResponse objectForKey:@"ClassName"]];
        [todaySubject addObject:[firstResponse objectForKey:@"SubjectName"]];
        [todayStartTime addObject:[firstResponse objectForKey:@"ScheduleFromTime"]];
        [todayEndTime addObject:[firstResponse objectForKey:@"ScheduleToTime"]];
    }
    [self.todayTT reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TodayCellId";
    
    LUTeacherTodayCell *todayTableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (todayTableCell == nil)
    {
        todayTableCell = [[LUTeacherTodayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    todayTableCell.className.text = [todayClassName objectAtIndex:indexPath.row];
    todayTableCell.subjectName.text = [todaySubject objectAtIndex:indexPath.row];
    todayTableCell.startTime.text = [todayStartTime objectAtIndex:indexPath.row];
    todayTableCell.endTime.text = [todayEndTime objectAtIndex:indexPath.row];
    
    if ([todayTableCell.subjectName.text isEqualToString:@"Lunch"])
    {
        todayTableCell.layer.cornerRadius = 5;
        todayTableCell.className.textColor=[UIColor whiteColor];
        todayTableCell.subjectName.textColor=[UIColor whiteColor];
        todayTableCell.startTime.textColor=[UIColor whiteColor];
        todayTableCell.endTime.textColor=[UIColor whiteColor];
        todayTableCell.backgroundColor = [UIColor grayColor];
        todayTableCell.layer.borderWidth = 0.0;
    }
    else if ([todayTableCell.subjectName.text isEqualToString:@"Break"])
    {
        todayTableCell.layer.cornerRadius = 5;
        todayTableCell.className.textColor=[UIColor whiteColor];
        todayTableCell.subjectName.textColor=[UIColor whiteColor];
        todayTableCell.startTime.textColor=[UIColor whiteColor];
        todayTableCell.endTime.textColor=[UIColor whiteColor];
        todayTableCell.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        todayTableCell.layer.borderWidth = 0.0;
    }
    else
    {
        todayTableCell.layer.cornerRadius = 5;
        todayTableCell.backgroundColor = [color objectAtIndex:[self checkColorToday:todayTableCell.subjectName.text]];
    }
    return todayTableCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return todayClassName.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
