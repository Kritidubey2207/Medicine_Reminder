plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.medicine_reminder"
    compileSdk = flutter.compileSdkVersion
defaultConfig {
    applicationId = "com.example.medicine_reminder"
    minSdk = flutter.minSdkVersion
    targetSdk = 34   // 🔥 REQUIRED FOR NOTIFICATIONS
    versionCode = flutter.versionCode
    versionName = flutter.versionName
}

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

