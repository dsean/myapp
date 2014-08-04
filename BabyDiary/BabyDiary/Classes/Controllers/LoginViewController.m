//
//  LoginViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "LoginViewController.h"

#import "ContentViewController.h"
#import "LoginHandler.h"
#import "SatManager.h"
#import "UserPreferences.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassworkButton;
@property (weak, nonatomic) IBOutlet UIButton *cerateAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *googleLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *loginManageLabel;

@end

@implementation LoginViewController

#pragma mark-lifCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // Reset UI
    self.loginButton.enabled = YES;
    self.loginManageLabel.text = @"";
}

#pragma mark-initUI

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

- (IBAction)nameTextField_DidEndOnExit:(id)sender {
    // Foucus on next field
    [self.passwordField becomeFirstResponder];
}

- (IBAction)passTextField_DidEndOnExit:(id)sender {
    // Hide keyboard
    [sender resignFirstResponder];

    // Trigger login after enter return key
    [self.loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)initUI {
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_password"]];
    self.passwordField.leftView = image;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;

    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_uername"]];
    self.usernameField.leftView = image2;
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
}

#pragma mark-OriginalAction

- (IBAction)onTouchLoginButton:(UIButton *)sender {
    self.loginButton.enabled = NO;
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];

    self.loginManageLabel.textColor = [UIColor blackColor];
    self.loginManageLabel.text = @"Log in...";

    NSString *satUsername = self.usernameField.text;
    NSString *satPassword = self.passwordField.text;

    // Login
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL success = [LoginHandler satLogin:satUsername :satPassword];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self loginSuccess];
            }
            else {
                [self loginFaild];
            }
        });
    });
}

- (void)loginFaild {
    self.loginButton.enabled = YES;
    self.loginManageLabel.textColor = [UIColor redColor];
    self.loginManageLabel.text = @"username or password faild";
}

- (void)loginSuccess {
    NSString *satUsername = self.usernameField.text;
    NSString *satPassword = self.passwordField.text;
    [LoginHandler userLoginSuccess:satUsername:satPassword];
    
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}
@end
