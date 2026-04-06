# 🏃 FitTrack Pro

> **Кроссплатформенное мобильное приложение для фитнес-трекинга**  
> Дипломный проект | Flutter | Android + iOS | Google Fit + Apple HealthKit

---

## 📱 О проекте

**FitTrack Pro** — современное мобильное приложение для отслеживания физической активности и здоровья, разработанное на Flutter. Работает на Android и iOS с интеграцией нативных API здоровья устройства.

### ✨ Ключевые функции

| Функция | Описание |
|---|---|
| 📊 **Дашборд здоровья** | Шаги, пульс, калории, вода, сон, кислород |
| 🏋️ **Трекинг тренировок** | 8 видов активности с записью истории |
| 🥗 **Дневник питания** | Завтрак, обед, ужин, макронутриенты |
| 📈 **Статистика** | Графики за неделю/месяц/год (fl_chart) |
| 👤 **Профиль** | ИМТ, цели, достижения |
| ⚙️ **Настройки** | Тема, уведомления, подключение к здоровью |
| 💜 **Онбординг** | 3 анимированных слайда |
| 🚀 **Splash экран** | Анимированная заставка |

---

## 🏗 Архитектура

```
lib/
├── app/                    # Приложение и маршрутизация
│   ├── app.dart            # Корневой виджет + тема
│   └── routes.dart         # GoRouter навигация
├── core/
│   └── constants/          # Цвета, размеры, строки
├── data/
│   ├── models/             # Dart-модели (User, Workout, Health)
│   ├── services/           # Health API сервис
│   └── repositories/       # Слой данных
└── presentation/
    ├── screens/            # 8 экранов приложения
    │   ├── splash/
    │   ├── onboarding/
    │   ├── home/
    │   ├── activity/
    │   ├── nutrition/
    │   ├── stats/
    │   ├── profile/
    │   └── settings/
    ├── widgets/            # Переиспользуемые компоненты
    │   └── common/
    └── providers/          # Riverpod state management
```

**Паттерн**: Feature-based + Clean Architecture  
**State Management**: Riverpod  
**Навигация**: GoRouter  
**Локальная БД**: Hive  

---

## 🎨 Дизайн-система

| Параметр | Значение |
|---|---|
| Тема | Тёмная (Dark Mode) |
| Primary цвет | `#6C63FF` (фиолетовый) |
| Accent цвет | `#FF6584` (розовый) |
| Background | `#0F0F1A` |
| Шрифты | Outfit + Inter (Google Fonts) |
| Стиль | Glassmorphism + градиенты |

---

## 📦 Зависимости

```yaml
flutter_riverpod      # State management
go_router             # Навигация
health                # Google Fit + Apple HealthKit
fl_chart              # Графики и диаграммы
lottie                # Анимации
hive_flutter          # Локальная база данных
google_fonts          # Типографика
animations            # Material animations
permission_handler    # Разрешения устройства
```

---

## 🚀 Запуск проекта

### Требования
- **Flutter SDK** >= 3.1.0
- **Dart** >= 3.1.0
- **Android Studio** или **VS Code** с Flutter extension
- Для Android: Android SDK, устройство или эмулятор
- Для iOS: macOS + Xcode 14+

### Установка

```bash
# 1. Перейдите в папку проекта
cd FitTrackPro

# 2. Установите зависимости
flutter pub get

# 3. Запустите приложение
flutter run

# Для конкретного устройства:
flutter run -d <device_id>

# Список устройств:
flutter devices
```

### Сборка APK (Android)

```bash
# Debug APK (для тестирования)
flutter build apk --debug

# Release APK (для установки на телефон)
flutter build apk --release

# Файл будет в: build/app/outputs/flutter-apk/app-release.apk
```

### 📲 Установка на Android-телефон

1. Включить **«Параметры разработчика»** в настройках телефона
2. Включить **«Отладка по USB»**
3. Подключить телефон к компьютеру кабелем USB
4. Выполнить `flutter run` — приложение запустится на телефоне!

---

## 🔌 Интеграция с API здоровья

### Android — Google Fit / Health Connect
Разрешения настроены в `android/app/src/main/AndroidManifest.xml`:
- `READ_STEPS` — шаги
- `READ_HEART_RATE` — пульс
- `READ_ACTIVE_CALORIES_BURNED` — калории
- `READ_SLEEP` — сон
- `READ_OXYGEN_SATURATION` — кислород

### iOS — Apple HealthKit
Разрешения настроены в `ios/Runner/Info.plist`:
- `NSHealthShareUsageDescription`
- `NSHealthUpdateUsageDescription`
- `NSMotionUsageDescription`

> **Примечание**: При первом запуске на устройстве система запросит разрешения на доступ к данным здоровья. При отказе приложение использует демо-данные.

---

## 📋 Скриншоты экранов

| Экран | Описание |
|---|---|
| 🚀 Splash | Анимация логотипа с упругим эффектом |
| 📖 Onboarding | 3 слайда с иконками и описанием |
| 🏠 Home | Дашборд с кольцом шагов и метриками |
| 🏋️ Activity | Сетка видов спорта + история |
| 🥗 Nutrition | Кольцо калорий + макросы + блюда |
| 📊 Stats | Бар-чарт шагов + линейный чарт калорий |
| 👤 Profile | Аватар, ИМТ, цели, достижения |
| ⚙️ Settings | Переключатели, подключение здоровья |

---

## 👨‍💻 Технологии

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **Platform**: Android 5.0+ / iOS 13.0+
- **Architecture**: Clean Architecture + Riverpod
- **API**: Google Fit API / Apple HealthKit

---

*Разработано как дипломный проект по теме: «Разработка кроссплатформенного мобильного приложения для фитнес-трекинга с интеграцией с API здоровья устройства»*
