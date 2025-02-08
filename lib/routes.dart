// loggedOut
//loggedIn
import 'package:flutter/material.dart';
import 'package:redit_clone/views/auth/screens/login_screen.dart';
import 'package:redit_clone/views/community/screens/create_community_screen.dart';
import 'package:redit_clone/views/home/home_screenn.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (info) => MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (info) => MaterialPage(child: HomeScreen()),
  '/create-community': (info) => MaterialPage(child: CreateCommunityScreen()),
});
