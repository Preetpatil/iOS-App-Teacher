//
//  LUTimeTableCalendarEventCell.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LUTimeTableCalendarEventCell.h"

@implementation LUTimeTableCalendarEventCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    //self.layer.cornerRadius = 15;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0.7 alpha:1] CGColor];
}

@end
