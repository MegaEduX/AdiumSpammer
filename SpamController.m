//
//  SpamController.m
//  AdiumSpammer
//
//  Created by Eduardo on 10/05/28.
//  Copyright 2010 MegaEduX.com. All rights reserved.
//

#import "SpamController.h"

@implementation SpamController

- (void)awakeFromNib {
	stopped = YES;
	timesSpammed = 0;
	timesSpammedWhileInfinite = 0;
}

- (IBAction)run:(id)sender {
	if (stopped) {
		stopped = NO;
		[status setStringValue:@"Initializing"];
		[spamButton setTitle:@"Stop"];
		[status setStringValue:@"Running"];
		if ([times intValue] == 0) {
			[self makeMeSpamThisTimes:0 orIndifinitely:YES];
		} else {
			[self makeMeSpamThisTimes:[times intValue] orIndifinitely:NO];
		}
	} else {
		stopped = YES;
		[status setStringValue:@"Stopped"];
		[spamButton setTitle:@"Spam him or her!"];
		timesSpammed = 0;
		timesSpammedWhileInfinite = 0;
	}
}

- (IBAction)showCredits:(id)sender {
	[credits setStringValue:@"© Eduardo Almeida (MegaEduX.com) 2010"];
	[creditsBtn setEnabled:NO];
}

- (IBAction)resetDelay:(id)sender {
	[minMS setStringValue:@"500"];
	[maxMS setStringValue:@"1000"];
}

- (IBAction)quit:(id)sender {
	exit(0);
}

- (void)makeMeSpamThisTimes:(int)intWithTimesToSpam orIndifinitely:(BOOL)indifenitely {
	if (indifenitely)
		spamIndefinitely = YES;
	
	timesToSpam = intWithTimesToSpam;
	[self spam];
}

- (void)spam {
	if (!stopped) {
		int kipz = rand()%[minMS intValue] + [maxMS intValue];
		int mudKIPZ = kipz * 0.001;
		
		NSAppleScript *playScript;
		playScript = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"tell application \"Adium\" to send the active chat message \"%@\"", [[message stringValue] stringByReplacingOccurrencesOfString:@"\"" withString:@""]]];
		[playScript executeAndReturnError:nil];
		
		if (!spamIndefinitely) {
			if (timesToSpam > 0) {
				[NSTimer scheduledTimerWithTimeInterval:mudKIPZ target:self selector:@selector(spam) userInfo:nil repeats:NO];
				int timesLeft = [times intValue] - timesSpammed;
				timesSpammed++;
				[status setStringValue:[NSString stringWithFormat:@"Spamming more %d times", timesLeft]];
			}
		} else {
			[NSTimer scheduledTimerWithTimeInterval:mudKIPZ target:self selector:@selector(spam) userInfo:nil repeats:NO];
			timesSpammedWhileInfinite++;
			[status setStringValue:[NSString stringWithFormat:@"Spammed %d times", timesSpammedWhileInfinite]];
		}
	}
}

@end
