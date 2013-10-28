//
//  MyWindow.m
//  del
//
//  Created by Rishabh Tayal on 10/7/13.
//  Copyright (c) 2013 Rishabh Tayal. All rights reserved.
//

#import "MyWindow.h"
#import "Encrypter.h"

@implementation MyWindow

- (IBAction)selectFileButtonClicked:(NSButtonCell *)sender
{
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    a
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        NSData* rawData = [NSData dataWithContentsOfFile:[[panel URLs] objectAtIndex:0]];
        NSData* encryptedData = [Encrypter encryptData:rawData key:ENCRYPTIONKEY initVec:ENCRYPTIONIV];
        NSString* fileName =  (NSString*) [[[[[panel URLs] objectAtIndex:0]absoluteString] lastPathComponent] stringByDeletingPathExtension];
        NSString* filePath = (NSString*) [[[panel URLs] objectAtIndex:0] absoluteString];
        NSString* destinationPath = [filePath stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-encrypted", fileName]];
        [encryptedData writeToURL:[NSURL URLWithString:destinationPath] options:NSDataWritingAtomic error:nil];
        _label.stringValue = @"File encrypted successfully. If you encounter any issues please contact the developer.";
    }
}

@end
