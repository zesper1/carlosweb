import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _supabase = Supabase.instance.client;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _bookAppointment(String doctorName) async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select date and time.")),
      );
      return;
    }

    final appointment = {
      'doctor_name': doctorName,
      'date': _selectedDate!.toIso8601String(),
      'time': _selectedTime!.format(context),
      'status': 'pending',
    };

    try {
      await _supabase.from('appointments').insert(appointment);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment booked successfully!")),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to book appointment: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment with ${doctor?['name']}")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Date & Time for Appointment",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickDate(context),
              child: Text(_selectedDate == null
                  ? "Choose Date"
                  : "Date: ${_selectedDate!.toLocal()}".split(' ')[0]),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickTime(context),
              child: Text(_selectedTime == null
                  ? "Choose Time"
                  : "Time: ${_selectedTime!.format(context)}"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _bookAppointment(doctor?['name'] ?? "Unknown"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text("Confirm Appointment"),
            ),
          ],
        ),
      ),
    );
  }
}
