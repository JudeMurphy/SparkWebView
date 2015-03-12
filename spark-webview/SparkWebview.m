// SparkWebview.m
//
// Developed by Jude Murphy
// Copyright (c) 2015 Spark Apps, LLC http://www.sparkapps.com/
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SparkWebview.h"

#define screenWidth self.view.frame.size.width
#define screenHeight self.view.frame.size.height
#define appName @"Spark"

@implementation SparkWebview

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

+ (id)sharedInstance
{
    static SparkWebview *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void) viewDidLoad
{
    [self setNeedsStatusBarAppearanceUpdate];
    [[self view] setBackgroundColor: [self colorWithHexString: @"FF4300"]];

    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    [[self activityIndicator] setCenter: CGPointMake(screenWidth/2, screenHeight/2)];
    [[self view] addSubview: [self activityIndicator]];
    
    _toolbar = [[UIToolbar alloc]initWithFrame: CGRectMake(0, 0, screenWidth, 0)];
    [[self toolbar] setCenter: CGPointMake(screenWidth/2, screenHeight-44)];
    [[self toolbar] setBarStyle: UIBarStyleDefault];
    [[self toolbar] sizeToFit];
    [[self toolbar] setBarTintColor: [self colorWithHexString: @"FF4300"]];
    [self.view addSubview: [self toolbar]];
    
    _spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: self action:nil];
    _backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem : UIBarButtonSystemItemRewind target: self action: @selector(backButtonPressed)];
    _shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction target:self action:@selector(sharedButtonPressed)];
    _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh target: self action: @selector(refreshButtonPressed)];
    _dismissViewControllerButton = [[UIBarButtonItem alloc] initWithTitle: @"Back" style: UIBarButtonItemStylePlain target:self action:@selector(dismissViewControllerButtonPressed)];

    [[self backButton] setTintColor: [UIColor whiteColor]];
    [[self shareButton] setTintColor: [UIColor whiteColor]];
    [[self refreshButton] setTintColor: [UIColor whiteColor]];
    [[self dismissViewControllerButton] setTintColor: [UIColor whiteColor]];
    
    _itemsArray = [NSArray arrayWithObjects: [self dismissViewControllerButton], [self spacer], [self shareButton], [self spacer], [self backButton], [self spacer], [self refreshButton], nil];
    
    [[self toolbar] setItems: [self itemsArray]];
    
    _webView = [[WKWebView alloc] initWithFrame: CGRectMake(0, 20, screenWidth, screenHeight - 64)];
    [[self webView] setCenter: CGPointMake(screenWidth/2, screenHeight/2 - 10)];
    [[self webView] setNavigationDelegate: self];
    
    _url = [NSURL URLWithString: [self urlToLoad]];
    _nsrequest = [NSURLRequest requestWithURL: [self url]];
    [[self webView] loadRequest: [self nsrequest]];
    [[self webView] setAlpha: 0.0];
    [[self view] addSubview: [self webView]];

}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation: (WKNavigation *)navigation
{
    if ([[self webView] alpha] == 1.0)
    {
        [UIView beginAnimations:nil context: NULL];
        [UIView setAnimationDuration: .30];
        [[self webView] setAlpha: 0.0];
        [UIView commitAnimations];
    }
    
    [[self activityIndicator] startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation: (WKNavigation *)navigation
{
    [UIView beginAnimations:nil context: NULL];
    [UIView setAnimationDuration: .30];
    [[self webView] setAlpha: 1.0];
    [UIView commitAnimations];
    
    [[self activityIndicator] setHidden: YES];
    [[self activityIndicator] stopAnimating];
}

-(void)webView:(WKWebView *)webView didFailNavigation: (WKNavigation *)navigation withError:(NSError *)error
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void) refreshButtonPressed
{
    [[self webView] reload];
}

-(void) backButtonPressed
{
    [[self webView] goBack];
}

-(void) sharedButtonPressed
{
    _shareController = [[UIActivityViewController alloc] initWithActivityItems: @[[NSString stringWithFormat: @"Check out this page: %@ shared via %@.", [[self webView] URL], appName]] applicationActivities: nil];
    [self presentViewController: [self shareController] animated: YES completion: nil];
}

-(void) dismissViewControllerButtonPressed
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(void) setUrlToLoad: (NSString *) urlToLoad
{
    _urlToLoad = urlToLoad;
}

//SPARKWEBVIE CLASS HELPER METHODS
//Programmatically Designs UIColor Based On Hex String
- (UIColor *)colorWithHexString:(NSString *)colorString
{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    
    return nil;
}

- (NSString *) getYourAppsName
{
    return [[NSBundle bundleWithIdentifier:@"BundleIdentifier"] objectForInfoDictionaryKey:@"CFBundleExecutable"];
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
