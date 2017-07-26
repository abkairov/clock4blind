//
//  ViewController.m
//  Clock4Blind
//
//  Created by Nikolay Abkairov on 7/26/17.
//  Copyright © 2017 Nikolay Abkairov. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
{
    NSDate * buttonPressedTime;
    NSDate * fullTimeAnnounced;
}

- (NSString*)dateString
{
    NSString * date =  [NSDateFormatter localizedStringFromDate:[NSDate date]
                                          dateStyle:NSDateFormatterFullStyle
                                          timeStyle:NSDateFormatterNoStyle];
    NSString * time =  [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                      dateStyle:NSDateFormatterNoStyle
                                                      timeStyle:NSDateFormatterShortStyle];
    return [NSString stringWithFormat:@"%@\n%@",date, time];
}

- (NSString*)timeString
{
    NSString * time =  [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                      dateStyle:NSDateFormatterNoStyle
                                                      timeStyle:NSDateFormatterShortStyle];
    return [NSString stringWithFormat:@"%@",time];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.bigButton setTitle:[self dateString] forState:UIControlStateNormal];
    
    [self speakTime];
    
    [NSTimer scheduledTimerWithTimeInterval:10.f target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
}


- (void)updateTime:(NSTimer *)t
{
    [self.bigButton setTitle:[self dateString] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)speakTime
{
    NSDate * now = [NSDate date];
    NSString * str;
    
    if(!fullTimeAnnounced || [now timeIntervalSinceDate:fullTimeAnnounced] > 60.f) {
        str = [self dateString];
        fullTimeAnnounced = now;
    } else {
        str = [self timeString];
    }
    
    NSLog(@"%@",str);
    [self.bigButton setTitle:str forState:UIControlStateNormal];
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
    [utterance setRate:0.2f];
    [synthesizer speakUtterance:utterance];
}

- (IBAction)handleBigButtonClick:(id)sender {
    
    NSDate * now = [NSDate date];
    
    if(!buttonPressedTime || [now timeIntervalSinceDate:buttonPressedTime] > 4.f) {
        buttonPressedTime = now;
        
        [self speakTime];
    }
}

@end
