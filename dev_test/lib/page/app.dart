import 'package:dev_test/page/home.dart';
// import 'package:dev_test/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'my_like_item.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  List<Map<String, String>> datas = [];

  int _currentPageIndex;

  @override
  void initState() { 
    super.initState();
    _currentPageIndex = 0;
  }

  retFixInfo()
  {
    return Center(child: Text("공사중 입니다."),);
  }

  Widget _bodyWidget() {
    switch (_currentPageIndex) {
      case 0:
        return Home();
        break;
      case 1:
        return retFixInfo();
        break;
      case 2:
        return retFixInfo();
        break;
      case 3:
        return retFixInfo();
        break;
      case 4:
        return MyLikeItme();   
        break;
      default:
      return retFixInfo();
    }
  }

  BottomNavigationBarItem _bottomNavigationBarItem(String _pass, String _labal)
  {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset("assets/svg/${_pass}_off.svg", width: 22),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset("assets/svg/${_pass}_on.svg", width: 22),
      ),
      label: _labal,
    );
  }

  Widget _bottomNavigationBarWidget()
  {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        print(index);
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedFontSize: 12,
      currentIndex: _currentPageIndex,
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
      items: [
        _bottomNavigationBarItem("home","홈"),
        _bottomNavigationBarItem("notes","동네생활"),
        _bottomNavigationBarItem("location","내근처"),
        _bottomNavigationBarItem("chat","채팅"),
        _bottomNavigationBarItem("user","나의 당근"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}