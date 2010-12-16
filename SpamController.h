//
//  SpamController.h
//  AdiumSpammer
//
//  Created by Eduardo on 10/05/28.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpamController : NSObject {
	IBOutlet NSTextField *message;
	IBOutlet NSTextField *times;
	IBOutlet NSTextField *status;
	IBOutlet NSTextField *minMS;
	IBOutlet NSTextField *maxMS;
	IBOutlet NSTextField *credits;
	IBOutlet NSButton *spamButton;
	IBOutlet NSButton *creditsBtn;
	
	BOOL stopped;
	BOOL spamIndefinitely;
	
	int timesToSpam;
	int timesSpammed;
	int timesSpammedWhileInfinite;
}

- (IBAction)run:(id)sender;
- (IBAction)resetDelay:(id)sender;
- (IBAction)showCredits:(id)sender;
- (IBAction)quit:(id)sender;
- (void)spam;
- (void)makeMeSpamThisTimes:(int)intWithTimesToSpam orIndifinitely:(BOOL)indifenitely;

@end
