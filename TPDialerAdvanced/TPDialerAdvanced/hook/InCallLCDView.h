/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: (null)
 */

//#import "XXUnknownSuperclass.h" // Unknown library

@class UIView, NSString, NSTimer, UIImageView, TPLCDTextView, UIButton, XXUnknownSuperclass;

@interface InCallLCDView : XXUnknownSuperclass {
	TPLCDTextView* _labelView2;
	TPLCDTextView* _textView2;
	UIView* _activeIndicator;
	int _activePosition;
	int _conferencePosition;
	UIImageView* _oldBkgndView;
	UIImageView* _newBkgndView;
	TPLCDTextView* _oldLabelView;
	TPLCDTextView* _oldLabelView2;
	TPLCDTextView* _oldTextView;
	TPLCDTextView* _oldTextView2;
	UIView* _oldActiveIndicator;
	UIButton* _conferenceButton;
	NSTimer* _alternatingTimer;
	NSString* _originalLabel;
	NSString* _originalLabel2;
	NSString* _alternateLabel;
	NSString* _alternateLabel2;
	id _delegate;
	unsigned _ignoreLayout : 1;
	unsigned _animating : 1;
	unsigned _progress : 1;
	unsigned _dimmedText : 2;
	unsigned _canTruncateLabel : 2;
	unsigned _enableFade : 1;
	unsigned _changingForAlternate : 1;
	BOOL _callerIsAmbiguous;
}
@property(assign, nonatomic) BOOL callerIsAmbiguous;
-(void)dealloc;
-(void)setDelegate:(id)delegate;
-(void)layoutSubviews;
-(void)removeFromSuperview;
-(void)_updateTextAttributes;
-(void)_cancelScrollingForTextView:(id)textView;
-(void)_enableScrollingForTextView:(id)textView start:(BOOL)start;
-(void)performTextFadeWithDuration:(float)duration delay:(float)delay forView:(id*)view newText:(id)text setter:(SEL)setter position:(int)position;
-(void)lcdTextViewCompletedScroll:(id)scroll;
-(void)setTextScrolls:(BOOL)scrolls;
-(void)setTextChangeFadingEnabled:(BOOL)enabled;
-(void)setText:(id)text;
-(void)setText:(id)text animating:(BOOL)animating;
-(void)setTextDimmed:(BOOL)dimmed;
-(void)setLabel:(id)label alternateLabel:(id)label2;
-(void)setLabel:(id)label;
-(void)setLabelVisible:(BOOL)visible;
-(void)setCanTruncateLabel:(BOOL)label;
-(void)setText2:(id)a2;
-(void)setText2Dimmed:(BOOL)dimmed;
-(void)setText2:(id)a2 animating:(BOOL)animating;
-(id)text2;
-(void)setLabel2:(id)a2 alternateLabel:(id)label;
-(void)setLabel2:(id)a2;
-(id)label2;
-(void)setCanTruncateLabel2:(BOOL)a2;
-(void)setAlternateLabel:(id)label;
-(id)originalLabel;
-(void)setAlternateLabel2:(id)a2;
-(id)originalLabel2;
-(void)setSubImage:(id)image;
-(void)_positionActiveCallIndicator;
-(void)_removeAnimationViews;
-(id)_backgroundForPosition:(int)position;
-(void)_updateForActivePosition;
-(void)setActivePosition:(int)position;
-(void)animateToActivePosition:(int)activePosition label:(id)label label2:(id)a2;
-(void)_activationAnimationFinished;
-(void)setActiveIndicatorShowsProgress:(BOOL)progress;
-(void)touchesEnded:(id)ended withEvent:(id)event;
-(void)_positionConferenceButton;
-(void)_conferenceButtonClicked:(id)clicked;
-(void)setConferencePosition:(int)position;
-(int)conferencePosition;
-(void)animateCallMergeWithDuration:(float)duration;
-(void)popText;
-(void)_popTextFinishedFirstHalf;
-(void)_popTextFinished;
-(void)animateLabel;
-(void)_finishedAnimatingLabel;
-(void)_startAlternating;
-(void)_stopAlternating;
-(void)_alternate:(id)alternate;
@end

