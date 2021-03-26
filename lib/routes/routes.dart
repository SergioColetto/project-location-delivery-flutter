import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:happy_postcode_flutter/pages/settings_page.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, 'Settings', SettingsPage()),
  _Route(FontAwesomeIcons.slideshare, 'Accounting', SettingsPage()),
  _Route(FontAwesomeIcons.slideshare, 'Logout', SettingsPage()),
];

class _Route {
  final IconData icon;
  final String titulo;
  final Widget page;
  _Route(this.icon, this.titulo, this.page);
}
