# ===== Flutter 引擎通用 keep 规则 =====
# Flutter 引擎通过反射和字符串路由调用原生代码，必须保留。
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.flutter.embedding.** { *; }

# Flutter MethodChannel / EventChannel 的 handler 通过字符串路由注册，
# R8 无法静态分析这种引用关系。
-keep class * extends io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }
-keep class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }
-keep class * extends io.flutter.plugin.common.EventChannel$StreamHandler { *; }
-keep class * implements io.flutter.plugin.common.EventChannel$StreamHandler { *; }

# Flutter Plugin Registrant（GeneratedPluginRegistrant）
-keep class **.GeneratedPluginRegistrant { *; }

# 兜底规则：keep 所有 Flutter 插件和 ActivityResultListener。
# Flutter 的插件注册机制通过反射实例化插件类，
# R8 的静态分析无法追踪 GeneratedPluginRegistrant 中的字符串注册。
-keep class * implements io.flutter.plugin.common.PluginRegistry$PluginRegistrantCallback { *; }
-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin { *; }
-keep class * implements io.flutter.embedding.engine.plugins.activity.ActivityAware { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$ActivityResultListener { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$RequestPermissionsResultListener { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$NewIntentListener { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$UserLeaveHintListener { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$ViewDestroyListener { *; }

# in_app_purchase (Flutter 官方): 通过 MethodChannel 通信
-keep class io.flutter.plugins.inapppurchase.** { *; }

# ===== 项目自身 Kotlin 代码 =====
# MainActivity: 通过 MethodChannel("org.localsend.localsend_app/localsend") 被 Flutter 引擎调用，
# 且在 AndroidManifest.xml 中声明为 android:name=".MainActivity"。
-keep class org.localsend.localsend_app.MainActivity { *; }
-keep class org.localsend.localsend_app.MainActivity$* { *; }

# MainActivityKt: MainActivity.kt 中的顶层函数和常量（CHANNEL、REQUEST_CODE_*、
# PERMISSION_ACCESS_LOCAL_NETWORK、API_LEVEL_ANDROID_17、Long.toRfc3339() 扩展函数）。
# Kotlin 将文件级顶层代码编译到 <FileName>Kt 类中，与 MainActivity 是不同的类。
-keep class org.localsend.localsend_app.MainActivityKt { *; }

# QuickTileService: 在 AndroidManifest.xml 中声明为 android:name=".QuickTileService"，
# 系统通过反射实例化。
-keep class org.localsend.localsend_app.QuickTileService { *; }

# FileOpener: 顶层函数，被 MainActivity 直接引用，toMap() 方法名不能被混淆。
-keep class org.localsend.localsend_app.FileOpenerKt { *; }

# FastDocumentFile: 被 MainActivity 和 QuickTileService 引用，companion object 方法不能被混淆。
-keep class org.localsend.localsend_app.FastDocumentFile { *; }
-keep class org.localsend.localsend_app.FastDocumentFile$Companion { *; }

# PickDirectoryResult / FileInfo: data class，toMap() 返回给 Flutter，
# 方法名和字段名不能被混淆。
-keep class org.localsend.localsend_app.PickDirectoryResult { *; }
-keep class org.localsend.localsend_app.FileInfo { *; }

# ===== 第三方 Flutter 插件 keep 规则 =====

# flutter_foreground_task: AndroidManifest.xml 中声明了
# com.pravera.flutter_foreground_task.service.ForegroundService
-keep class com.pravera.flutter_foreground_task.** { *; }

# device_apps: 通过 MethodChannel 通信
-keep class sk.fourq.** { *; }
-keep class com.kineticdev.device_apps.** { *; }

# permission_handler (Baseflow): 通过 MethodChannel 通信
-keep class com.baseflow.permissionhandler.** { *; }

# share_handler: 通过 MethodChannel / EventChannel 通信，涉及 Intent receiver
-keep class dev.williamburma.sharenavigator.** { *; }
-keep class com.oliverbytes.share_handler.** { *; }

# open_filex: 通过 MethodChannel 通信
-keep class com.mcouble.open_filex.** { *; }

# open_dir: 通过 MethodChannel 通信
-keep class dev.lijing.open_dir.** { *; }

# pasteboard: 通过 MethodChannel 通信
-keep class com.joserodp.** { *; }

# wechat_assets_picker / photo_manager: 涉及大量原生资源和反射
-keep class com.fluttcfy.photo_manager.** { *; }
-keep class com.fluttcfy.app.** { *; }

# connectivity_plus: 通过 MethodChannel 通信
-keep class dev.fluttercommunity.plus.connectivity.** { *; }

# device_info_plus: 通过 MethodChannel 通信
-keep class dev.fluttercommunity.plus.device_info.** { *; }

# package_info_plus: 通过 MethodChannel 通信
-keep class dev.fluttercommunity.plus.package_info.** { *; }

# network_info_plus: 通过 MethodChannel 通信
-keep class dev.fluttercommunity.plus.network_info.** { *; }

# file_picker / file_selector: 通过 MethodChannel 通信
-keep class com.mr.flutterpicker.** { *; }
-keep class io.github.mr0xf00.easycrop.** { *; }

# shared_preferences: 通过 MethodChannel 通信
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# url_launcher: 通过 MethodChannel 通信
-keep class io.flutter.plugins.urllauncher.** { *; }

# path_provider: 通过 MethodChannel 通信
-keep class io.flutter.plugins.pathprovider.** { *; }

# image_picker: 通过 MethodChannel 通信
-keep class io.flutter.plugins.imagepicker.** { *; }

# wakelock_plus: 通过 MethodChannel 通信
-keep class dev.fluttercommunity.wakelock_plus.** { *; }

# flutter_displaymode: 通过 MethodChannel 通信
-keep class com.jhomlala.flutter_displaymode.** { *; }

# tray_manager / screen_retriever / window_manager: 桌面端插件，Android 上不活跃
# 但为安全起见仍然 keep
-keep class dev.leanflutter.plugins.** { *; }

# dynamic_color: 通过 MethodChannel 通信
-keep class com.gdelataillade.dynamic_color.** { *; }

# desktop_drop: 通过 MethodChannel 通信
-keep class dev.leanflutter.plugins.desktop_drop.** { *; }

# ===== Kotlin Metadata / Reflection 通用保护 =====
# 保留 Kotlin Metadata，部分库依赖反射读取 Kotlin 元数据。
-keepattributes RuntimeVisibleAnnotations,RuntimeVisibleParameterAnnotations,RuntimeVisibleTypeAnnotations,Signature,InnerClasses,EnclosingMethod,*Annotation*

# 保留 Parcelable / Serializable（Android Intent 传递可能需要）
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object readResolve();
}

# 保留 enum 的 values() 和 valueOf()（部分插件依赖）
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ===== Google Play Core 缺失类修复 =====
# Flutter 引擎内部（FlutterPlayStoreSplitApplication、PlayStoreDeferredComponentManager）
# 引用了 com.google.android.play.core.* 类，用于 Play Store 的 Deferred Components 功能。
# LocalSend 不使用该功能且未引入 Play Core 依赖，R8 在 minify 阶段会因找不到这些类而报错。
# 告诉 R8 这些缺失类是预期的，不要报错。
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**
-dontwarn com.google.android.play.core.assetpacks.**

# ===== Android Predictive Back Gesture 缺失类修复 =====
# Flutter 引擎的 FlutterActivity 引用了 android.window.BackEvent（Android 13+ API）。
# 项目 minSdkVersion 为 21，低于 API 33，R8 在 minify 阶段会因找不到该类而报错。
-dontwarn android.window.BackEvent
-dontwarn android.window.OnBackInvokedDispatcher
-dontwarn android.window.OnBackInvokedCallback

# ===== 常见第三方库注解缺失类预防 =====
# 部分依赖库引用了编译时注解（如 errorprone、jsr305），运行时不需要这些类。
-dontwarn javax.annotation.**
-dontwarn org.checkerframework.**
-dontwarn com.google.errorprone.**

# ===== Android hidden API / 内部类预防 =====
# 部分 SDK 在高版本 compileSdk 下引用了非公开 API，R8 可能报缺失。
-dontwarn android.provider.DeviceConfig
-dontwarn dalvik.system.BlockGuard$**
-dontwarn dalvik.system.CloseGuard
