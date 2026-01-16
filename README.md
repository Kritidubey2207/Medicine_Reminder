🩺 Medicine Reminder App

A Flutter-based mobile application designed to help users manage their daily medicines efficiently by scheduling reminders and receiving notifications at the correct time. 
The app focuses on simplicity, reliability, and offline functionality, making it suitable for everyday use.

📱 Project Overview

The Medicine Reminder App allows users to add medicines with details such as name, dosage, and scheduled time. The app stores all data locally and triggers reminders at the specified time, 
helping users maintain consistency in their medication routine.

The application is built using Flutter and follows a clean UI design with Teal as the primary color and Orange for actions, as per the given design constraints.


✨ Features

✅ Add Medicine

-Enter medicine name and dosage

-Select time using a time picker

-Prevents saving empty or invalid entries

⏰ Reminder Notifications

Schedules notifications at the selected time

Uses exact alarms to ensure accuracy

🗂 Medicine List

Displays all added medicines on the home screen

Automatically sorted by time

Updates instantly when a new medicine is added

🗑 Delete Medicine

Swipe to delete unwanted medicines

Cancels the scheduled notification when deleted

🚑 Emergency Call Support

One-tap ambulance call feature

Uses device dialer for quick access during emergencies

💾 Offline Storage

Uses Hive for local data storage

No internet or backend required

🛠 Tech Stack

Flutter – UI development

Dart – Programming language

Hive – Lightweight local database

flutter_local_notifications – Notification scheduling

url_launcher – Emergency phone calls

🎨 Design Guidelines

Primary Color: Teal

Accent / Button Color: Orange

Clean and minimal UI for ease of use

Responsive layout across different screen sizes

🔐 Permissions Used

POST_NOTIFICATIONS – To show medicine reminders

SCHEDULE_EXACT_ALARM – To ensure timely alerts

CALL_PHONE / tel intent – For emergency calling

🧪 How It Works (Flow)

User adds a medicine with time and dosage

Data is stored locally using Hive

A notification is scheduled for the selected time

At the scheduled time:

Notification is triggered

(Foreground testing uses dialog confirmation)

User can delete medicines anytime, which also cancels the reminder

🚀 Future Enhancements

Edit medicine details

Multiple reminders per medicine

Snooze option for notifications

Daily/weekly medicine tracking

Cloud backup support

📦 Installation & Setup
flutter pub get
flutter run


Ensure notifications are enabled and battery optimization is disabled for best results.

📄 Conclusion

The Medicine Reminder App is a practical and user-friendly solution for managing daily medication schedules. By combining local storage, scheduled notifications,
and a clean UI, the app ensures reliability without relying on internet connectivity. 
This project demonstrates effective use of Flutter, state management, local databases, and platform-specific features.

Works even when the app is in the background
