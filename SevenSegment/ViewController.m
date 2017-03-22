//
//  ViewController.m
//  SevenSegment
//
//  Created by harry bloch on 2/3/16.
//  Copyright © 2016 harry bloch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSegments];
    self.segment11.image = [self.segment11.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    // Do any additional setup after loading the view, typically from a nib.
    self.formatter = [[NSDateFormatter alloc] init];
    self.timeZoneArray = @[@"Eastern",@"Central",@"Mountain",@"Pacific",@"Alaska"];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //right swipe
    UISwipeGestureRecognizer *swipeRightRecon = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightHandle:)];
    swipeRightRecon.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightRecon];
    //left swipe
    UISwipeGestureRecognizer *swipeLeftRecon = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandle:)];
    swipeLeftRecon.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftRecon];
    self.myColorsArr = @[[UIColor purpleColor],[UIColor redColor],[UIColor greenColor],[UIColor grayColor]];
//    set up default prefrences
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"myFile.plist"];
    User *user2 =[NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    self.pickerRow = user2.userTimeZone;
    self.defaultPrefs = [NSUserDefaults standardUserDefaults];
    self.temp = [self.defaultPrefs integerForKey:@"backroundColor"];
    self.view.backgroundColor = self.myColorsArr[self.temp];
    [self.pickerOutlet selectRow:self.pickerRow inComponent:0 animated:YES];
    [self.timeTypButton setOn: [self.defaultPrefs boolForKey:@"timeType"]];
    self.digitsColorCounter = [self.defaultPrefs integerForKey:@"digitColor"];
    [self.defaultPrefs synchronize];
    [self changeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timerFired:(NSTimer *)theTimer{
   self.i++;
    if (self.i%2==0) {
        [self.seperator setHidden:true];
    }else{
    [self.seperator setHidden:false];
    }
    self.gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.currentTime = [[NSDate alloc] init];
        if (self.pickerRow==0) {
            [self.comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
        }
        if (self.pickerRow==1) {
              [self.gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CST"]];
        }
        if (self.pickerRow==2) {
            [self.gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"MDT"]];
        }
        if (self.pickerRow==3) {
            [self.gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
        }
        if (self.pickerRow==4) {
            [self.gregorian setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"AKST"]];
        }
    self.comps =[self.gregorian components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self.currentTime];
    self.hours = [self.comps hour];
    self.mins = [self.comps minute];
    self.secs = [self.comps second];
    if (self.hours > 12) {
        [self.am setHidden:true];
        [self.pm setHidden:false];
    }else{
        [self.am setHidden:false];
        [self.pm setHidden:true];
    }
    
    if ([self.timeTypButton isOn]) {
        if (self.hours >12) {
            self.hours-=12;
            [self hourSegments];
        }else{
         [self hourSegments];
        }
    }
   [self hourSegments];
    [self secSegments];
    [self minSegments];
    if ([self.timeTypButton isOn]) {
        self.tempBool=true;
    }else{
        self.tempBool=false;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"myFile.plist"];
    User *user=[[User alloc]init];
    user.userTimeZone = self.pickerRow;
    [NSKeyedArchiver archiveRootObject:user toFile:filepath];
    [self.defaultPrefs setInteger:self.temp forKey:@"backroundColor"];
    [self.defaultPrefs setBool:self.tempBool forKey:@"timeType"];
    [self.defaultPrefs setInteger:self.digitsColorCounter forKey:@"digitColor"];
    [self.defaultPrefs synchronize];
}

-(void)changeColor{
    [self.segment11 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment12 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment13 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment14 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment15 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment16 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment17 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.segment21 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment22 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment23 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment24 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment25 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment26 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment27 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.segment31 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment32 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment33 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment34 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment35 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment36 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment37 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.segment41 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment42 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment43 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment44 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment45 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment46 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment47 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.segment51 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment52 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment53 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment54 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment55 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment56 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment57 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.segment61 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment62 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment63 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment64 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment65 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment66 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.segment67 setTintColor:self.myColorsArr[self.digitsColorCounter]];
    
    [self.am setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.pm setTintColor:self.myColorsArr[self.digitsColorCounter]];
    [self.seperator setTintColor:self.myColorsArr[self.digitsColorCounter]];
    }

-(void)swipeRightHandle: (UISwipeGestureRecognizer *) swipeReconizer {
    self.temp++;
    if (self.temp==self.myColorsArr.count-1) {
        self.temp=0;
    }
    self.view.backgroundColor = self.myColorsArr[self.temp];
}

-(void)swipeHandle: (UISwipeGestureRecognizer *) swipeReconizer {
    if (self.digitsColorCounter==self.myColorsArr.count-1) {
        self.digitsColorCounter =0;
    }
    self.digitsColorCounter ++;
    [self changeColor];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.timeZoneArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerViews {
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.timeZoneArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //@"Eastern",@"Central",@"Mountain",@"Pacific",@"Alaska"
   self.pickerRow =row;
}

-(void)secSegments{
    //set up digits for the seconds place
    int temp1 = self.secs%10;
    switch (temp1) {
        case 0:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:false];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:true];
            break;
        
        case 1:
            [self.segment61 setHidden:true];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:true];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:true];
            [self.segment67 setHidden:true];
            break;
        case 2:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:true];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:false];
            [self.segment66 setHidden:true];
            [self.segment67 setHidden:false];
            break;
        case 3:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:true];
            [self.segment67 setHidden:false];
            break;
        case 4:
            [self.segment61 setHidden:true];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:true];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:false];
            break;
        case 5:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:true];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:false];
            break;
        case 6:
            [self.segment61 setHidden:true];
            [self.segment62 setHidden:true];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:false];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:false];
            break;
        case 7:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:true];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:true];
            [self.segment67 setHidden:true];
            break;
        case 8:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:false];
            [self.segment65 setHidden:false];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:false];
            break;
        case 9:
            [self.segment61 setHidden:false];
            [self.segment62 setHidden:false];
            [self.segment63 setHidden:false];
            [self.segment64 setHidden:true];
            [self.segment65 setHidden:true];
            [self.segment66 setHidden:false];
            [self.segment67 setHidden:false];
            break;
        default:
            break;
    }
    switch (self.secs/10) {
        case 0:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:false];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:true];
            break;
        case 1:
            [self.segment51 setHidden:true];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:true];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:true];
            [self.segment57 setHidden:true];
            break;
        case 2:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:true];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:false];
            [self.segment56 setHidden:true];
            [self.segment57 setHidden:false];
            break;
        case 3:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:true];
            [self.segment57 setHidden:false];
        case 4:
            [self.segment51 setHidden:true];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:true];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:false];
            break;
        case 5:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:true];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:false];
            break;
        case 6:
            [self.segment51 setHidden:true];
            [self.segment52 setHidden:true];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:false];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:false];
            break;
        case 7:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:true];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:true];
            [self.segment57 setHidden:true];
            break;
        case 8:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:false];
            [self.segment55 setHidden:false];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:false];
            break;
        case 9:
            [self.segment51 setHidden:false];
            [self.segment52 setHidden:false];
            [self.segment53 setHidden:false];
            [self.segment54 setHidden:true];
            [self.segment55 setHidden:true];
            [self.segment56 setHidden:false];
            [self.segment57 setHidden:false];
            break;
        default:
            break;
    }
}

