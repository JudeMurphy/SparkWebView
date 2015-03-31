//
//  ViewController.m
//  spark-webview
//
//  Created by Murphy, Jude {BIS} on 3/7/15.
//  Copyright (c) 2015 Spark Apps, LLC. All rights reserved.
//

#import "SparkWebview.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    SparkWebview *webview = [[SparkWebview alloc] init];
    [webview setUrl: @"http://google.com"];
    [webview setAppName: @"Spark"];
    [webview setToolBarColorWithHexString: @"#FF4300"];
    [webview setBackgroundColorWithHexString: @"#FF4300"];
    
    [self presentViewController: webview animated: YES completion: nil];
}

@end
