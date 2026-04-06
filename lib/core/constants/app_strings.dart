class AppStrings {
  AppStrings._();

  // App
  static const String appName = 'FitTrack Pro';
  static const String appTagline = 'Твой персональный фитнес-тренер';

  // Onboarding
  static const List<Map<String, String>> onboardingSlides = [
    {
      'title': 'Отслеживай здоровье',
      'description':
          'Синхронизируйся с Google Fit и Apple Health. Все данные о здоровье в одном месте.',
      'animation': 'assets/animations/health_tracking.json',
    },
    {
      'title': 'Тренируйся умнее',
      'description':
          'Умные тренировки, персональные цели и детальная аналитика прогресса.',
      'animation': 'assets/animations/workout.json',
    },
    {
      'title': 'Достигай целей',
      'description':
          'Визуализируй прогресс, следи за питанием и побивай личные рекорды каждый день.',
      'animation': 'assets/animations/goal.json',
    },
  ];

  // Navigation
  static const String navHome = 'Главная';
  static const String navActivity = 'Активность';
  static const String navNutrition = 'Питание';
  static const String navStats = 'Статистика';
  static const String navProfile = 'Профиль';

  // Home
  static const String greeting = 'Привет';
  static const String todayActivity = 'Активность сегодня';
  static const String steps = 'Шаги';
  static const String calories = 'Калории';
  static const String heartRate = 'Пульс';
  static const String water = 'Вода';
  static const String sleep = 'Сон';
  static const String oxygen = 'Кислород';
  static const String recentWorkouts = 'Последние тренировки';
  static const String seeAll = 'Все';
  static const String quickStart = 'Быстрый старт';

  // Activity
  static const String myWorkouts = 'Мои тренировки';
  static const String startWorkout = 'Начать тренировку';
  static const String workoutHistory = 'История';
  static const String running = 'Бег';
  static const String cycling = 'Велосипед';
  static const String swimming = 'Плавание';
  static const String gym = 'Тренажёрный зал';
  static const String yoga = 'Йога';
  static const String walking = 'Ходьба';
  static const String duration = 'Длительность';
  static const String distance = 'Дистанция';

  // Nutrition
  static const String todayNutrition = 'Питание сегодня';
  static const String addMeal = 'Добавить приём пищи';
  static const String breakfast = 'Завтрак';
  static const String lunch = 'Обед';
  static const String dinner = 'Ужин';
  static const String snack = 'Перекус';
  static const String protein = 'Белки';
  static const String carbs = 'Углеводы';
  static const String fat = 'Жиры';
  static const String caloriesGoal = 'Цель калорий';
  static const String caloriesConsumed = 'Съедено';
  static const String caloriesLeft = 'Осталось';

  // Stats
  static const String statistics = 'Статистика';
  static const String weekly = 'Неделя';
  static const String monthly = 'Месяц';
  static const String yearly = 'Год';
  static const String stepsChart = 'График шагов';
  static const String weightProgress = 'Прогресс веса';
  static const String personalRecords = 'Личные рекорды';

  // Profile
  static const String myProfile = 'Мой профиль';
  static const String editProfile = 'Редактировать';
  static const String myGoals = 'Мои цели';
  static const String achievements = 'Достижения';
  static const String weight = 'Вес';
  static const String height = 'Рост';
  static const String age = 'Возраст';
  static const String bmi = 'ИМТ';

  // Settings
  static const String settings = 'Настройки';
  static const String notifications = 'Уведомления';
  static const String healthConnection = 'Подключение к здоровью';
  static const String theme = 'Тема';
  static const String language = 'Язык';
  static const String units = 'Единицы измерения';
  static const String privacy = 'Конфиденциальность';
  static const String about = 'О приложении';
  static const String version = 'Версия 1.0.0';

  // Units
  static const String km = 'км';
  static const String kcal = 'ккал';
  static const String bpm = 'уд/мин';
  static const String ml = 'мл';
  static const String hours = 'ч';
  static const String minutes = 'мин';
  static const String percent = '%';
  static const String kg = 'кг';
  static const String cm = 'см';

  // Buttons
  static const String getStarted = 'Начать';
  static const String next = 'Далее';
  static const String skip = 'Пропустить';
  static const String save = 'Сохранить';
  static const String cancel = 'Отмена';
  static const String connect = 'Подключить';
  static const String disconnect = 'Отключить';
}
