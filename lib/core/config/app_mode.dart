/// Top-level runtime mode of the app shell.
///
/// `backoffice` is the default HR/Compliance experience that starts on the
/// authentication flow. `terminal` is the kiosk/time-clock experience that
/// starts on the terminal screen and never exposes the backoffice features.
enum AppMode {
  backoffice,
  terminal;

  static AppMode fromName(String value) {
    return AppMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => AppMode.backoffice,
    );
  }
}
