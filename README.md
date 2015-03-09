# README #

This is Spark Apps, LLC's easily importable WKWebview Singleton ViewController class. It handles all code needed for smooth handling and fast importability to any project. This is designed for any iPhone screen, iPad screens are untested.

### How do I get set up? ###

1. Import SparkWebview.h/SparkWebview.m into your project.

2. Use #import "SparkWebview.h" in any ViewController you want to use the SparkWebview in.

3. Inside SparkWebview.m, change the #define appName @"Spark" to #define appName @"YOURAPPNAME".

4. Set up the URL you want to load: [[SparkWebview sharedInstance] setUrlToLoad: @"http://www.sparkapps.com"];

5. Present the view controller: [self presentViewController: [SparkWebview sharedInstance] animated: YES completion:nil];

### Contribution guidelines ###

Developed by Jude Murphy Copyright Spark Apps, LLC

### Who do I talk to? ###

Contact jude.murphy@sparkapps.com if there are any known issues.