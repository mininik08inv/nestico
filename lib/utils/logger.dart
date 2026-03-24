import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Глобальный экземпляр логгера для всего приложения
/// 
/// Настраивается автоматически в зависимости от режима:
/// - Debug: показывает все логи (debug, info, warning, error)
/// - Release: показывает только warning и error
/// 
/// Логи выводятся в консоль (терминал/IDE)
final AppLogger logger = AppLogger();

/// Обертка над Logger с удобными методами для логирования
/// 
/// Автоматически настраивает уровень логирования:
/// - В debug режиме: все логи
/// - В release режиме: только warnings и errors
/// 
/// Логи хранятся:
/// - В консоли (при запуске через `flutter run`)
/// - В Android Studio/VS Code Debug Console
/// - В production: только warnings и errors
class AppLogger {
  late final Logger _logger;
  
  AppLogger() {
    // Настройка принтера для консоли
    final consolePrinter = PrettyPrinter(
      methodCount: 2, // Количество строк стека для показа
      errorMethodCount: 8, // Количество строк стека для ошибок
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    );
    
    // В production используем простой принтер без эмодзи
    final printer = kDebugMode ? consolePrinter : SimplePrinter(colors: false);
    
    _logger = Logger(
      printer: printer,
      level: kDebugMode ? Level.debug : Level.warning, // В production только warnings и выше
    );
  }
  
  
  /// Debug сообщение (только в debug режиме)
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }
  
  /// Info сообщение (только в debug режиме)
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.i(message, error: error, stackTrace: stackTrace);
    }
  }
  
  /// Warning сообщение (показывается всегда)
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
  
  /// Error сообщение (показывается всегда)
  void e(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
  
  /// Fatal ошибка (критическая, показывается всегда)
  void f(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
}

