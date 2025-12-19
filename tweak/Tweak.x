#import <Foundation/Foundation.h>

void sanitize(NSMutableDictionary *plist);
void addPrincipleClassForExtension(NSMutableDictionary *plist);

%hookf(NSMutableDictionary*, _MILoadInfoPlist, NSURL *bundle, NSSet *keys) {
    NSLog(@"[InstalldTestTweak] _MILoadInfoPlist hooked impl called.");
    NSLog(@"[InstalldTestTweak] Calling original method.");
    NSMutableDictionary *plist = %orig(bundle, keys);
    NSLog(@"[InstalldTestTweak] Original plist is: %@", plist);
    sanitize(plist);
    addPrincipleClassForExtension(plist);
    NSLog(@"[InstalldTestTweak] Sanitized plist is: %@", plist);
    return plist;
}

%ctor {
    NSLog(@"[InstalldTestTweak] Injection SUCCESS! Starting up.");

    MSImageRef image = MSGetImageByName(
      "/System/Library/PrivateFrameworks/InstalledContentLibrary.framework/"
      "InstalledContentLibrary");

    if (image) {
        NSLog(@"[InstalldTestTweak] Image resolved.");
    }
    else {
      NSLog(@"[InstalldTestTweak] failed to find InstalledContentLibrary framework");
      return;
    }

    void *sym1 = MSFindSymbol(image, "_MILoadInfoPlist");

    if (sym1 != NULL) {
        NSLog(@"[InstalldTestTweak] _MILoadInfoPlist symbol FOUND at %p.", sym1);
    } else {
        NSLog(@"[InstalldTestTweak] ERROR: _MILoadInfoPlist symbol NOT FOUND. Hook skipped.");
    }
    
    %init(_MILoadInfoPlist = sym1);

}

void sanitize(NSMutableDictionary *plist) {
    NSLog(@"[InstalldTestTweak] Sanitizing plist");
    NSArray *keysToRemove = @[
        @"MinimumOSVersion", @"MinimumProductVersion",
        @"UIRequiredDeviceCapabilities", @"UISupportedDevices", @"SupportedDevices",
        @"WKWatchOnly", @"LSRequiresIPhoneOS", @"CFBundleSupportedPlatforms",
        @"NSAccentColorName"
    ];

    if (!plist) {
        NSLog(@"[InstalldTestTweak] No plist file.");
        return;
    }

    for (NSString *key in keysToRemove) {
        NSLog(@"[InstalldTestTweak] removing key: %@", key);
        [plist removeObjectForKey:key];
    }
}

void addPrincipleClassForExtension(NSMutableDictionary *plist) {
    NSLog(@"[InstalldTestTweak] Adding principle class for extension if needed");

    if (!plist) {
        NSLog(@"[InstalldTestTweak] No plist file.");
        return;
    }

    NSString *bundle_id = [plist objectForKey:@"CFBundleIdentifier"];
    if (bundle_id == NULL) {
        NSLog(@"[InstalldTestTweak] bundle_id is missing");
        return;
    }

    NSLog(@"[InstalldTestTweak] Found bnudle id: %@", bundle_id);

    NSSet<NSString *>* extensionsRequiredAddingPrincipalClass = [[NSSet<NSString *> alloc] initWithObjects:
                                                                 @"com.BUNDLE_ID.CalendarWidgetExt", // Replace BUNDLE_ID with desired string to patch unsupported extensions 
                                                                 @"com.BUNDLE_ID",
                                                                 nil];
    if (![extensionsRequiredAddingPrincipalClass containsObject:bundle_id]) {
        NSLog(@"[InstalldTestTweak] bundle id is not interesting");
        return;
    }

    NSLog(@"[InstalldTestTweak] Found required bundle id. Add key NSExtensionPrincipalClass in NSExtension dict");

    NSMutableDictionary *extensionDict = plist[@"NSExtension"];
    extensionDict[@"NSExtensionPrincipalClass"] = @"SOMECLASS";
    plist[@"NSExtension"] = extensionDict;

    NSLog(@"[InstalldTestTweak] Added key NSExtensionPrincipalClass in NSExtension dict");
}
