# README #

This is Spark Apps, LLC's easily importable WKWebview Singleton ViewController class. It handles all code needed for smooth handling and fast importability to any project. This is designed for any iPhone screen, iPad screens are untested.

### How do I get set up? ###

Import SparkWebview.h/SparkWebview.m into your project.

#import "SparkWebview.h" in your selected ViewController.

Use the following code to present SparkWebview:
SparkWebview *webview = [[SparkWebview alloc] init];
[webview setUrl: @"http://google.com"];
[webview setAppName: @"Spark"];
[webview setToolBarColorWithHexString: @"#FF4300"];
[webview setBackgroundColorWithHexString: @"#FF4300"];
[self presentViewController: webview animated: YES completion: nil];

Change whatever you would like for further customizablity.

### Contribution guidelines ###

Developed by Jude Murphy Copyright Spark Apps, LLC

### Who do I talk to? ###

Contact jude.murphy@sparkapps.com if there are any known issues.
