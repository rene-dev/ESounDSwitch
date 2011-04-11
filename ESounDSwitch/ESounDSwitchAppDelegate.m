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
}

-(void)awakeFromNib{
    
    //Create the NSStatusBar and set its length
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    
    //Used to detect where our files are
    NSBundle *bundle = [NSBundle mainBundle];
    
    //Allocates and loads the images into the application which will be used for our NSStatusItem
    menuIcon = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon-off" ofType:@"png"]];
    menuAlternateIcon = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon-on" ofType:@"png"]];
    
    //Sets the images in our NSStatusItem
    [statusItem setImage:menuIcon];
    
    //Tells the NSStatusItem what menu to load
    [statusItem setMenu:statusMenu];
    //Sets the tooptip for our item
    [statusItem setToolTip:@"ESounD Switch"];
    //Enables highlighting
    [statusItem setHighlightMode:YES];
}

-(IBAction)switchESD:(id)sender{
    if (!running) {
        runSystemCommand(@"/opt/local/bin/esd -tcp -bind ::1");
        sleep(1);
        runSystemCommand(@"/opt/local/bin/esdrec -s ::1 | /opt/local/bin/esdcat -s etherplay");
        [[statusMenu itemAtIndex:0] setTitle:@"Running"];
        [[statusMenu itemAtIndex:1] setTitle:@"Stop"];
        [statusItem setImage:menuAlternateIcon];
        running = YES;
    } else {
        runSystemCommand(@"killall esd");
        [[statusMenu itemAtIndex:0] setTitle:@"Stopped"];
        [[statusMenu itemAtIndex:1] setTitle:@"Start"];
        [statusItem setImage:menuIcon];
        running = NO;
    }
   
}

void runSystemCommand(NSString *cmd)
{
    [NSTask launchedTaskWithLaunchPath:@"/bin/sh"
                              arguments:[NSArray arrayWithObjects:@"-c", cmd, nil]];
}

@end
