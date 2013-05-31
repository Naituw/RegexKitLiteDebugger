//
//  RDAppDelegate.h
//  RegexKitLiteDebugger
//
//  Created by Wutian on 13-5-31.
//  Copyright (c) 2013年 wutian. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RDAppDelegate : NSObject <NSApplicationDelegate, NSTextViewDelegate, NSControlTextEditingDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField * regexTextField;
@property (assign) IBOutlet NSTextView * contentTextView;
@property (assign) IBOutlet NSTextView * resultTextView;

@end
