import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

/// True when running natively on iOS (excludes web, where Platform is unsafe to use).
bool get isPlatformIOS => !kIsWeb && Platform.isIOS;
