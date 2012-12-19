//
//  AZLoginForgetPasswordView.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 06/12/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZLoginForgetPasswordView.h"
#import "UIGlossyButton.h"


@interface AZLoginForgetPasswordView()

@property (nonatomic, strong) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) IBOutlet UIButton *selectQuestionButton;
@property (nonatomic, strong) IBOutlet UITextField *answareTextField;
@property (nonatomic, strong) IBOutlet UIGlossyButton *sendButton;
@property (nonatomic, strong) SBTableAlert *alert;
@property (nonatomic, strong) NSArray *questionsArray;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundView;

@end

@implementation AZLoginForgetPasswordView

@synthesize delegate = _delegate;
@synthesize closeButton = _closeButton;
@synthesize sendButton = _sendButton;
@synthesize selectQuestionButton = _selectQuestionButton;
@synthesize answareTextField = _answareTextField;
@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configureLoginView];
    }
    return self;
}

- (void) configureLoginView {
    
    [_backgroundView setImage:[UIImage imageNamed:@"loginImages.bundle/loginBackground-forget.png"]];
    
    _questionsArray = @[
    @"Il nome della tua città di nascita?",
    @"Cos'hai studiato all'università?",
    @"Qual'era il tuo primo lavoro?",
    @"Il nome del tuo animale preferito?",
    @"Il nome della tua prima scuola?",
    @"Il nome del tuo primo figlio o figlia?",
    @"Qual'è il tuo numero fortunato?",
    @"Qual'è la tua parola segreta?",
    @"Il nome della via in cui sei cresciuto?",
    @"Il cognome di tua madre da nubile?"];
    
    [_answareTextField setPlaceholder:NSLocalizedString(@"answarePlaceholder", "placeholder")];
    
    TTTAttributedLabel *titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 0, 260, 60)];
    [titleLabel setFont:[UIFont fontWithName:@"Aller" size:23.f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:NSLocalizedString(@"titleRecoverPassword", @"title")];
    [self addSubview:titleLabel];
    
    [_sendButton setBackgroundColor:[UIColor clearColor]];
    [_sendButton setTintColor:[UIColor redColor]];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    [_closeButton setImage:[UIImage imageNamed:@"loginImages.bundle/login_closeButton-nr.png"] forState:UIControlStateNormal];
    [_closeButton setImage:[UIImage imageNamed:@"loginImages.bundle/login_closeButton-hi.png"] forState:UIControlStateHighlighted];
    [_closeButton addTarget:_delegate action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_selectQuestionButton addTarget:self action:@selector(selectAnsware:) forControlEvents:UIControlEventTouchUpInside];
    [_selectQuestionButton setTitle:NSLocalizedString(@"chooseQuestion", "Question button") forState:UIControlStateNormal];
}


- (void)selectAnsware:(id)sender
{
    _alert	= [[SBTableAlert alloc] initWithTitle:NSLocalizedString(@"chooseQuestion", "titleAlert") cancelButtonTitle:NSLocalizedString(@"cancel", "alertCancel") messageFormat:nil];
    [_alert.view setTag:2];
    [_alert setStyle:SBTableAlertStyleApple];
    
    [_alert setDelegate:self];
	[_alert setDataSource:self];
	[_alert show];
}


#pragma mark - SBTableAlertDataSource

- (UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
    
	if (tableAlert.view.tag == 0 || tableAlert.view.tag == 1) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	} else {
		// Note: SBTableAlertCell
		cell = [[SBTableAlertCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	}
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:14.f]];
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    if (SYSTEM_VERSION_GREATER_THAN(@"5.1")) {
        [cell.textLabel setAdjustsLetterSpacingToFitWidth:YES];
        [cell.textLabel setMinimumScaleFactor:0.6];
    } else {
        [cell.textLabel setMinimumFontSize:10.f];
    }
	[cell.textLabel setText:[_questionsArray objectAtIndex:indexPath.row]];
    
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
	return [_questionsArray count];
}

- (NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert {
	return 1;
}



#pragma mark - SBTableAlertDelegate

- (void)tableAlert:(SBTableAlert *)tableAlert didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableAlert.type == SBTableAlertTypeMultipleSelct) {
		UITableViewCell *cell = [tableAlert.tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone)
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		else
			[cell setAccessoryType:UITableViewCellAccessoryNone];
        
		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
    
     [_selectQuestionButton setTitle:[_questionsArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
}


- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
    //
}



@end
