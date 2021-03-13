import 'dart:convert';

import 'package:dev_test/repository/local_storage_repository.dart';

class ContentsReopsitory extends LocalStorageRepository {
  final String LIKE_ITEM_KEY = "my_like_item_key";
  
  // 실질적인 프로젝트면 웹서버에서 오브젝트 리스트건 뭐건 값을줌 그걸 사용해야함
  // 주로 json 형식을 선호함(웹서버는 거의 99% json형식의 통신을 하기때문)
  Map<String, dynamic> data = {
    "ara" : [
      {
        "cid": "1",
        "image": "assets/images/ara-1.jpg",
        "title": "네메시스 축구화275",
        "category": "디지털/가전",
        "time": "22시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "2",
        "area": "ara",
        "chat": "10",
        "like": "20", 
        "view": "500",
        "seller_id": "1",
        "seller_name": "시민1",
        "menor_temp": "36.0"
      },
      {
        "cid": "2",
        "image": "assets/images/ara-2.jpg",
        "title": "LA갈비 5kg팔아요~",
        "category": "식료품",
        "time": "15시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "100000",
        "likes": "5",
        "area": "ara",
        "chat": "10",
        "like": "50", 
        "view": "100",
        "seller_id": "1",
        "seller_name": "시민1",
        "menor_temp": "45.0"
      },
      {
        "cid": "3",
        "image": "assets/images/ara-3.jpg",
        "title": "치약팝니다",
        "category": "생필품",
        "time": "10분전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "5000",
        "likes": "0",
        "area": "ara",
        "chat": "20",
        "like": "50", 
        "view": "100",
        "seller_id": "1",
        "seller_name": "시민1",
        "menor_temp": "50.0"
      },
      {
        "cid": "4",
        "image": "assets/images/ara-4.jpg",
        "title": "[풀박스]맥북프로16인치 색상 스페이스 그레이",
        "category": "디지털/가전",
        "time": "1시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "2500000",
        "likes": "6",
        "area": "ara",
        "chat": "10",
        "like": "50", 
        "view": "100",
        "seller_id": "2",
        "seller_name": "시민2",
        "menor_temp": "20.0"
      },
      {
        "cid": "5",
        "image": "assets/images/ara-5.jpg",
        "title": "디월트존기임팩",
        "category": "디지털/가전",
        "time": "2시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "150000",
        "likes": "2",
        "area": "ara",
        "chat": "20",
        "like": "50", 
        "view": "100",
        "seller_id": "2",
        "seller_name": "시민2",
        "menor_temp": "15.0"
      },
      {
        "cid": "6",
        "image": "assets/images/ara-6.jpg",
        "title": "갤럭시s10",
        "category": "디지털/가전",
        "time": "5시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "180000",
        "likes": "2",
        "area": "ara",
        "chat": "20",
        "like": "50", 
        "view": "110",
        "seller_id": "2",
        "seller_name": "시민2",
        "menor_temp": "100.0"
      },
      {
        "cid": "7",
        "image": "assets/images/ara-7.jpg",
        "title": "선반",
        "category": "가구",
        "time": "4시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "15000",
        "likes": "2",
        "area": "ara",
        "chat": "21",
        "like": "60", 
        "view": "120",
        "seller_id": "2",
        "seller_name": "시민2",
        "menor_temp": "38.0"
      },
      {
        "cid": "8",
        "image": "assets/images/ara-8.jpg",
        "title": "냉장 쇼케이스",
        "category": "디지털/가전",
        "time": "2시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "80000",
        "likes": "3",
        "area": "ara",
        "chat": "21",
        "like": "0", 
        "view": "120",
        "seller_id": "3",
        "seller_name": "시민3",
        "menor_temp": "39.0"
      },
      {
        "cid": "9",
        "image": "assets/images/ara-9.jpg",
        "title": "대우 미니냉장고",
        "category": "디지털/가전",
        "time": "12시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "30000",
        "likes": "3",
        "area": "ara",
        "chat": "20",
        "like": "10", 
        "view": "120",
        "seller_id": "3",
        "seller_name": "시민3",
        "menor_temp": "34.0"
      },
      {
        "cid": "10",
        "image": "assets/images/ara-10.jpg",
        "title": "멜킨스 풀업 턱걸이 판매합니다.",
        "category": "생활/건강",
        "time": "1시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 아라동",
        "price": "50000",
        "likes": "7",
        "area": "ara",
        "chat": "25",
        "like": "0", 
        "view": "120",
        "seller_id": "3",
        "seller_name": "시민3",
        "menor_temp": "45.0"
      },
    ],
    "ora" : [
      {
        "cid": "11",
        "image": "assets/images/ora-1.jpg",
        "title": "LG 통돌이세탁기 15kg(내부",
        "category": "디지털/가전",
        "time": "12시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "150000",
        "likes": "13",
        "area": "ora",
        "chat": "20",
        "like": "51", 
        "view": "120",
        "seller_id": "4",
        "seller_name": "시민4",
        "menor_temp": "49.0"
      },
      {
        "cid": "12",
        "image": "assets/images/ora-2.jpg",
        "title": "3단책장 전면책장 가져가실분",
        "category": "가구",
        "time": "5분전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "무료나눔",
        "likes": "6",
        "area": "ora",
        "chat": "2",
        "like": "50", 
        "view": "110",
        "seller_id": "4",
        "seller_name": "시민4",
        "menor_temp": "60.0"
      },
      {
        "cid": "13",
        "image": "assets/images/ora-3.jpg",
        "title": "브리츠 컴퓨터용 스피커",
        "category": "디지털/가전",
        "time": "1시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "1000",
        "likes": "4",
        "area": "ora",
        "chat": "1",
        "like": "50", 
        "view": "120",
        "seller_id": "4",
        "seller_name": "시민4",
        "menor_temp": "25.0"
      },
      {
        "cid": "14",
        "image": "assets/images/ora-4.jpg",
        "title": "안락 의자",
        "category": "가구",
        "time": "5분전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "10000",
        "likes": "1",
        "area": "ora",
        "chat": "12",
        "like": "51", 
        "view": "120",
        "seller_id": "5",
        "seller_name": "시민5",
        "menor_temp": "37.5"
      },
      {
        "cid": "15",
        "image": "assets/images/ora-5.jpg",
        "title": "어린이책 무료드림",
        "category": "도서",
        "time": "방금",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "무료나눔",
        "likes": "1",
        "area": "ora",
        "chat": "11",
        "like": "5", 
        "view": "120",
        "seller_id": "5",
        "seller_name": "시민5",
        "menor_temp": "39.5"
      },
      {
        "cid": "16",
        "image": "assets/images/ora-6.jpg",
        "title": "어린이책 무료드림",
        "category": "도서",
        "time": "방금",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "무료나눔",
        "likes": "0",
        "area": "ora",
        "chat": "10",
        "like": "1", 
        "view": "100",
        "seller_id": "5",
        "seller_name": "시민5",
        "menor_temp": "40.5"
      },
      {
        "cid": "17",
        "image": "assets/images/ora-7.jpg",
        "title": "칼세트 재제품 팝니다",
        "category": "주방용품",
        "time": "1시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "20000",
        "likes": "5",
        "area": "ora",
        "chat": "20",
        "like": "14", 
        "view": "100",
        "seller_id": "5",
        "seller_name": "시민5",
        "menor_temp": "45.5"
      },
      {
        "cid": "18",
        "image": "assets/images/ora-8.jpg",
        "title": "아이팜장난감정리함팔아요",
        "category": "완구",
        "time": "24시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "30000",
        "likes": "29",
        "area": "ora",
        "chat": "2",
        "like": "1", 
        "view": "12",
        "seller_id": "6",
        "seller_name": "시민6",
        "menor_temp": "22.5"
      },
      {
        "cid": "19",
        "image": "assets/images/ora-9.jpg",
        "title": "한색책상책장수납장세트 팝니다.",
        "category": "가구",
        "time": "24시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "1500000",
        "likes": "1",
        "area": "ora",
        "chat": "15",
        "like": "10", 
        "view": "152",
        "seller_id": "6",
        "seller_name": "시민6",
        "menor_temp": "80.5"
      },
      {
        "cid": "20",
        "image": "assets/images/ora-10.jpg",
        "title": "순성 데일리 오가닉 카시트",
        "category": "가구",
        "time": "14시간전",
        "detail": "상품 소개 셈플내용 입니다. 야근하면서 이거 만드느라 힘들어요 ㅠㅠ",
        "location": "제주 제주시 오라동",
        "price": "60000",
        "likes": "8",
        "area": "ora",
        "chat": "1",
        "like": "20", 
        "view": "150",
        "seller_id": "6",
        "seller_name": "시민6",
        "menor_temp": "60.5"
      },
    ]
  };

