//
//  calculatorViewController.m
//  calculator
//
//  Created by Corinn Pope on 8/5/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

//
//  calculatorViewController.m
//  TriShake
//
//  Created by Corinn Pope on 2/21/13.
//  Copyright (c) 2013 Corinn Pope. All rights reserved.
//

#import "calculatorViewController.h"
#import "NSObject+KVOBlock.h"

@interface calculatorViewController ()

@end

@implementation calculatorViewController {

    double t1Pace;
    double t2Pace;
    
    double swimSprintConversion;
    double swimOlyConversion;
    double swimHalfConversion;
    double swimFullConversion;
    
    double bikeSprintConversionMiles;
    double bikeOlyConversionMiles;
    double bikeHalfConversionMiles;
    double bikeFullConversionMiles;
    
    double runSprintConversionMiles;
    double runOlyConversionMiles;
    double runHalfConversionMiles;
    double runFullConversionMiles;
    
    double bikeSprintConversionKM;
    double bikeOlyConversionKM;
    double bikeHalfConversionKM;
    double bikeFullConversionKM;
    
    double runSprintConversionKM;
    double runOlyConversionKM;
    double runHalfConversionKM;
    double runFullConversionKM;
    
    
    double totalSprintTimeMiles;
    double totalOlyTimeMiles;
    double totalHalfTimeMiles;
    double totalFullTimeMiles;
    
    double totalSprintTimeKM;
    double totalOlyTimeKM;
    double totalHalfTimeKM;
    double totalFullTimeKM;
}

