//
//  LoginViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "LoginViewController.h"

#import "SatLoginHandler.h"
#import "ContentViewController.h"
#import "SatManager.h"
@interface LoginViewController ()

@property(strong, nonatomic) SatLoginHandler *satLogin;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassworkButton;
@property (weak, nonatomic) IBOutlet UIButton *cerateAccountButton;
@property (weak, nonatomic) IBOutlet UIButton *googleLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *loginManageLabel;

@end

@implementation LoginViewController

- (SatLoginHandler *)satLogin {
    if (!_satLogin) {
        _satLogin = [[SatLoginHandler alloc] init];
    }
    return _satLogin;
}

#pragma mark-lifCycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self initUI];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.loginButton.enabled =YES;
    self.loginManageLabel.text = @"";
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    
}


#pragma mark-initUI

-(BOOL)shouldAutorotate {
    return NO;
}

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
    self.loginButton.enabled =NO;
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    
    NSString *satUsername = self.usernameField.text;
    NSString *satPassword = self.passwordField.text;
    
    self.loginManageLabel.textColor = [UIColor blackColor];
    self.loginManageLabel.text = @"Log in...";
    if ([self.satLogin checkLoginContent:satUsername :satPassword]) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.satLogin satLogin:satUsername :satPassword];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.satLogin.satLoginCheck) {
                    [self loginSuccess];
                }
                else {
                    [self loginFaild];
                }
            });
        });
    }
    else {
        [self loginFaild];
    }
}

- (void)loginFaild {
    self.loginButton.enabled =YES;
    self.loginManageLabel.textColor = [UIColor redColor];
    self.loginManageLabel.text = @"username or password faild";
}

- (void)loginSuccess {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];

}
@end

