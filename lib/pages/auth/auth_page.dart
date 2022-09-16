import 'package:flutter/material.dart';

/// Responsive
import '../../utils/responsive.dart';

/// Widgets
import 'widgets/auth_footer_content.dart';
import 'widgets/auth_form.dart';
import 'widgets/helios_logo.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: Responsive.isMobile(context) ? 20 : 40,
                left: Responsive.isMobile(context) ? 10 : 20,
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                ),
              ),
            ),
            const HeliosLogo(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AuthForm(),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 10 : 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 10 : 20,
                    ),
                    const AuthFooterContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
