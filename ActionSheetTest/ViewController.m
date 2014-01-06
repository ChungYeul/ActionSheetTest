//
//  ViewController.m
//  ActionSheetTest
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController {
    UIActionSheet *sheet2;
    int count;
}
// 액션시트에서 선택한 결과, 인덱스 출력
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected index : %d", (int)buttonIndex);
}

// ActionSheet가 나타나기 전에
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
    if (2 == actionSheet.tag) {
        // count를 이용해서 제목을 변경해 준다.
        NSString *title = [NSString stringWithFormat:@"%d 번째", count++];
        actionSheet.title = title;
    }
}

// 기본 액션 시트
- (IBAction)showBasicActionSheet:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"제목" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:@"중요" otherButtonTitles:@"확인1", @"확인2", nil];
    sheet.tag = 1;
    [sheet showInView:self.view];
}

// ActionSheet를 1개 생성, 나타나면서 제목을 변경해준다.
- (IBAction)showActionSheetWithCount:(id)sender {
    if (nil == sheet2) {
        sheet2 = [[UIActionSheet alloc] initWithTitle:@"제목" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"선택1", @"선택2", nil];
        sheet2.tag = 2;
    }
    [sheet2 showInView:self.view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
