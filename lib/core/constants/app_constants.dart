abstract final class ApiEndpoints {
  static const String home = '/api/home';
  static const String classes = '/api/classes';
  static const String classDetail = '/api/classes';
  static const String notifications = '/api/notifications';
  static const String profile = '/api/profile';
  static const String chat = '/api/chat';
  static const String messages = '/api/messages';
  static const String calendar = '/api/calendar';
  static const String login = '/api/auth/login';
}

abstract final class AppConstants {
  static const String baseUrl = 'https://mock.dudaeducador.local';
  static const Duration cacheTtl = Duration(minutes: 5);
  static const String sessionKey = 'user_session';
}
