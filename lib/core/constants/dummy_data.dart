/// All dummy/test data used throughout the FIXA prototype.
///
/// This file is the single source of truth for mock mechanics, services,
/// issues, urgency options, and history items.
class DummyData {
  DummyData._();

  /// Nearby mechanics with realistic Zambian names and rates in Kwacha.
  static const List<Map<String, dynamic>> mechanics = <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'm1',
      'name': 'James Mwale',
      'specialization': 'Engine & Electrical',
      'rating': 4.8,
      'jobs': 124,
      'distance': '1.2 km',
      'eta': '~10 min',
      'rate': 'K150/hr',
      'status': 'available',
      'initials': 'JM',
      'color': 0xFFE8A020,
      'type': 'mechanic',
    },
    <String, dynamic>{
      'id': 'm2',
      'name': 'Peter Kalinda',
      'specialization': 'Tyres & Brakes',
      'rating': 4.6,
      'jobs': 89,
      'distance': '2.8 km',
      'eta': '~25 min',
      'rate': 'K120/hr',
      'status': 'busy',
      'initials': 'PK',
      'color': 0xFF1565C0,
      'type': 'mechanic',
    },
    <String, dynamic>{
      'id': 'm3',
      'name': 'AutoFix Garage',
      'specialization': 'Full Service Centre',
      'rating': 4.9,
      'jobs': 312,
      'distance': '1.8 km',
      'eta': '~15 min',
      'rate': 'K200/hr',
      'status': 'available',
      'initials': 'AG',
      'color': 0xFF2E7D32,
      'type': 'garage',
    },
    <String, dynamic>{
      'id': 'm4',
      'name': 'Chisomo Banda',
      'specialization': 'Body & Paint',
      'rating': 4.5,
      'jobs': 67,
      'distance': '3.5 km',
      'eta': '~30 min',
      'rate': 'K180/hr',
      'status': 'available',
      'initials': 'CB',
      'color': 0xFF6A1B9A,
      'type': 'mechanic',
    },
    <String, dynamic>{
      'id': 'm5',
      'name': 'Rapid Response Auto',
      'specialization': '24/7 Emergency & Towing',
      'rating': 4.7,
      'jobs': 445,
      'distance': '4.1 km',
      'eta': '~35 min',
      'rate': 'K250/hr',
      'status': 'available',
      'initials': 'RR',
      'color': 0xFFC62828,
      'type': 'towing',
    },
  ];

  /// Service tiles on the home screen.
  static const List<Map<String, dynamic>> services = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Request Mechanic',
      'iconCode': 0xe1b8, // Icons.build_outlined fallback handled in widget
      'bgColor': 0xFFFFF3E0,
      'iconColor': 0xFFE8A020,
      'highlighted': true,
      'key': 'mechanic',
    },
    <String, dynamic>{
      'title': 'Find Garage',
      'iconCode': 0xe88a,
      'bgColor': 0xFFE3F2FD,
      'iconColor': 0xFF1565C0,
      'highlighted': false,
      'key': 'garage',
    },
    <String, dynamic>{
      'title': 'Towing Service',
      'iconCode': 0xe531,
      'bgColor': 0xFFFFEBEE,
      'iconColor': 0xFFC62828,
      'highlighted': false,
      'key': 'towing',
    },
    <String, dynamic>{
      'title': 'Book Service',
      'iconCode': 0xe8df,
      'bgColor': 0xFFE8F5E9,
      'iconColor': 0xFF2E7D32,
      'highlighted': false,
      'key': 'book',
    },
  ];

  /// Issue types in the request screen.
  static const List<Map<String, dynamic>> issueTypes =
      <Map<String, dynamic>>[
    <String, dynamic>{'label': 'Engine Problem', 'iconCode': 0xe1b8},
    <String, dynamic>{'label': 'Battery Dead', 'iconCode': 0xe1a3},
    <String, dynamic>{'label': 'Flat Tyre', 'iconCode': 0xe531},
    <String, dynamic>{'label': 'Overheating', 'iconCode': 0xe40b},
    <String, dynamic>{'label': 'Brakes', 'iconCode': 0xe1b9},
    <String, dynamic>{'label': 'Other', 'iconCode': 0xe5d3},
  ];

  /// Urgency options.
  static const List<String> urgencyOptions = <String>[
    'Emergency',
    'Today',
    'Schedule',
  ];

  /// Map pins drawn on top of the mock map image. Positions are
  /// normalized (0.0 - 1.0) relative to the map image size.
  static const List<Map<String, dynamic>> mapPins = <Map<String, dynamic>>[
    <String, dynamic>{'id': 'm1', 'left': 0.18, 'top': 0.32, 'type': 'mechanic'},
    <String, dynamic>{'id': 'm2', 'left': 0.62, 'top': 0.22, 'type': 'mechanic'},
    <String, dynamic>{'id': 'm3', 'left': 0.45, 'top': 0.55, 'type': 'garage'},
    <String, dynamic>{'id': 'm4', 'left': 0.78, 'top': 0.68, 'type': 'mechanic'},
    <String, dynamic>{'id': 'm5', 'left': 0.25, 'top': 0.72, 'type': 'garage'},
  ];

  /// Fake history items.
  static const List<Map<String, dynamic>> history = <Map<String, dynamic>>[
    <String, dynamic>{
      'mechanic': 'James Mwale',
      'service': 'Engine diagnostic',
      'date': 'May 10, 2026',
      'cost': 'K320',
      'status': 'Completed',
    },
    <String, dynamic>{
      'mechanic': 'AutoFix Garage',
      'service': 'Brake replacement',
      'date': 'Apr 22, 2026',
      'cost': 'K780',
      'status': 'Completed',
    },
  ];
}
