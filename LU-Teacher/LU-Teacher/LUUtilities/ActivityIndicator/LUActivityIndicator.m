//
//  LUActivityIndicator.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUActivityIndicator.h"

@implementation LUActivityIndicator

- (void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    NSArray *imageNames = @[@"a1.png", @"a2.png", @"a3.png"];
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++)
    {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    UIImageView *activityIndicator = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-32, self.frame.size.height/2-32, 64, 64)];
    activityIndicator.animationImages = images;
    activityIndicator.animationDuration = 1.0f;
    activityIndicator.animationRepeatCount = 0;
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
    
}

@end
