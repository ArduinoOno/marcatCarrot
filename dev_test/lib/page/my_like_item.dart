import 'dart:ui';

import 'package:dev_test/repository/contents_repository.dart';
import 'package:dev_test/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'detail.dart';

class MyLikeItme extends StatefulWidget {
  MyLikeItme({Key key}) : super(key: key);
  @override
  _MyLikeItmeState createState() => _MyLikeItmeState();
}



class _MyLikeItmeState extends State<MyLikeItme> {
  ContentsReopsitory contentsReopsitory;
  @override
  void initState() { 
    super.initState();
    contentsReopsitory = ContentsReopsitory();
  }

  Future<List<dynamic>> _loadMyLikeContents()
  async {
    return await contentsReopsitory.retLikeItem();
  }

  Widget appBarWidget() 
  {
    return AppBar(
      title: Text(
        "관심목록", 
        style: TextStyle(
          fontSize: 15,
      ),),
    );
  }

  // arrayMerge기능을 찾지못한건가? 걍 만들었음
  arrayMerge(List<dynamic> data_f, List<dynamic> data_s)
  {
    List<dynamic> mergeData = [];

    // 1번 배열 작성
    for(int i = 0; i<data_f.length; i++)
    {
      mergeData.add(data_f[i]);
    }

    // 2번 배열 작성
    for(int j =0; j<data_s.length; j++)
    {
      mergeData.add(data_s[j]);
    }

    return mergeData;
  }

  _makeDataList(List<dynamic> datas)
  {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext _context, int index){
        return GestureDetector(
          onTap: () {
            Navigator.push(context, 
                MaterialPageRoute(builder: (BuildContext context){
                  List<dynamic> sellerData = [];
                  Map<String,dynamic> makeSellData;
                  makeSellData = contentsReopsitory.data;
                  List<dynamic> araData = new List<dynamic>.from(makeSellData['ara']);
                  List<dynamic> oraData = new List<dynamic>.from(makeSellData['ora']);
                  List<dynamic> allData = arrayMerge(araData, oraData);

                  for(int i= 0; i<allData.length; i++)
                  {
                    if(datas[index]['seller_id'] == allData[i]['seller_id'] &&
                      datas[index]['cid'] != allData[i]['cid']) {
                      sellerData.add(allData[i]);
                    }
                  }
                  Map<String,String> retData = new Map<String,String>.from(datas[index]);
              return DetailContentView(
                data: retData,
                sellData: sellerData,
              );
            }));
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
      itemCount: datas.length,
    );
  }

  Widget bodyWidget() {
    return FutureBuilder(
      future: _loadMyLikeContents(),
      builder: (context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.hasError) {
          return Center(child: Text("오류 문의 부탁드립니다."),);
        }

        if(snapshot.hasData) {
          if(snapshot.data.length < 1)
          {
            return Center(child: Text("관심 목록이 비었습니다."),);
          }
          else
          {
            return _makeDataList(snapshot.data);
          }
        }

        return Center(child: Text("해당 지역의 데이터가 없습니다."),);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: appBarWidget(),
       body: bodyWidget(),
    );
  }
}