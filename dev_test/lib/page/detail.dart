import 'package:carousel_slider/carousel_slider.dart';
import 'package:dev_test/components/manor_temperature_widget.dart';
import 'package:dev_test/repository/contents_repository.dart';
import 'package:dev_test/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailContentView extends StatefulWidget {
  Map<String,String> data;
  List<dynamic> sellData;
  ContentsReopsitory contentsReopsitory = ContentsReopsitory();
  DetailContentView({Key key, this.data, this.sellData}) : super(key: key);

  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}


class _DetailContentViewState extends State<DetailContentView> with SingleTickerProviderStateMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size size;
  List<Map<String,String>> imgList;
  int _current;
  double scorllpos = 0;
  bool pressLike = false;
  ScrollController controller = ScrollController();
  AnimationController _animationController;
  Animation _swarpColor;

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(vsync: this);
    _swarpColor = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    //pressLike = false;
    controller.addListener(() {
      setState(() {
        if(controller.offset > 255)
        {
          scorllpos = 255;
        }
        else
        {
          scorllpos = controller.offset;
        }
        _animationController.value = scorllpos/255;
      });
    });
    loadMyLikeItmeStatus();
  }

  loadMyLikeItmeStatus() async {
    bool ck = await widget.contentsReopsitory.ismyLikeItem(widget.data['cid']);
    setState(() {
      pressLike = ck;
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    imgList = [
      {
        "id" : "0", 
        "url" : widget.data["image"]
      },
      {
        "id" : "1", 
        "url" : widget.data["image"]
      },
      {
        "id" : "2", 
        "url" : widget.data["image"]
      },
      {
        "id" : "3", 
        "url" : widget.data["image"]
      },
      {
        "id" : "4", 
        "url" : widget.data["image"]
      },
    ];
  }

  Widget _swarpIcon(IconData icon)
  {
    return AnimatedBuilder(
          animation: _swarpColor,
          builder: (context,child) => Icon(
              icon, 
              color: _swarpColor.value,
            ),
        );
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scorllpos.toInt()),
      elevation: 0,
      leading: IconButton(
        icon: _swarpIcon(Icons.arrow_back),
      onPressed: (){
        Navigator.pop(context);
      }),
      actions: [
        IconButton(
          icon: _swarpIcon(Icons.share), 
          onPressed: (){}
        ),
        IconButton(
          icon: _swarpIcon(Icons.more_vert), 
          onPressed: (){}
        ),
      ],
    );
  }

  Widget _slider() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"],
            child: CarouselSlider(
              options: CarouselOptions(
                height: size.width,
                initialPage: 0,
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
              ),
              items: imgList.map((map) {
                return Image.asset(
                  map['url'],
                  width: size.width,
                  fit: BoxFit.fill,
                );
              },).toList(),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == int.parse(map['id'])
                      ? Colors.white
                      : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sellerInfo() {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
        children: [
          CircleAvatar(
            radius: 25, 
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['seller_name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(widget.data['location'])
            ],
          ),
          Expanded(
              child: ManorTemperature(
              manorTemp: double.parse(widget.data['menor_temp']),
            ),
          )
        ]
      ),
    );
  }

  Widget _line()
  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _cocntentsInfo()
  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20,),
          Text(
            widget.data['title'], // 타이틀
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          SizedBox(height: 15,),
          Text(
            "${widget.data['category']} ${widget.data['time']}", //상품 카테고리 시간
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 15,),
          Text(
            widget.data['detail'], //상품 디테일
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              height: 1.5,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 15,),
          Text(
            "체팅 ${widget.data['chat']} ・ 관심 ${widget.data['like']} ・ 조회 ${widget.data['view']}", // 체팅, 관심, 조회
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }

  Widget _otherSellInfo()
  {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("판매자님의 판매 상품", 
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          Text("모두 보기", 
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(controller: controller, 
    slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _slider(),
              _sellerInfo(),
              _line(),
              _cocntentsInfo(),
              _line(),
              _otherSellInfo(),
            ]
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(List.generate(widget.sellData.length, (index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            widget.sellData[index]["image"], 
                            width: size.width,
                            fit: BoxFit.fill,
                            height: 120,
                          ),
                        ),
                        Text(widget.sellData[index]["title"], style: TextStyle(fontSize: 10),overflow: TextOverflow.ellipsis),
                        Text("금액 ${DataUtility.calcStringToWon(widget.sellData[index]["price"])}", 
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
              ).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget _bottomBarWidget()
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      height: 55,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if(pressLike)
              {
                // 리스트에서 제거
                await widget.contentsReopsitory.removeMyLikeItem(widget.data['cid']);
              }
              else
              {
                // 리스트에 저장
                await widget.contentsReopsitory.addMyLikeItem(widget.data);
              }
              setState(() {
                pressLike = !pressLike;
              });
              scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text(
                    pressLike
                    ? "관심목록에 추가되었습니다."
                    : "관심목록에서 제거되었습니다."
                  )
                )
              );
            },
            child: SvgPicture.asset(
              pressLike
              ? 'assets/svg/heart_on.svg'
              : 'assets/svg/heart_off.svg', 
              width: 25, 
              height: 25, 
              color: Color(0xfff08f4f),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            width: 1,
            height: 40,
            color: Colors.grey.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                DataUtility.calcStringToWon(widget.data['price']),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "가격제안 불가",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange,
                    ),
                    child: Text(
                      "체팅으로 거래하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
              ]
            )
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),// 여기까지 appbar
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}