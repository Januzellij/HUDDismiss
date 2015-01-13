@interface SBHUDView : UIView
-(id)initWithHUDViewLevel:(int)level;
@end

@interface SBWindow : UIWindow
@end

@interface SBHUDWindow : SBWindow
-(BOOL)_ignoresHitTest;
@end

%hook SBHUDView

-(id)initWithHUDViewLevel:(int)level {
        %orig;
        UITapGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUD)];
        [self addGestureRecognizer:rec];
        return self;
}

%new

-(void)hideHUD {
	self.window.hidden = YES;
}

%end

%hook SBHUDWindow
-(BOOL)_ignoresHitTest {
        [self setUserInteractionEnabled:YES];
        return NO;
}
%end
