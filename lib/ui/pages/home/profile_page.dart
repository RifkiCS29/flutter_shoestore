import 'package:flutter/material.dart';
import 'package:flutter_shoestore/services/auth_service.dart';
import 'package:flutter_shoestore/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();

  String? _name;
  String? _username;
  String? _token;
  String? _profilePhotoUrl;

  @override
  void initState() {
    super.initState();
    _getDataUser();
  }

  _getDataUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      _name = _preferences.getString('name');
      _username = _preferences.getString('username');
      _token = _preferences.getString('token');
      _profilePhotoUrl = _preferences.getString('profile_photo_url');
    });
  }

  @override
  Widget build(BuildContext context) {
    
    _handleSignOut() async {
      await _auth.logout(_token ?? "").then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/sign-in', (route) => false);
      });
    }

    _removeDataUser() async {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
        await _preferences.remove("id");
        await _preferences.remove("token");
        await _preferences.remove("name");
        await _preferences.remove("email");
        await _preferences.remove("username");
        await _preferences.remove("address");
        await _preferences.remove("profile_photo_url");
    }

    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(
              defaultMargin,
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    _profilePhotoUrl ?? "https://titan-autoparts.com/development/wp-content/uploads/2019/09/no.png",
                    width: 64,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hallo, $_name',
                        style: primaryTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: semiBold,
                        ),
                      ),
                      Text(
                        '@$_username',
                        style: subtitleTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleSignOut();
                    _removeDataUser();
                  },
                  child: Image.asset(
                    'assets/button_exit.png',
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget menuItem(String text) {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(fontSize: 13),
            ),
            Icon(
              Icons.chevron_right,
              color: primaryTextColor,
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: backgroundColor3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Account',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                child: menuItem(
                  'Edit Profile',
                ),
              ),
              menuItem(
                'Your Orders',
              ),
              menuItem(
                'Help',
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'General',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
              menuItem(
                'Privacy & Policy',
              ),
              menuItem(
                'Term of Service',
              ),
              menuItem(
                'Rate App',
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
