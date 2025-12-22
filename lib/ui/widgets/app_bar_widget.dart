import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/providers/user_provider.dart';
import 'package:task_managment_app/ui/controllers/auth_controller.dart';
import 'package:task_managment_app/ui/screens/sign_in_screen.dart';
import 'package:task_managment_app/ui/screens/update_profile_screen.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)!.settings.name;
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: ColorScheme.of(context).primary,
      title: GestureDetector(
        onTap: () {
          if (currentRoute == UpdateProfileScreen.name) return;
          Navigator.pushNamed(context, UpdateProfileScreen.name);
        },
        child: Consumer<UserProvider>(
          builder: (context, UserProvider provider, child) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        (provider.user?.photo != null &&
                            provider.user!.photo!.isNotEmpty)
                        ? MemoryImage(base64Decode(provider.user!.photo!))
                        : null,
                    child:
                        (provider.user?.photo == null ||
                            provider.user!.photo!.isEmpty)
                        ? const Icon(Icons.person, size: 20)
                        : null,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${provider.user?.firstName ?? ""} ${provider.user?.lastName ?? ""}",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                      Text(
                        provider.user?.email ?? "",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        Consumer<UserProvider>(
          builder: (context, UserProvider provider, child) {
            return IconButton(
              onPressed: () async {
                await provider.clearUserData();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.name,
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout_outlined),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
