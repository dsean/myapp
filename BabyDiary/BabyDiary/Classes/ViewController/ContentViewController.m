//
//  ContentViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textFied;
@property (strong, nonatomic) SatManager *satManager;
@end

@implementation ContentViewController

- (SatManager *)satManager {
    if (!_satManager) {
        _satManager = [[SatManager alloc] init];
    }
    return _satManager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    NSMutableString *str = [[NSMutableString alloc] init];
    NSMutableDictionary *content = self.satManager.userDeviceEntries;
    for (NSMutableDictionary *key in content) {
        [str appendFormat: [NSString stringWithFormat:@"%@:%@\n", key, [content objectForKey:key]]];
    }
    self.textFied.text = str;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(OnLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}
- (void)OnLeftButton {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
