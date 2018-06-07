//
//  LUVideoPlayerViewController
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"



@interface LUVideoPlayerViewController : UIViewController<YTPlayerViewDelegate>
@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
@property NSString *header;
@property NSString *videoID;
@property NSString *type;
@end
