# README #

This is Spark Apps, LLC's easily importable WKWebview ViewController class. It handles all code needed for smooth handling and fast importability to any project. This is designed for any device, iPhone or iPad.

### How do I get set up? ###

Import SparkWebview.h/SparkWebview.m files into your project.
<br />Import "SparkWebview.h" in your selected ViewController.

Use the following code to present SparkWebview:
<br />SparkWebview *webview = [[SparkWebview alloc] init];
<br />[webview setUrl: @"http://sparkapps.com"];
<br />[webview setAppName: @"Spark"];
<br />[webview setToolBarColorWithHexString: @"#FF4300"];
<br />[webview setBackgroundColorWithHexString: @"#FF4300"];
<br />[self presentViewController: webview animated: YES completion: nil];
<br />Be sure to set NSArbitraryLoads to YES in your project!
<br />Change whatever you would like for further customizablity.

### Contribution guidelines ###

Developed by Jude Murphy Copyright Spark Apps, LLC

### Who do I talk to? ###

Contact jude.murphy@sparkapps.com if there are any known issues.

