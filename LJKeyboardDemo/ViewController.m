//
//  ViewController.m
//  LJKeyboardDemo
//
//  Created by fox on 15/10/21.
//  Copyright (c) 2015年 ljcoder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *BottomConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"keyboardDemo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - 键盘通知
- (void)keyboardWillShow:(NSNotification *)noti {
    
    NSInteger Duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];//获取键盘显示动画持续时间
    UIViewAnimationOptions option = ([[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16);//获取键盘显示动画曲线
    CGFloat bottom = [[noti.userInfo objectForKey: UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.BottomConstraint.constant = bottom;//frame的改变方法，根据具体情况来写
    [UIView animateWithDuration:Duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    
    NSInteger Duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];//获取键盘隐藏动画持续时间
    UIViewAnimationOptions option = ([[noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16);//获取键盘隐藏动画曲线
    self.BottomConstraint.constant = 0;//frame的改变方法，根据具体情况来写
    
    [UIView animateWithDuration:Duration  delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {}];
}

- (IBAction)hideKeyboard:(id)sender {
    
    if ([self.textField isFirstResponder]) {
        [self.button setTitle:@"出键盘" forState:UIControlStateNormal];
        [self.textField resignFirstResponder];
    }
    else
    {
        [self.button setTitle:@"收键盘" forState:UIControlStateNormal];
        [self.textField becomeFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
