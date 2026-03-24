import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import 'package:nestico/data/database/database_service.dart';
import 'package:nestico/theme/app_theme.dart';
import 'package:nestico/utils/logger.dart';
import 'package:nestico/screens/home/home_page.dart';


/// Инициализация базы данных для десктопных платформ
///
/// Для Linux, Windows и macOS нужно использовать sqflite_common_ffi
/// и инициализировать databaseFactory перед использованием базы данных
Future<void> _initDatabaseForDesktop() async {
  // Проверяем, что это не веб
  if (kIsWeb) {
    // Для web используем реализацию на IndexedDB
    sqflite.databaseFactory = databaseFactoryFfiWeb;
    return;
  }

  // Проверяем, что это десктопная платформа
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    try {
      // Инициализируем databaseFactory для десктопных платформ
      // Это должно быть сделано ДО любого использования openDatabase или getDatabasesPath
      // Устанавливаем глобальный databaseFactory для sqflite
      sqflite.databaseFactory = sqflite_ffi.databaseFactoryFfi;
    } catch (e, stackTrace) {
      // Если инициализация не удалась, это критическая ошибка для десктопа
      logger.e('sqflite_common_ffi initialization failed', e, stackTrace);
      rethrow; // Пробрасываем ошибку, так как на десктопе это критично
    }
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // нужно для асинхронности до runApp
  await _initDatabaseForDesktop(); // важно для desktop (Linux/Windows/macOS) с sqflite_common_ffi
  await DatabaseService().database; // инициализация БД

  runApp(
    ProviderScope(
      // create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nestico',
      theme: AppTheme.light,
      // darkTheme: AppTheme.dark,
      // themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      home: MyHomePage(title: 'Nestico'),
    );
  }
}
