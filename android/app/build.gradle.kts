plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // Düzgün id kullanımı
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // Firebase için gerekli
}

android {
    namespace = "com.example.egitmen_ogrenci_app2"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.egitmen_ogrenci_app2"
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

flutter {
    source = "../.."
}
