//
//  SecondViewController.m
//  ActionSheetTest
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UITextFieldDelegate> {
    int answer;
    int maximunTrial;
    int trial;
}
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
- (IBAction)checkInput:(id)sender;
- (IBAction)newGame:(id)sender;
@end

@implementation SecondViewController {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    // 키보드가 시작하자마자 올라오도록
    [self.userInput becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self newGame:nil];
}

// 리턴키로 확인 - 숫자키패드라서 테스트용
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self checkInput:nil];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 게임 재시작 여부
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self newGame:nil];
    }
}
// 확인버튼 누르면 숫자 입력값 체크
- (IBAction)checkInput:(id)sender {
    int inputVal = [self.userInput.text intValue];
    self.userInput.text = @"";
    
    if (answer == inputVal) {
        self.label.text = @"정답입니다.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"정답" message:@"다시 게임 하겠습니까?" delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"ghkrdls", nil];
        alert.tag = 11;
        [alert show];
    }
    else {
        trial++;
        if (trial >= maximunTrial) {
            NSString *msg = [NSString stringWithFormat:@"답은 %d입니다.", answer];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"실패" message:msg delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인", nil];
            alert.tag = 12;
            [alert show];
        }
        else {
            if (answer > inputVal) {
                self.label.text = @"Down";
            }
            else {
                self.label.text = @"Up";
            }
            self.countLabel.text = [NSString stringWithFormat:@"%d / %d", trial, maximunTrial];
            self.progress.progress = trial / (float)maximunTrial;
        }
    }
}

// 새게임
- (IBAction)newGame:(id)sender {
    int selectedGame = (int)self.gameSelector.selectedSegmentIndex;
    int maximumRandom = 0;
    if (0 == selectedGame) {
        maximunTrial = 5;
        maximumRandom = 10;
    }
    else if (1 == selectedGame) {
        maximunTrial = 10;
        maximumRandom = 50;
    }
    else {
        maximunTrial = 20;
        maximumRandom = 100;
    }
    answer = random() % maximumRandom + 1;
    trial = 0;
    self.progress.progress = 0.0;
    self.countLabel.text = @"";
    self.label.text = @"";
    NSLog(@"New Game with answer : %d", answer);
}
@end
