import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:admin/utility/extensions.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF012437), Color(0xFF4A934A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
            ),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Dashboard');
            },
          ),
          DrawerListTile(
            title: "Category",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Category');
            },
          ),
          DrawerListTile(
            title: "Sub Category",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('SubCategory');
            },
          ),
          DrawerListTile(
            title: "Brands",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Brands');
            },
          ),
          DrawerListTile(
            title: "Variant Type",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('VariantType');
            },
          ),
          DrawerListTile(
            title: "Variants",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Variants');
            },
          ),
          DrawerListTile(
            title: "Orders",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Order');
            },
          ),
          DrawerListTile(
            title: "Tickets",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Ticket');
            },
          ),
          DrawerListTile(
            title: "Coupons",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Coupon');
            },
          ),
          DrawerListTile(
            title: "Posters",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Poster');
            },
          ),
          DrawerListTile(
            title: "Notifications",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Notifications');
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF012437), Color(0xFF4A934A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}
