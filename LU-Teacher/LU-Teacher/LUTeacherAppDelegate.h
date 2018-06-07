//
//  LUTeacherAppDelegate.h
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LUReachability.h"

extern NSString *const pasteboardIdentifier;

@interface LUTeacherAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) LUReachability *reachabile;//trial

@property (nonatomic, retain) NSString *AlertMessage;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *view;
@property (strong, nonatomic) UILabel *label;

@property (nonatomic, assign) BOOL internetActive;
@property (nonatomic, assign) BOOL hostActive;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