-(void)minSegments{
    if (self.mins %10==0) {
        //set up segments for the first minutes place digit
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:false];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:true];
    }
    if (self.mins%10==1) {
        [self.segment41 setHidden:true];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:true];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:true];
        [self.segment47 setHidden:true];
    }
    if (self.mins%10==2) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:true];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:false];
        [self.segment46 setHidden:true];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==3) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:true];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==4) {
        [self.segment41 setHidden:true];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:true];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==5) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:true];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==6) {
        [self.segment41 setHidden:true];
        [self.segment42 setHidden:true];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:false];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==7) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:true];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:true];
        [self.segment47 setHidden:true];
    }
    if (self.mins%10==8) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:false];
        [self.segment45 setHidden:false];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:false];
    }
    if (self.mins%10==9) {
        [self.segment41 setHidden:false];
        [self.segment42 setHidden:false];
        [self.segment43 setHidden:false];
        [self.segment44 setHidden:true];
        [self.segment45 setHidden:true];
        [self.segment46 setHidden:false];
        [self.segment47 setHidden:false];
    }
    //mins digit for the tens place
    if (self.mins < 10) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:false];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:true];
    }
    if (self.mins >= 10 && self.mins < 20) {
        [self.segment31 setHidden:true];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:true];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:true];
        [self.segment37 setHidden:true];
    }
    if (self.mins >= 20 && self.mins < 30) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:true];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:false];
        [self.segment36 setHidden:true];
        [self.segment37 setHidden:false];
    }
    if (self.mins >= 30 && self.mins < 40) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:true];
        [self.segment37 setHidden:false];
    }
    if (self.mins >= 40 && self.mins < 50) {
        [self.segment31 setHidden:true];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:true];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:false];
    }
    if (self.mins >=50 && self.mins < 60) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:true];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:false];
    }
    if (self.mins >=60 && self.mins < 70) {
        [self.segment31 setHidden:true];
        [self.segment32 setHidden:true];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:false];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:false];
    }
    if (self.mins >= 70 && self.mins < 80) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:true];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:true];
        [self.segment37 setHidden:true];
    }
    if (self.mins >= 80  && self.mins < 90) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:false];
        [self.segment35 setHidden:false];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:false];
    }
    if (self.mins >= 90) {
        [self.segment31 setHidden:false];
        [self.segment32 setHidden:false];
        [self.segment33 setHidden:false];
        [self.segment34 setHidden:true];
        [self.segment35 setHidden:true];
        [self.segment36 setHidden:false];
        [self.segment37 setHidden:false];
    }
}

