// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_local_apii/controllers/bottom_nav_controller.dart';
import 'package:latihan_local_apii/views/detail_page.dart';
import 'package:latihan_local_apii/views/homePage.dart';
import 'package:latihan_local_apii/views/watch_list_page.dart';

class BottomNavigation extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: SafeArea(
                child: Column(
                  // Wrap with Column
                  children: [
                    // IndexedStack(
                    //   index: bottomNavController.tabIndex,
                    //   children: [
                    //     HomePage(),
                    //     MyWatchList(),
                    //     DetailPage(),
                    //   ],
                    // ),
                    // // Fix: Moved BottomNavigationBar outside the SafeArea
                    BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      items: [
                        BottomNavigationBarItem(
                          icon: IconButton(
                            onPressed: () {
                              Get.off(() => HomePage());
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                            ),
                          ),
                          label: "cart",
                        ),
                        // BottomNavigationBarItem(
                        //   icon: Icon(
                        //     Icons.home,
                        //     color: Colors.white,
                        //   ),
                        //   label: '',
                        // ),
                        // BottomNavigationBarItem(
                        //   icon: Icon(
                        //     Icons.local_movies_rounded,
                        //     color: Colors.white,
                        //   ),
                        //   label: '',
                        // ),
                        // BottomNavigationBarItem(
                        //   icon: Icon(
                        //     Icons.person,
                        //     color: Colors.white,
                        //   ),
                        //   label: '',
                        // ),
                      ],
                      selectedItemColor: Theme.of(context).focusColor,
                      unselectedItemColor: Colors.grey,
                      onTap: bottomNavController.changeTabIndex,
                      currentIndex: bottomNavController.tabIndex,
                      showUnselectedLabels: false,
                      showSelectedLabels: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
