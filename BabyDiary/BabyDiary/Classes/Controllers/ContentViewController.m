//
//  ContentViewController.m
//  BabyDiary
//
//  Created by 楊 德忻 on 2014/7/24.
//  Copyright (c) 2014年 德忻 楊. All rights reserved.
//

#import "ContentViewController.h"
#import "SatManager.h"
#import "SatDevice.h"

@interface ContentViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textFied;

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onTouchLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    NSMutableString *content = [[NSMutableString alloc] init];
    SatManager *satManager = [SatManager sharedSatManager];
    NSMutableDictionary *uidToSatDevices = satManager.uidToSatDevices;
    for (NSString *uid in uidToSatDevices) {
        SatDevice *satDevice = [uidToSatDevices objectForKey:uid];

        NSString *line = [NSString stringWithFormat:@"%@:%@\n", uid, satDevice.macAddress];
        [content appendString: line];
    }
    self.textFied.text = content;
}

- (void)onTouchLeftButton {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
