@interface SBHUDView : UIView
@end

@interface SBVolumeHUDView : SBHUDView
-(id)initWithHUDViewLevel:(int)level;
@end

@interface SBWindow : UIWindow
@end

@interface SBHUDWindow : SBWindow
-(BOOL)_ignoresHitTest;
@end

@interface SBHUDController : NSObject
+(id)sharedHUDController;
-(void)hideHUDView;
@end

%hook SBVolumeHUDView

-(id)initWithHUDViewLevel:(int)level {
        %orig;
        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUD)];
        [self addGestureRecognizer:rec];
        [rec release];
        return self;
}

/*- (void)layoutSubviews {
        %orig;
        [self setUserInteractionEnabled:YES];
        	[(SBMediaController *)[%c(SBMediaController) sharedInstance] setVolume:slide.value];

}*/

%new

-(void)hideHUD {
	[(SBHUDController *)[%c(SBHUDController) sharedHUDController] hideHUDView];
}

%end

%hook SBHUDWindow
-(BOOL)_ignoresHitTest {
        [self setUserInteractionEnabled:YES];
        return NO;
}
%end
