//
//  MyWindow.h
//  del
//
//  Created by Rishabh Tayal on 10/7/13.
//  Copyright (c) 2013 Rishabh Tayal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyWindow : NSWindow

@property (strong) IBOutlet NSTextField *label;

- (IBAction)selectFileButtonClicked:(NSButtonCell *)sender;

@end
