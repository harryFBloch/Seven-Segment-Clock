//
//  ViewController.h
//  SevenSegment
//
//  Created by harry bloch on 2/3/16.
//  Copyright © 2016 harry bloch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
//segments for first hour digit
@property (strong, nonatomic) IBOutlet UIImageView *segment11;
@property (strong, nonatomic) IBOutlet UIImageView *segment12;
@property (strong, nonatomic) IBOutlet UIImageView *segment13;
@property (strong, nonatomic) IBOutlet UIImageView *segment14;
@property (strong, nonatomic) IBOutlet UIImageView *segment15;
@property (strong, nonatomic) IBOutlet UIImageView *segment16;
@property (strong, nonatomic) IBOutlet UIImageView *segment17;

//segments for second hour digit
@property (strong, nonatomic) IBOutlet UIImageView *segment21;
@property (weak, nonatomic) IBOutlet UIImageView *segment22;
@property (weak, nonatomic) IBOutlet UIImageView *segment23;
@property (weak, nonatomic) IBOutlet UIImageView *segment24;
@property (weak, nonatomic) IBOutlet UIImageView *segment25;
@property (weak, nonatomic) IBOutlet UIImageView *segment26;
@property (weak, nonatomic) IBOutlet UIImageView *segment27;

//decimal point separator
@property (weak, nonatomic) IBOutlet UIImageView *seperator;

//segment for first minutes place
@property (weak, nonatomic) IBOutlet UIImageView *segment31;
@property (weak, nonatomic) IBOutlet UIImageView *segment32;
@property (weak, nonatomic) IBOutlet UIImageView *segment33;
@property (weak, nonatomic) IBOutlet UIImageView *segment34;
@property (weak, nonatomic) IBOutlet UIImageView *segment35;
@property (weak, nonatomic) IBOutlet UIImageView *segment36;
@property (weak, nonatomic) IBOutlet UIImageView *segment37;

//segment for second minutes place
@property (weak, nonatomic) IBOutlet UIImageView *segment41;
@property (weak, nonatomic) IBOutlet UIImageView *segment42;
@property (weak, nonatomic) IBOutlet UIImageView *segment43;
@property (weak, nonatomic) IBOutlet UIImageView *segment44;
@property (weak, nonatomic) IBOutlet UIImageView *segment45;
@property (weak, nonatomic) IBOutlet UIImageView *segment46;
@property (weak, nonatomic) IBOutlet UIImageView *segment47;

//segments for first seconds place
@property (weak, nonatomic) IBOutlet UIImageView *segment51;
@property (weak, nonatomic) IBOutlet UIImageView *segment52;
@property (weak, nonatomic) IBOutlet UIImageView *segment53;
@property (weak, nonatomic) IBOutlet UIImageView *segment54;
@property (weak, nonatomic) IBOutlet UIImageView *segment55;
@property (weak, nonatomic) IBOutlet UIImageView *segment56;
@property (weak, nonatomic) IBOutlet UIImageView *segment57;

//segments for second seconds place
@property (weak, nonatomic) IBOutlet UIImageView *segment61;
@property (weak, nonatomic) IBOutlet UIImageView *segment62;
@property (weak, nonatomic) IBOutlet UIImageView *segment63;
@property (weak, nonatomic) IBOutlet UIImageView *segment64;
@property (weak, nonatomic) IBOutlet UIImageView *segment65;
@property (weak, nonatomic) IBOutlet UIImageView *segment66;
@property (weak, nonatomic) IBOutlet UIImageView *segment67;

//am/pm images
@property (weak, nonatomic) IBOutlet UIImageView *am;
@property (weak, nonatomic) IBOutlet UIImageView *pm;

//buttons
@property (weak, nonatomic) IBOutlet UISwitch *timeTypButton;

//methods
-(void)timerFired:(NSTimer *)theTimer;
-(void)hourSegments;
-(void)minSegments;
-(void)secSegments;

//misc properties
@property (nonatomic)int i;
@property (nonatomic,strong)NSDate *currentTime;
@property (nonatomic)NSInteger  mins;
@property (nonatomic)NSInteger secs;
@property (nonatomic)NSInteger hours;
@property (nonatomic,strong)NSDateFormatter *formatter;
@property (nonatomic,strong)NSArray *timeZoneArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerOutlet;
@property (nonatomic,strong)NSDateComponents *comps;
@property (nonatomic,strong)NSCalendar *gregorian;
@property (nonatomic)NSInteger pickerRow;
@property (nonatomic,strong) NSArray *myColorsArr;
@property (nonatomic) NSInteger digitsColorCounter;
@property (nonatomic) bool tempBool;
@property (nonatomic,strong) NSUserDefaults *defaultPrefs;
@property(nonatomic) NSInteger temp;

@end

