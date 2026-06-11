enum AppRoute {
  auth('/auth'),
  timeclock('/timeclock'),
  employee('/employee'),
  manager('/manager'),
  hrAdmin('/hr-admin');

  const AppRoute(this.path);

  final String path;
}
