//
//  CorrectionViewController.m
//  LUTeacher
//
//  Created by Preeti Patil on 06/06/18.
//  Copyright © 2018 Set Infotech. All rights reserved.
//

#import "LUCorrectionViewController.h"
#import "LUNotesDrawingView.h"
@interface LUCorrectionViewController ()

@end

@implementation LUCorrectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
int thumbTap = 0;
- (IBAction)thumbnailAction:(id)sender
{
    
    if (thumbTap == 0)
    {
        
        
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      _thumbnailView.frame = CGRectMake(_thumbnailView.frame.origin.x, _thumbnailView.frame.origin.y + 440, _thumbnailView.frame.size.width, _thumbnailView.frame.size.height);
                                  }
                                  completion:^(BOOL finished)
         {
             //_animationInProgress = NO;
         }];
        thumbTap++;
    }else
    {
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      _thumbnailView.frame = CGRectMake(_thumbnailView.frame.origin.x, _thumbnailView.frame.origin.y - 440 , _thumbnailView.frame.size.width, _thumbnailView.frame.size.height);
                                  }
                                  completion:^(BOOL finished)
         {
             //_animationInProgress = NO;
         }];
        thumbTap=0;
    }
}

/**
 <#Description#>
 */
-(void)updateButtonStatus
{
    self.undo.enabled = [self.CorrectionDrawView canUndo];
    
    self.redo.enabled = [self.CorrectionDrawView canRedo];
}

/**
 <#Description#>
 
 @param sender <#sender description#>
 */
- (IBAction)undo:(id)sender
{
    [self.CorrectionDrawView undoLatestStep];
    [self updateButtonStatus];
}

/**
 <#Description#>
 
 @param sender <#sender description#>
 */
- (IBAction)redo:(id)sender
{
    [self.CorrectionDrawView redoLatestStep];
    [self updateButtonStatus];
}




@end