-(void)hourSegments{
    if (self.hours %10 == 0) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:false];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:true];
    }
    if (self.hours %10 == 1) {
        [self.segment21 setHidden:true];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:true];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:true];
        [self.segment27 setHidden:true];
    }
    if (self.hours %10 == 2) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:true];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:false];
        [self.segment26 setHidden:true];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 3) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:true];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 4) {
        [self.segment21 setHidden:true];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:true];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 5) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:true];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 6) {
        [self.segment21 setHidden:true];
        [self.segment22 setHidden:true];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:false];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 7) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:true];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:true];
        [self.segment27 setHidden:true];
    }
    if (self.hours %10 == 8) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:false];
        [self.segment25 setHidden:false];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:false];
    }
    if (self.hours %10 == 9) {
        [self.segment21 setHidden:false];
        [self.segment22 setHidden:false];
        [self.segment23 setHidden:false];
        [self.segment24 setHidden:true];
        [self.segment25 setHidden:true];
        [self.segment26 setHidden:false];
        [self.segment27 setHidden:false];
    }
//    hours digit for the tens place
    if (self.hours  < 10) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:false];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:true];
    }
    if (self.hours  >= 10 && self.hours  < 20) {
        [self.segment11 setHidden:true];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:true];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:true];
        [self.segment17 setHidden:true];
    }
    if (self.hours  >= 20 && self.hours  < 30) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:true];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:false];
        [self.segment16 setHidden:true];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >= 30 && self.hours  < 40) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:true];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >= 40 && self.hours  < 50) {
        [self.segment11 setHidden:true];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:true];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >=50 && self.hours  < 60) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:true];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >=60 && self.hours  < 70) {
        [self.segment11 setHidden:true];
        [self.segment12 setHidden:true];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:false];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >= 70 && self.hours  < 80) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:true];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:true];
        [self.segment17 setHidden:true];
    }
    if (self.hours  >=80  && self.hours  < 90) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:false];
        [self.segment15 setHidden:false];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:false];
    }
    if (self.hours  >=90) {
        [self.segment11 setHidden:false];
        [self.segment12 setHidden:false];
        [self.segment13 setHidden:false];
        [self.segment14 setHidden:true];
        [self.segment15 setHidden:true];
        [self.segment16 setHidden:false];
        [self.segment17 setHidden:false];
    }
}

-(void)setupSegments{
    self.segment11.image = [self.segment11.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment12.image = [self.segment12.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment13.image = [self.segment13.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment14.image = [self.segment14.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment15.image = [self.segment15.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment16.image = [self.segment16.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment17.image = [self.segment17.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.segment21.image = [self.segment21.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment22.image = [self.segment22.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment23.image = [self.segment23.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment24.image = [self.segment24.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment25.image = [self.segment25.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment26.image = [self.segment26.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment27.image = [self.segment27.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.segment31.image = [self.segment31.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment32.image = [self.segment32.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment33.image = [self.segment33.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment34.image = [self.segment34.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment35.image = [self.segment35.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment36.image = [self.segment36.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment37.image = [self.segment37.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.segment41.image = [self.segment41.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment42.image = [self.segment42.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment43.image = [self.segment43.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment44.image = [self.segment44.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment45.image = [self.segment45.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment46.image = [self.segment46.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment47.image = [self.segment47.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.segment51.image = [self.segment51.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment52.image = [self.segment52.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment53.image = [self.segment53.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment54.image = [self.segment54.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment55.image = [self.segment55.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment56.image = [self.segment56.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment57.image = [self.segment57.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.segment61.image = [self.segment61.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment62.image = [self.segment62.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment63.image = [self.segment63.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment64.image = [self.segment64.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment65.image = [self.segment65.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment66.image = [self.segment66.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.segment67.image = [self.segment67.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.seperator.image = [self.seperator.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.am.image = [self.am.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.pm.image = [self.pm.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}
@end











