  Map<String, dynamic> retAllData()
  {
    return data;
  }
  Future<List> retLikeItem()
  async {
    String getMyLikeData = await this.getStorageData(LIKE_ITEM_KEY);
    if(getMyLikeData != null)
    {
      List<dynamic> dataList = jsonDecode(getMyLikeData);
      return dataList;
    }
    else
    {
      return null;
    }
  }

  void setLikeItem(List likeItem)
  {
    this.setStorageData(LIKE_ITEM_KEY, jsonEncode(likeItem));
  }

  // 나의 찜목록 저장
  addMyLikeItem(Map<String,String> data)
  async {
    List<dynamic> dataList = await retLikeItem();
    if(dataList == null || !(dataList is List))
    {
      dataList = [data];
    }
    else
    {
      dataList.add(data);
    }
    // json인코딩후 저장
    setLikeItem(dataList);
  }

  // 나의 찜목록 체크
  ismyLikeItem(String cid)
  async {
    bool chekcItemFlag = false;
    List<dynamic> decodeData = await retLikeItem();
    if(decodeData == null || !(decodeData is List))
    {
      return false;
    }
    else
    {
      for(dynamic data in decodeData)
      {
        if(cid == data['cid'])
        {
          chekcItemFlag = true;
          break;
        }
      }
    }
    return chekcItemFlag;
  }

  removeMyLikeItem(String cid)
  async {
    List<dynamic> decodeData = await retLikeItem();
    if(decodeData != null || (decodeData is List))
    {
      decodeData.removeWhere((data) => data['cid'] == cid);
    }
    setLikeItem(decodeData);
  }

  // Api 통신 부분이지만 다른걸로 대채
  // web API 만들 시간이 없어서;;
  Future<List<Map<String, String>>> loadContentsFromLocation(String location)
  async {  
    await Future.delayed(Duration(microseconds: 1000));
    return data[location];
  }
}