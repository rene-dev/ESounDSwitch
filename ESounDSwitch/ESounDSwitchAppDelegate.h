//
//  ESounDSwitchAppDelegate.h
//  ESounDSwitch
//
//  Created by Philip Brechler on 15.03.11.
//  Copyright 2011 TimeCoast Communications. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ESounDSwitchAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    NSImage *menuIcon;
    NSImage *menuAlternateIcon;
    BOOL running;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)switchESD:(id)sender;

void runSystemCommand(NSString *cmd);

@end
