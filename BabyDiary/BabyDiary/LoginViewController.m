//
//  LoginViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/10.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "LoginViewController.h"
#import "SatLogin.h"
@interface LoginViewController ()

@property(strong, nonatomic) SatLogin *satLogin;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;



@property (weak, nonatomic) IBOutlet UIButton *forgetPassworkButton;
@property (weak, nonatomic) IBOutlet UIButton *cerateAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *googleLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *loginManage;

@end

@implementation LoginViewController

- (SatLogin *)satLogin {
    if (!_satLogin) {
        _satLogin = [[SatLogin alloc] init];
    }
    return _satLogin;
}

#pragma mark-lifCycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self initUI];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    
}


#pragma mark-initUI

- (IBAction)nameTextField_DidEndOnExit:(id)sender {
    // foucus on next feild
    [self.passwordField becomeFirstResponder];
}

- (IBAction)passTextField_DidEndOnExit:(id)sender {
    // hide
    [sender resignFirstResponder];
    // to login
    [self.loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}


-(void)initUI {
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_password"]];
    self.passwordField.leftView=image;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.autocorrectionType = UITextAutocorrectionTypeNo;

    UIImageView *image2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_uername"]];
    self.usernameField.leftView=image2;
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
}

#pragma mark-OriginalAction
- (IBAction)satLoginButton:(UIButton *)sender {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    
    self.loginManage.text = @"Log in...";
    [self.satLogin prepard];
    [self.satLogin satLogin];   
    
}

@end
