class AppSettings {
  bool darkMode;

  bool isLoggedIn;

  String language;

  bool notifications;

  AppSettings({
    this.darkMode = false,

    this.isLoggedIn = false,

    this.language = "English",

    this.notifications = true,
  });
}
