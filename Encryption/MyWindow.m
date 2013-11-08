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
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        _label.stringValue = @"Error encrypting the file. Please contact your developer.";
       NSString* rawDataString = [NSString stringWithContentsOfURL:[[panel URLs] objectAtIndex:0] encoding:NSUTF8StringEncoding error:nil] ;
        NSData* rawData = [rawDataString dataUsingEncoding:NSUTF8StringEncoding];
        NSData* encryptedData = [Encrypter encryptData:rawData key:ENCRYPTIONKEY initVec:ENCRYPTIONIV];
        NSString* fileName =  (NSString*) [[[[[panel URLs] objectAtIndex:0]absoluteString] lastPathComponent] stringByDeletingPathExtension];
        NSString* filePath = (NSString*) [[[panel URLs] objectAtIndex:0] absoluteString];
        NSString* destinationPath = [filePath stringByReplacingOccurrencesOfString:fileName withString:[NSString stringWithFormat:@"%@-encrypted", fileName]];
           BOOL dataWrittingResult = [encryptedData writeToURL:[NSURL URLWithString:destinationPath] options:NSDataWritingAtomic error:nil];
        if (dataWrittingResult == TRUE) {
            _label.stringValue = @"File encrypted successfully. If you encounter any issues please contact the developer.";
        }
    }
}

@end
