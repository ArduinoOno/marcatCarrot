import 'package:dev_test/page/detail.dart';
import 'package:dev_test/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dev_test/util/utility.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 선언 초기화
  List<Map<String, String>> datas = [];
  String currentLocation;
  ContentsReopsitory contentsReopsitory = ContentsReopsitory();
  final Map<String, String> locationTypeStringMap = {
    "ara": "아라동",
    "ora": "오라동",
    "donam": "도암동",
  };

  @override
  void initState() { 
    super.initState();
    currentLocation = "ara";
  }

  Widget _appbarWidget(){
    return AppBar(
        title: GestureDetector(
          onTap: (){ // 짧은 터치
            print("object");
          },
          child: PopupMenuButton<String>(
            offset: Offset(0, 35),
            shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
              1
            ),
            onSelected: (String where) {
              setState(() {
                currentLocation = where;
              });
            },
            itemBuilder: (BuildContext context){
              return [
                PopupMenuItem(value: "ara",child: Text("아라동")),
                PopupMenuItem(value: "ora",child: Text("오라동")),
                PopupMenuItem(value: "donam",child: Text("도남동")),
              ];
            },
            child: Row(
              children: [
                Text(locationTypeStringMap[currentLocation]),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ), // 타이틀
        elevation: 1,
        actions: [
          IconButton( icon: Icon(Icons.search), onPressed: null),
          IconButton( icon: Icon(Icons.tune), onPressed: null),
          IconButton( 
            icon: SvgPicture.asset
            (
              "assets/svg/bell.svg",
              width: 22,
            ), 
            onPressed: null
          ),
        ], // 우측상단
      );
  }

  _loadContents()
  {
    return contentsReopsitory.loadContentsFromLocation(currentLocation);
  }

  _makeDataList(List<Map<String, String>> datas)
  {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index){
        return GestureDetector(
          onTap: () {
            Navigator.push(context, 
                MaterialPageRoute(builder: (BuildContext context){
                  var makeSellData = [];
                  for(int i= 0; i<datas.length; i++)
                  {
                    if(datas[index]['seller_id'] == datas[i]['seller_id'] &&
                      datas[index]['cid'] != datas[i]['cid']) {
                      makeSellData.add(datas[i]);
                    }
                  }
              return DetailContentView(
                data: datas[index],
                sellData: makeSellData,
              );
            }));
            print(datas[index]['title']);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Hero(
                    tag: datas[index]['cid'],
                    child: Image.asset(
                      datas[index]["image"], 
                      width: 100,
                      height: 100,
                    ),
                  )
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]['title'], 
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5,),
                        Text(
                          datas[index]['location'],
                          style: TextStyle(
                            fontSize: 12, 
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          DataUtility.calcStringToWon(datas[index]['price']),
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 5,),
                        Expanded(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SvgPicture.asset("assets/svg/heart_off.svg", width: 13,height: 13,),
                              SizedBox(width: 5,),
                              Text(datas[index]['likes'])
                            ]
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
        );
      }, 
      separatorBuilder: (BuildContext _context, int index){
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      }, 
      itemCount: 10,
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasError) {
          return Center(child: Text("오류 문의 부탁드립니다."),);
        }

        if(snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }

        return Center(child: Text("해당 지역의 데이터가 없습니다."),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),// 여기까지 appbar
      body: _bodyWidget(),
    );
  }
}