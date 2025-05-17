import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_shop_admin_panel/consts/assets.dart';
import 'package:go_shop_admin_panel/core/extensions.dart';
import 'package:go_shop_admin_panel/features/dashboard/views/dashboard.dart';
import 'package:go_shop_admin_panel/shared/loader.dart';
import 'package:go_shop_admin_panel/utils/textstyle.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AdminSignIn extends StatefulWidget {
  static const route = '/';
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn(String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // TODO: Implement actual authentication logic
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      setState(() => _isLoading = false);
      if (context.mounted && password == "Password123#") {
        context.replace(Dashboard());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 750;

          if (isMobile) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  width: double.infinity,
                  child: SvgPicture.asset(ImagePaths.logo, fit: BoxFit.cover),
                ),

                _buildSignInForm(constraints),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                flex: 1,
                child: SvgPicture.asset(ImagePaths.logo, fit: BoxFit.cover),
              ),
              Expanded(flex: 1, child: _buildSignInForm(constraints)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSignInForm(BoxConstraints constraints) {
    final formWidth =
        constraints.maxWidth < 750
            ? constraints.maxWidth * 0.9
            : constraints.maxWidth * 0.4;
    return Center(
      child:
          _isLoading
              ? Loader()
              : SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formWidth),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        "Admin Dashboard"
                            .style(fontSize: 30, isBold: true)
                            .centralize(),
                        const SizedBox(height: 48),
                        ShadInputFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          placeholder: Text("Password"),
                          trailing: InkWell(
                            onTap:
                                () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                          decoration: ShadDecoration(
                            border: ShadBorder(
                              padding: EdgeInsets.all(4),
                              radius: BorderRadius.circular(12),
                            ),
                            focusedBorder: ShadBorder(
                              padding: EdgeInsets.all(4),
                              radius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        ShadButton(
                          onPressed:
                              () =>
                                  _isLoading
                                      ? null
                                      : _handleSignIn(
                                        _passwordController.text.trim(),
                                      ),
                          backgroundColor: Colors.blue[900],
                          child:
                              _isLoading
                                  ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : "Sign in".style(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
