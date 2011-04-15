//
//  ESounDSwitchAppDelegate.h
//  ESounDSwitch
//
//  Created by Philip Brechler on 15.03.11.
//  Copyright 2011 TimeCoast Communications. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ESounDSwitchAppDelegate : NSObject <NSApplicationDelegate,NSWindowDelegate> {
@private
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSPanel *settingsPanel;
    IBOutlet NSTextField *host;
    NSStatusItem * statusItem;
    NSImage *iconOff;
    NSImage *iconOn;
    NSUserDefaults* defaults;
    bool running;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) toggleESD:(id)sender;
- (IBAction) showSettings:(id)sender;
- (void) runSystemCommand:(NSString *)cmd;

@end
