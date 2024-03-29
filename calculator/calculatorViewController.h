//
//  calculatorViewController.h
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calculatorViewController : UIViewController {
    UIButton *infoButton;
    
    UISlider *swimSlider;
    UISlider *bikeSlider;
    UISlider *runSlider;
    UISlider *t1Slider;
    UISlider *t2Slider;
    
    UILabel *projectedFinishTime;
    UILabel *olyFinishTime;
    UILabel *halfFinishTime;
    UILabel *fullFinishTime;
    
    UILabel *swimPaceLabel;
    UILabel *bikePaceLabel;
    UILabel *runPaceLabel;
    UILabel *t1PaceLabel;
    UILabel *t2PaceLabel;
    
    UIView *customView;
}

@property (strong, nonatomic) IBOutlet UISlider *swimSlider;
@property (strong, nonatomic) IBOutlet UISlider *bikeSlider;
@property (strong, nonatomic) IBOutlet UISlider *runSlider;
@property (strong, nonatomic) IBOutlet UISlider *t1Slider;
@property (strong, nonatomic) IBOutlet UISlider *t2Slider;

@property (strong, nonatomic) IBOutlet UILabel *swimPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *bikePaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *runPaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *t1PaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *t2PaceLabel;

@property (strong, nonatomic) IBOutlet UILabel *swimDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *bikeDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *runDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@property (strong, nonatomic) IBOutlet UILabel *projectedFinishTime;

@property (strong, nonatomic) IBOutlet UISegmentedControl *distanceControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *unitControl;


- (IBAction)swimSliderChanged:(id)sender;
- (IBAction)bikeSliderChanged:(id)sender;
- (IBAction)runSliderChanged:(id)sender;


- (IBAction)t1SliderChanged:(id)sender;
- (IBAction)t2SliderChanged:(id)sender;
- (IBAction)infoButtonPressed:(id)sender;

- (IBAction)distanceControlIndexChanged:(id)sender;
- (IBAction)unitControlIndexChanged:(id)sender;


- (void) displayProjectedRaceTime;


@end
