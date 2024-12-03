import '../../app/features/navbar/screens/chat_screen.dart';
import '../../app/features/navbar/screens/project_progress_screen.dart';
import '../../app/features/navbar/screens/support_screen.dart';
import '/core/helpers/get_color_status_appointments.dart';
import '/core/routing/routes.dart';
import '/core/utils/assets_manager.dart';
import '/core/utils/string_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConstValueManager {
  /// Design Size
  static const double widthSize = 393.0;
  static const double heightSize = 852.0;

  static const int animationDuration = 600;

  /// Duration Delayed Second
  static const int delayedSplash = 3;

  static const String geminiApi = "AIzaSyCDePmxP17rWSPSa_o-420-53dpMxYyZa8";

  /// Button Size
  static const double heightButtonSize = 56;

  /// Length  Appointments TabBar
  static const int lengthAppointmentsTabBar = 3;

  /// Locale Language Code

  static const String arLanguageCode = 'ar';
  static const String enLanguageCode = 'en';

  static const Map aboutUsMapText = {
    "text":
        "Car Consultant is your go-to solution for all car-related needs. We connect car owners with automotive consultants to diagnose vehicle issues and schedule appointments with trusted service providers for repairs and maintenance. Our platform offers expert advice and easy booking, ensuring a seamless, transparent, and reliable car care experience. We're here to simplify car ownership and keep your vehicle running smoothly."
  };

  static const Map refundAndCancellationPolicy = {
    "text": """
  <li><strong>Cancellations</strong>
  <ul>
  <li>Users may cancel an appointment or service booking at least 24 hours before the scheduled time to avoid any charges.</li>
  <li>Cancellations made within 24 hours of the scheduled appointment may not be eligible for a refund.</li>
  </ul>
  </li>
  <li><strong>Refunds</strong>
  <ul>
  <li>If a service is canceled in compliance with the cancellation policy (i.e., at least 24 hours prior), a full refund will be issued.</li>
  <li>Refunds for completed services are only granted if there is a service-related issue, such as non-performance or significant failure in the service provided.</li>
  <li>To request a refund, users must submit a refund request through the app's customer support section within 7 days of the appointment or service completion.</li>
  </ul>
  </li>
  <li><strong>Processing Time</strong>
  <ul>
  <li>Approved refunds will be processed within 5-7 business days and credited back to the original payment method used.</li>
  </ul>
  </li>
  <li><strong>Non-Refundable Services</strong>
  <ul>
  <li>Payments for freelance consultant advice or emergency services rendered are non-refundable once the service has been provided.</li>
  </ul>
  </li>
  <li><strong>Disputes</strong>
  <ul>
  <li>If a user disputes a charge, they must contact customer support through the app. All disputes will be investigated, and decisions will be made on a case-by-case basis.</li>
  </ul>
  </li>
  
    """
  };

  static const Map termsAndConditions = {
    "text": """
<ol>
  <li>
    <strong>Introduction</strong>
    <p>Welcome to Car Consultant, a mobile application designed to streamline the car repair and maintenance process for vehicle owners. These Terms and Conditions govern your access and use of the Car Consultant app, including the services provided, such as automotive consultancy, appointment scheduling, access to service providers, and educational resources. By downloading, accessing, or using the app, you agree to these Terms.</p>
  </li>
  <li>
    <strong>User Eligibility</strong>
    <p>To use Car Consultant, you must:</p>
    <ul>
      <li>Be at least 18 years of age or the legal age in your jurisdiction.</li>
      <li>Register an account providing accurate and current information.</li>
      <li>Agree to comply with all applicable laws and these Terms.</li>
    </ul>
  </li>
  <li>
    <strong>User Accounts and Responsibilities</strong>
    <p>Upon registering an account, you agree to:</p>
    <ul>
      <li>Keep your login credentials confidential and secure.</li>
      <li>Provide accurate, current, and complete information during registration and maintain its accuracy during your use of the app.</li>
      <li>Notify us immediately if you suspect any unauthorized use of your account.</li>
    </ul>
    <p><span style="color:red;">Car Consultant reserves the right to suspend or terminate your account if we suspect any breach of these terms or misuse of the platform.</span></p>
  </li>
  <li>
    <strong>Services Offered</strong>
    <p>Car Consultant offers various services including:</p>
    <ul>
      <li>Consultant Service: Access to certified automotive consultants for advice and guidance.</li>
      <li>Appointment Scheduling: Booking appointments with service providers or arranging home inspections.</li>
      <li>Nearby Service Providers: Listings of nearby automotive service providers.</li>
      <li>Freelance Opportunities: Opportunities for certified consultants to offer freelance services.</li>
      <li>Educational Resources: Access to articles, tutorials, and videos to improve your automotive knowledge.</li>
    </ul>
    <p>By using these services, you agree to:</p>
    <ul>
      <li>Use the services in accordance with applicable laws.</li>
      <li>Pay any applicable fees for services you book through the app.</li>
      <li>Provide honest and accurate feedback when reviewing consultants or service providers.</li>
    </ul>
  </li>
  <li>
    <strong>Payments</strong>
    <p>Car Consultant facilitates secure payment processing through third-party gateways. By making a payment, you agree to the following:</p>
    <ul>
      <li>All fees associated with services must be paid in full as indicated in the app.</li>
      <li>Refunds and cancellations are subject to our refund policy, available <a href="#">here</a>.</li>
      <li>We do not assume liability for any issues related to third-party payment processors.</li>
    </ul>
  </li>
  <li>
    <strong>User Content and Feedback</strong>
    <p>By submitting content such as reviews or ratings, you grant Car Consultant a non-exclusive, worldwide, royalty-free, and transferable license to use, modify, and display this content within the app. We reserve the right to moderate or remove any inappropriate content at our discretion.</p>
  </li>
  <li>
    <strong>Liability and Disclaimer</strong>
    <p>Car Consultant does not provide automotive repair services directly. All services are provided by third-party service providers and consultants. We are not responsible for the quality of services provided or any disputes arising between users and service providers. You use the services at your own risk.</p>
  </li>
  <li>
    <strong>Termination of Use</strong>
    <p>Car Consultant reserves the right to terminate or suspend your access to the app at any time, without notice, for conduct that violates these Terms or is harmful to other users of the app or third parties.</p>
  </li>
  <li>
    <strong>Changes to the Terms</strong>
    <p>We may modify these Terms at any time, and we will provide notice of material changes via email or within the app. Continued use of the app after the changes become effective indicates your acceptance of the new terms.</p>
  </li>
  <li>
    <strong>Governing Law</strong>
    <p>These Terms and Conditions are governed by and construed in accordance with the laws of the Kingdom of Saudi Arabia. Any disputes arising from or related to these Terms, the use of the Car Consultant application, or any services provided will be subject to the exclusive jurisdiction of the courts of Saudi Arabia.</p>
  </li>
</ol>

    """
  };

  static const Map privacyPolicy = {
    "text": """
     <h2>Introduction</h2>
    <p>Car Consultant values your privacy and is committed to protecting your personal information. This Privacy Policy outlines how we collect, use, and safeguard your data when you use the Car Consultant app.</p>
    
    <h2>Information We Collect</h2>
    <p><strong>Personal Information:</strong> We may collect personal data when you register, such as your name, phone number, email address, and payment details.</p>
    <p><strong>Non-Personal Information:</strong> We may also collect non-personal data, such as device type, operating system, usage patterns, and location data (if permitted).</p>
    
    <h2>How We Use Your Information</h2>
    <p>We use your information to:</p>
    <ul>
        <li>Provide, maintain, and improve the services of the Car Consultant app.</li>
        <li>Facilitate payments for services booked through the app.</li>
        <li>Communicate with you regarding updates, promotions, or important notices.</li>
        <li>Personalize your experience by offering relevant content and service recommendations.</li>
    </ul>
    
    <h2>Information Sharing and Disclosure</h2>
    <p>We may share your data with:</p>
    <ul>
        <li><strong>Third-party Service Providers:</strong> To facilitate payment processing, scheduling, and other essential services (e.g., consultants and repair shops).</li>
        <li><strong>Legal Compliance:</strong> If required by law or to protect our rights.</li>
        <li><strong>Business Transfers:</strong> In the event of a merger, acquisition, or sale of assets, your data may be transferred as part of that transaction.</li>
    </ul>
    
    <h2>Data Security</h2>
    <p>We take your data security seriously and implement appropriate measures such as:</p>
    <ul>
        <li>Data encryption for all sensitive information during transactions.</li>
        <li>Regular security audits to ensure the integrity of our systems.</li>
    </ul>
    <p>However, no method of transmission or storage is completely secure, and we cannot guarantee absolute security.</p>
    
    <h2>User Rights</h2>
    <p>As a user, you have the right to:</p>
    <ul>
        <li><strong>Access:</strong> Request access to the personal information we hold about you.</li>
        <li><strong>Correction:</strong> Request that we correct any inaccuracies in your personal data.</li>
        <li><strong>Deletion:</strong> Request that we delete your account and personal information.</li>
        <li><strong>Opt-out:</strong> Opt-out of receiving promotional communications at any time.</li>
    </ul>
    
    <h2>Data Retention</h2>
    <p>We retain your personal information for as long as your account is active or as needed to provide you with services. Once you request deletion, we will remove your data in accordance with legal obligations and our data retention policy.</p>
    
    <h2>Cookies and Tracking Technologies</h2>
    <p>We use cookies and similar tracking technologies to enhance user experience, collect usage data, and deliver personalized content. You can adjust your device settings to manage or block cookies, but this may affect the app's functionality.</p>
    
    <h2>Children’s Privacy</h2>
    <p>Our app is not intended for use by individuals under the age of 18. We do not knowingly collect personal information from minors. If you believe a child has provided us with personal data, please contact us, and we will take appropriate action.</p>
    
    <h2>Changes to this Privacy Policy</h2>
    <p>We may update this Privacy Policy periodically. We will notify users of any significant changes through the app or via email. Your continued use of the app after such changes indicates acceptance of the updated policy.</p>
    
    <h2>Contact Information</h2>
    <p>If you have any questions or concerns regarding this Privacy Policy, please contact us at:</p>
    <ul>
        <li>Email: <a href="mailto:support@carconsultant.app">support@carconsultant.app</a></li>
    </ul>
    """
  };
  static List<NavbarItem> navBarList = [
    NavbarItem(
        route: SupportScreen(), icon: AssetsManager.supportIcon, label: 'Support'),
    NavbarItem(route: ProjectProgressScreen(), icon: AssetsManager.projectProgressIcon, label: 'T-Support'),
    NavbarItem(route: ChatScreen(), icon: AssetsManager.chatIcon, label: 'Chat'),
  ];

  static List<ConditionPasswordItem> conditionPasswordList = [
    ConditionPasswordItem(text: StringManager.condition1Text),
    ConditionPasswordItem(text: StringManager.condition2Text),
    ConditionPasswordItem(text: StringManager.condition3Text),
    ConditionPasswordItem(text: StringManager.condition4Text),
  ];
}

class ConditionPasswordItem {
  final String text;
  bool isValidate;

  ConditionPasswordItem({required this.text, this.isValidate = false});
}

class NavbarItem {
  final Widget route;
  final String label;
  final String icon;

  NavbarItem({required this.route, required this.icon, required this.label});
}
