# MoonSpace

![](./example/docs/doc.excalidraw.png)


### SDK-MANAGER

yes | sdkm --licenses

sdkm --list_installed --verbose

sdkm --uninstall "platform-tools"
sdkm --uninstall  "platforms;android-36.1"

sdkm --list | grep -i platform
sdkm "platform-tools"
sdkm "platforms;android-34"

sdkm "cmdline-tools;latest"

sdkm --list | grep "build-tools"
sdkm "build-tools;36.1.0"

sdkm "emulator"

sdkm --list | grep "system-images"
sdkm "system-images;android-34;google_apis_playstore;arm64-v8a"


flutter doctor --android-licenses
flutter doctor

$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager list

$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd -n "Android_34_Emulator" -k "system-images;android-34;google_apis_playstore;arm64-v8a" -d "pixel_9"
$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd -n "Foldable_Tablet_Emulator" -k "system-images;android-34;google_apis_playstore;arm64-v8a" -d "8in Foldable"

$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager delete avd -n Android_36_Emulator

flutter emulators
flutter emulators --launch Android_34_Emulator

