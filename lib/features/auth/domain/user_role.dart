enum UserRole {
  employee('employee'),
  manager('manager'),
  supervisor('supervisor'),
  hr('hr'),
  admin('admin'),
  timeTerminal('time_terminal');

  const UserRole(this.apiValue);

  final String apiValue;

  static UserRole? fromApi(String? value) {
    if (value == null) {
      return null;
    }

    for (final role in UserRole.values) {
      if (role.apiValue == value) {
        return role;
      }
    }

    return null;
  }
}