@synthesize swimSlider, bikeSlider, runSlider, t1Slider, t2Slider;
@synthesize swimPaceLabel, bikePaceLabel, runPaceLabel, t1PaceLabel, t2PaceLabel;
@synthesize projectedFinishTime;
@synthesize infoButton;
@synthesize unitControl, distanceControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
	// Do any additional setup after loading the view.
    //set sliders to continuously update
    swimSlider.continuous=YES;
    bikeSlider.continuous=YES;
    runSlider.continuous=YES;
    t1Slider.continuous=YES;
    t2Slider.continuous=YES;
    
    [swimSlider addTarget:self action:@selector(swimSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [bikeSlider addTarget:self action:@selector(bikeSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [runSlider addTarget:self action:@selector(runSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [t1Slider addTarget:self action:@selector(t1SliderChanged:) forControlEvents:UIControlEventValueChanged];
    [t2Slider addTarget:self action:@selector(t2SliderChanged:) forControlEvents:UIControlEventValueChanged];

    
    swimSprintConversion = ((self.swimSlider.value * 60)/100)*750;
    bikeSprintConversionMiles = (20000/(self.bikeSlider.value * .44));
    runSprintConversionMiles = (self.runSlider.value * 0.037)*5000;
    totalSprintTimeMiles = swimSprintConversion+bikeSprintConversionMiles+runSprintConversionMiles+t1Pace+t2Pace;
    NSTimeInterval sprintValue = totalSprintTimeMiles;
    [self translateTime:&sprintValue];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma info button
- (IBAction)infoButtonPressed:(id)sender {
    //show different values for race distances in an alertview
    UIAlertView *distanceInfo = [[UIAlertView alloc] initWithTitle:@"Race Distance Values" message:@"Sprint: 750m swim, 20K bike, 5K run.\n\n Olympic: 1500m swim, 40K bike, 10K run.\n\n Half-IM: 1900m swim, 90K bike, 13.1 mile run.\n\n IM: 3800m swim, 180K bike, 26.2 mile run." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [distanceInfo show];    
}

#pragma time translations
-(void) translateTime: (NSTimeInterval*)distanceValue{
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    self.projectedFinishTime.text= [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:*distanceValue]];
    
}



#pragma Math!

- (IBAction)swimSliderChanged:(id)sender {
    swimSlider.continuous=YES;
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = self.swimSlider.value * 60;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    swimPaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];
    
    //listen for slider value change
    [swimSlider addTarget:self action:@selector(swimSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    NSLog(@"Swim pace slider value is:%g",self.swimSlider.value);
    
}

- (IBAction)bikeSliderChanged:(id)sender {

    
    bikePaceLabel.text = [[NSString alloc] initWithFormat:@"%1.2f",(self.bikeSlider.value)];
    
    [bikeSlider addTarget:self action:@selector(bikeSliderChanged:)forControlEvents:UIControlEventValueChanged];

}

- (IBAction)runSliderChanged:(id)sender {

    
    //moved from after set label
    [runSlider addTarget:self action:@selector(runSliderChanged:)forControlEvents:UIControlEventValueChanged];
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = self.runSlider.value * 60;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    runPaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];

}

#pragma transition calculations

- (IBAction)t1SliderChanged:(id)sender {
    //convert minutes per transition to seconds per transition
    double t1PaceConversion = self.t1Slider.value * 60;
    t1Pace = t1PaceConversion;
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = t1Pace;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    t1PaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];

}

- (IBAction)t2SliderChanged:(id)sender {
    //convert minutes per transition to seconds per transition
    double t2PaceConversion = self.t2Slider.value * 60;
    t2Pace = t2PaceConversion;
    
    //change label to hh:mm:ss format
    NSTimeInterval intervalValue = t2Pace;
    NSDateFormatter *hmsFormatter = [[NSDateFormatter alloc] init];
    [hmsFormatter setDateFormat:@"HH:mm:ss"];
    [hmsFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSLog(@"formatted date: %@", [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]]);
    
    t2PaceLabel.text = [hmsFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceReferenceDate:intervalValue]];

}

#pragma segmented controllers

- (IBAction)distanceControlIndexChanged:(id)sender {
    switch (self.distanceControl.selectedSegmentIndex) {
            //
            //SPRINT DISTANCE
            //
        case 0:
            //
            //Do conversions
            //
            //calculate sprint time (miles)
            swimSprintConversion = ((self.swimSlider.value * 60)/100)*750;
            bikeSprintConversionMiles = (20000/(self.bikeSlider.value * .44));
            runSprintConversionMiles = (self.runSlider.value * 0.037)*5000;
            totalSprintTimeMiles = swimSprintConversion+bikeSprintConversionMiles+runSprintConversionMiles+t1Pace+t2Pace;
            NSLog(@"total sprint time for miles is: %f", totalSprintTimeMiles);
            
            //calculate sprint time (kilometers)
            bikeSprintConversionKM = (20000/(self.bikeSlider.value * .28));
            runSprintConversionKM = (self.runSlider.value * 0.06)*5000;
            totalSprintTimeKM = swimSprintConversion + bikeSprintConversionKM+runSprintConversionKM+t1Pace+t2Pace;
            NSLog(@"total sprint time in km is: %f", totalSprintTimeKM);

            //
            //unit conversion display
            //
            //if miles and sprint, display time in miles
            if (self.unitControl.selectedSegmentIndex == 0) {
                NSTimeInterval sprintValue = totalSprintTimeMiles;
                [self translateTime:&sprintValue];
            }
            
            //if km and sprint, display time in km
            if (self.unitControl.selectedSegmentIndex ==1) {
                NSTimeInterval sprintKMValue = totalSprintTimeKM;
                [self translateTime:&sprintKMValue];
            }
            
            break;
            //
            //OLYMPIC DISTANCE
            //
        case 1:
            //calculate olympic time (miles)
            swimOlyConversion = ((self.swimSlider.value * 60)/100)*1500;
            bikeOlyConversionMiles = (40000/(self.bikeSlider.value * .44));
            runOlyConversionMiles = (self.runSlider.value * 0.037)*10000;
            totalOlyTimeMiles = swimOlyConversion+bikeOlyConversionMiles+runOlyConversionMiles+t1Pace+t2Pace;
            NSLog(@"total oly time for miles is: %f", totalOlyTimeMiles);
            
            //calculate oly time (kilometers)
            bikeOlyConversionKM = (40000/(self.bikeSlider.value * .28));
            runOlyConversionKM = (self.runSlider.value * 0.06)*10000;
            totalOlyTimeKM = swimOlyConversion + bikeOlyConversionKM+runOlyConversionKM+t1Pace+t2Pace;
            NSLog(@"total oly time in km is: %f", totalOlyTimeKM);

            //
            //unit conversion display
            //
            //if miles and oly, display time in miles
            if (self.unitControl.selectedSegmentIndex == 0) {
                NSTimeInterval olyValue = totalOlyTimeMiles;
                [self translateTime:&olyValue];
            }
            
            //if km and oly, display time in km
            if (self.unitControl.selectedSegmentIndex ==1) {
                NSTimeInterval olyKMValue = totalOlyTimeKM;
                [self translateTime:&olyKMValue];
            }
            
            
            break;
            //
            //HALF DISTANCE
            //
        case 2:
            //calculate half time (miles)
            swimHalfConversion = ((self.swimSlider.value * 60)/100)*1900;
            bikeHalfConversionMiles = (90000/(self.bikeSlider.value * .44));
            runHalfConversionMiles = (self.runSlider.value * 0.037)*21100;
            totalHalfTimeMiles = swimHalfConversion+runHalfConversionMiles+bikeHalfConversionMiles+t1Pace+t2Pace;
            NSLog(@"total half time for miles is: %f", totalHalfTimeMiles);

            //calculate half time (kilometers)
            bikeHalfConversionKM = (90000/(self.bikeSlider.value * .28));
            runHalfConversionKM = (self.runSlider.value * 0.06)*21100;
            totalHalfTimeKM = swimHalfConversion + bikeHalfConversionKM + runFullConversionKM + t1Pace+t2Pace;
            NSLog(@"total half time in km is: %f", totalHalfTimeKM);
            
            //
            //unit conversion display
            //
            //if miles and oly, display time in miles
            if (self.unitControl.selectedSegmentIndex == 0) {
                NSTimeInterval halfValue = totalHalfTimeMiles;
                [self translateTime:&halfValue];
            }
            
            //if km and oly, display time in km
            if (self.unitControl.selectedSegmentIndex ==1) {
                NSTimeInterval halfKMValue = totalHalfTimeKM;
                [self translateTime:&halfKMValue];
            }
            
            break;
            
            //
            //FULL IRONMAN DISTANCE
            //
        case 3:
            //calculate full time (miles)
            swimFullConversion = ((self.swimSlider.value * 60)/100)*3800;
            bikeFullConversionMiles = (180000/(self.bikeSlider.value * .44));
            runFullConversionMiles = (self.runSlider.value * 0.037)*42200;
            totalFullTimeMiles = swimFullConversion+bikeFullConversionMiles+runFullConversionMiles+t1Pace+t2Pace;
            NSLog(@"total full time for miles is: %f", totalFullTimeMiles);
            
            //calculate full time (kilometers)
            bikeFullConversionKM = (180000/(self.bikeSlider.value * .28));
            runFullConversionKM = (self.runSlider.value * 0.06)*42200;
            totalFullTimeKM = swimFullConversion + bikeFullConversionKM + runFullConversionKM + t1Pace+t2Pace;
            NSLog(@"total full time in km is: %f", totalFullTimeKM);
            
            
            //
            //unit conversion display
            //
            //if miles and oly, display time in miles
            if (self.unitControl.selectedSegmentIndex == 0) {
                NSTimeInterval fullValue = totalFullTimeMiles;
                [self translateTime:&fullValue];
            }
            
            //if km and oly, display time in km
            if (self.unitControl.selectedSegmentIndex ==1) {
                NSTimeInterval fullKMValue = totalFullTimeKM;
                [self translateTime:&fullKMValue];
            }
            
            break;
            
        default:
            break;
    
    }
}

- (IBAction)unitControlIndexChanged:(id)sender {
    switch (self.unitControl.selectedSegmentIndex) {
            //MILES OPTION
        case 0:
            //change description labels
            self.swimDescriptionLabel.text =@"Swim pace per 100m";
            self.bikeDescriptionLabel.text =@"Bike average mph";
            self.runDescriptionLabel.text=@"Run minutes per mile";
            
            if (self.distanceControl.selectedSegmentIndex ==0) {
                NSTimeInterval sprintValue = totalSprintTimeMiles;
                [self translateTime:&sprintValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==1) {
                NSTimeInterval olyValue = totalOlyTimeMiles;
                [self translateTime:&olyValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==2) {
                NSTimeInterval halfValue = totalHalfTimeMiles;
                [self translateTime:&halfValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==3) {
                NSTimeInterval fullValue = totalFullTimeMiles;
                [self translateTime:&fullValue];
            }

            break;
            //KILOMETERES OPTION
        case 1:
            //change description labels
            self.swimDescriptionLabel.text =@"Swim pace per 100m";
            self.bikeDescriptionLabel.text =@"Bike average kmh";
            self.runDescriptionLabel.text=@"Run minutes per km";
            
            //display project time in km
            if (self.distanceControl.selectedSegmentIndex ==0) {
                NSTimeInterval sprintKMValue = totalSprintTimeKM;
                [self translateTime:&sprintKMValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==1) {
                NSTimeInterval olyKMValue = totalOlyTimeKM;
                [self translateTime:&olyKMValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==2) {
                NSTimeInterval halfKMValue = totalHalfTimeKM;
                [self translateTime:&halfKMValue];
            }
            if (self.distanceControl.selectedSegmentIndex ==3) {
                NSTimeInterval fullKMValue = totalFullTimeKM;
                [self translateTime:&fullKMValue];
            }
            
            break;
            
        default:
            break;
    }
    
}


@end

