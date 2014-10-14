//
//  AppDelegate.m
//  MacHandOff
//
//  Created by 石田 勝嗣 on 2014/09/22.
//  Copyright (c) 2014年 石田 勝嗣. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *checkButton;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSUserActivity* myActivity = [[NSUserActivity alloc]
                                  initWithActivityType:@"jp.neoscorp.handoff.browsing"];
    myActivity.userInfo = @{ @"text" : self.textField.stringValue,
                             @"on" : [NSNumber numberWithInteger : self.checkButton.state]};
    myActivity.title = @"Browsing";
    [myActivity becomeCurrent];
    [myActivity setDelegate:self];
    [myActivity setNeedsSave:YES];
    
    [self.window setUserActivity:myActivity];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    
    
}

- (void)userActivityWillSave:(NSUserActivity *)userActivity {
    NSLog(@"ViewController:userActivityWillSave");
    NSDictionary *dictionary = @{ @"text" : self.textField.stringValue,
                                  @"on" : [NSNumber numberWithInteger : self.checkButton.state]};
    [userActivity addUserInfoEntriesFromDictionary:dictionary];
}

- (void)restoreUserActivityState:(NSUserActivity *)userActivity {
    NSLog(@"ViewController:restoreUserActivityState");
    NSDictionary *dictionary = userActivity.userInfo;
    NSLog(@"text = %@", [dictionary objectForKey:@"text"]);
    NSLog(@"on = %@", [dictionary objectForKey:@"on"]);
}
@end
