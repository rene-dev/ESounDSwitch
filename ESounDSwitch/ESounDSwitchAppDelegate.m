//
//  ESounDSwitchAppDelegate.m
//  ESounDSwitch
//
//  Created by Philip Brechler on 15.03.11.
//  Copyright 2011 TimeCoast Communications. All rights reserved.
//

#import "ESounDSwitchAppDelegate.h"

@implementation ESounDSwitchAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    running = NO;
    defaults = [NSUserDefaults standardUserDefaults];
    host.stringValue = [defaults objectForKey:@"host"];
}

-(void)awakeFromNib{
    
    //Create the NSStatusBar and set its length
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    
    //Used to detect where our files are
    NSBundle *bundle = [NSBundle mainBundle];
    
    //Allocates and loads the images into the application which will be used for our NSStatusItem
    iconOff = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon-off" ofType:@"png"]];
    iconOn  = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon-on" ofType:@"png"]];
    
    //Sets the images in our NSStatusItem
    [statusItem setImage:iconOff];
    
    //Tells the NSStatusItem what menu to load
    [statusItem setMenu:statusMenu];
    //Sets the tooptip for our item
    [statusItem setToolTip:@"ESounD Switch"];
    //Enables highlighting
    [statusItem setHighlightMode:YES];
}

-(IBAction)toggleESD:(id)sender{
    if (!running) {
        [self runSystemCommand:@"/opt/local/bin/esd -tcp -bind ::1"];
        sleep(1);
        [self runSystemCommand:[NSString stringWithFormat:@"/opt/local/bin/esdrec -s ::1 | /opt/local/bin/esdcat -s %@",host.stringValue]];
        [[statusMenu itemAtIndex:0] setTitle:@"Running"];
        [[statusMenu itemAtIndex:1] setTitle:@"Stop"];
        [statusItem setImage:iconOn];
        running = YES;
    } else {
        [self runSystemCommand:@"killall esd"];
        [[statusMenu itemAtIndex:0] setTitle:@"Stopped"];
        [[statusMenu itemAtIndex:1] setTitle:@"Start"];
        [statusItem setImage:iconOff];
        running = NO;
    }   
}

- (IBAction)showSettings:(id)sender {
    [[NSApplication sharedApplication] activateIgnoringOtherApps:TRUE];
    [settingsPanel makeKeyAndOrderFront:self];
}

- (void)windowWillClose:(NSNotification *)aNotification{
    [defaults setObject:host.stringValue forKey:@"host"];
    [defaults synchronize];
}

- (void) runSystemCommand:(NSString *)cmd{
    [NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c", cmd, nil]];
}

@end
