import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimationController secondAnimationController;
  late int second = 16500, savings = 3200, budget2 = 1200, today = 800;

  @override
  void initState() {
    _setupAnimations();
    super.initState();
  }

  Animation _getAnimation(AnimationController parent) {
    return Tween<double>(begin: 0, end: 60).animate(parent);
  }

  void _setupAnimations() {
    secondAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 55));
    final hourAnim = _getAnimation(secondAnimationController);
    hourAnim.addListener(() {
      setState(() {
        second = second + 10000;
        savings = savings + 500;
        budget2 = budget2 + 100;
        today = today + 100;
      });
    });

    secondAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
                      children: [
                        MBudget(
                          type: "Monthly Budget",
                          amount: budget2,
                        ),
                        Spacer(),
                        MBudget(
                          type: "Your Savings",
                          amount: savings,
                        )
                      ],
                    ),
                    Spacer(),
                    TBalance(
                      budget: second,
                    )
                  ]),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 40,
                left: MediaQuery.of(context).size.width / 2 + 50,
                child: Container(
                  height: MediaQuery.of(context).size.height / 11,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Today",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("+ € $today",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                        ]),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 150,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          color: Colors.pink,
                          size: 44.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "Entertainment Budget is Running Out \n\n",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'You can increase your budget',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}

class TBalance extends StatelessWidget {
  const TBalance({
    Key? key,
    this.budget,
  }) : super(key: key);

  final int? budget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Balance",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "€ ",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '$budget',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MBudget extends StatelessWidget {
  const MBudget({
    Key? key,
    this.type,
    this.amount,
  }) : super(key: key);
  final String? type;
  final int? amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 150,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(type!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
            Text("+ € $amount",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
