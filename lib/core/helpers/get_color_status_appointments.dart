import 'package:flutter/animation.dart';

enum ColorAppointments {
  Ongoing,
  StartingSoon,
  Pending,
  Rescheduled,
  Confirmed,
  Concluded,
  Canceled,
}

Color getColorStatusAppointments(ColorAppointments status) {
  Color color = Color(0xFFFFFFFF);
  switch (status) {
    case ColorAppointments.Ongoing:
      color = Color(0xff28A745);
    case ColorAppointments.StartingSoon:
      color = Color(0xffFD7E14);

    case ColorAppointments.Pending:
      color = Color(0xffFFA756);

    case ColorAppointments.Rescheduled:
      color = Color(0xff53CCF3);

    case ColorAppointments.Confirmed:
      color = Color(0xff00B69B);
      case ColorAppointments.Concluded:
      color = Color(0xff00B69B);
      case ColorAppointments.Canceled:
      color = Color(0xffEF3826);
    default:
      color = Color(0xffFFFFFF);
  }
  return color;
}
