//
//  LoginViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/10.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UILabel *line1;
@property (weak, nonatomic) IBOutlet UILabel *line2;
@property (weak, nonatomic) IBOutlet UILabel *line3;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassworkButton;
@property (weak, nonatomic) IBOutlet UIButton *cerateAccount;
@property (weak, nonatomic) IBOutlet UILabel *othersigninLabel;
@property (weak, nonatomic) IBOutlet UIButton *googleLoginButton;
@property (weak, nonatomic) IBOutlet UIImageView *tagLoginView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

#pragma mark-lifCycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self initUI];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.passwordField resignFirstResponder];
    [self.usernameField resignFirstResponder];
}

#pragma mark-initUI

-(void)initUI {
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"btn_g_pressed"] forState:UIControlStateHighlighted];
    
    
    [self.forgetPassworkButton setTintColor:[self colorWithHexString:@"#94BDCF"]];
    [self.cerateAccount setTintColor:[self colorWithHexString:@"#94BDCF"]];
    
    [self.othersigninLabel setTextColor:[self colorWithHexString:@"#A6C7CF"]];

    
    [self.view setBackgroundColor:[self colorWithHexString:@"#dfe8e9"]];
    [self.passwordField setTextColor:[self colorWithHexString:@"#69a3b8"]];
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_password"]];
    self.passwordField.leftView=image;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;

    [self.usernameField setTextColor:[self colorWithHexString:@"#69a3b8"]];
    UIImageView *image2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_login_uername"]];
    self.usernameField.leftView=image2;
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.line1 setBackgroundColor:[self colorWithHexString:@"#C2D6DB"]];
    [self.line2 setBackgroundColor:[self colorWithHexString:@"#C2D6DB"]];
    [self.line3 setBackgroundColor:[self colorWithHexString:@"#C2D6DB"]];
    
    //[self.googleLoginButton setBackgroundImage:[UIImage imageNamed:@"btn_googleLogin_pressed"] forState:UIControlStateHighlighted];
    
    // [self.tagLoginView setImage:[UIImage imageNamed:@"tag_login"]];
}

- (UIColor *) colorWithHexString: (NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
