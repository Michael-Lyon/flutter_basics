import 'package:dart_frog/dart_frog.dart';

import 'package:daily_glorb_api/api.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(userProvider())
      .use(newsDataSourceProvider());
}
