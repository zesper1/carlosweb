import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/chat.dart';
import 'screens/sidebar.dart';
import 'screens/doctors_list.dart';
import 'screens/doctor_preview.dart';
import 'screens/feedback.dart';
import 'screens/profile.dart';
import 'screens/resources.dart';
import 'screens/routine.dart';
import 'screens/about.dart';
import 'screens/home.dart';

// New imports for additional features
import 'screens/message.dart';
import 'screens/appointment_screen.dart';
import 'screens/call_screen.dart';
import 'screens/video_call_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/home': (context) => HomePage(),
  '/chat': (context) => ChatPage(),
  '/sidebar': (context) => AppSidebar(),
  '/doctors_list': (context) => DoctorsListPage(),
  '/doctor_preview': (context) => DoctorPreviewPage(),
  '/feedback': (context) => FeedbackPage(),
  '/profile': (context) => ProfilePage(),
  '/resources': (context) => ResourcesPage(),
  '/routine': (context) => RoutinePage(),
  '/about': (context) => AboutPage(),

  // New Routes for added features
  '/chatScreen': (context) => Message(),
  '/appointmentBooking': (context) => AppointmentScreen(),
  '/callScreen': (context) => CallScreen(),
  '/videoCallScreen': (context) => VideoCallScreen(),
};
