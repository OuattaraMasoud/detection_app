library utils;

export 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:logger/logger.dart';

final logger =
    Logger(printer: PrettyPrinter(printTime: true), level: Level.debug);
final isNumeric = RegExp(r'^[0-9\s]+$');
