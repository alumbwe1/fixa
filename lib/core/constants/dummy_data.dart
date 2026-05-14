/// All dummy/test data used throughout the FIXA prototype.
class DummyData {
  DummyData._();

  /// Nearby mechanics with realistic Zambian names, rates in Kwacha,
  /// and Unsplash portrait URLs as avatars.
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
      'image':
          'https://images.unsplash.com/photo-1568602471122-7832951cc4c5?w=400&h=400&fit=crop',
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
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop',
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
      'image':
          'https://images.unsplash.com/photo-1486006920555-c77dcf18193c?w=400&h=400&fit=crop',
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
      'image':
          'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=400&h=400&fit=crop',
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
      'image':
          'https://images.unsplash.com/photo-1599577180589-0a72a05e3a73?w=400&h=400&fit=crop',
    },
  ];

  /// Service tiles on the home screen. `asset` points to the icon image.
  static const List<Map<String, dynamic>> services = <Map<String, dynamic>>[
    <String, dynamic>{
      'title': 'Request Mechanic',
      'asset': 'assets/gear.png',
      'bgColor': 0xFFFFF3E0,
      'highlighted': true,
      'key': 'mechanic',
    },
    <String, dynamic>{
      'title': 'Find Garage',
      'asset': 'assets/service.png',
      'bgColor': 0xFFE3F2FD,
      'highlighted': false,
      'key': 'garage',
    },
    <String, dynamic>{
      'title': 'Towing Service',
      'asset': 'assets/tire.png',
      'bgColor': 0xFFFFEBEE,
      'highlighted': false,
      'key': 'towing',
    },
    <String, dynamic>{
      'title': 'Book Service',
      'asset': 'assets/service.png',
      'bgColor': 0xFFE8F5E9,
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
