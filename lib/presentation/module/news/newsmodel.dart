class Newsmodel {
  Newsmodel({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
  });

  String imagePath;
  String titleTxt;
  String subTxt;

  static List<Newsmodel> newslist = <Newsmodel>[
    Newsmodel(
      imagePath: 'assets/images/community1.png',
      titleTxt: 'SAS RE  Celebrate The Sprit..',
      subTxt:
          'The flag hosting ceramony took place in the presence of His Existing Hesham AI Qa',
    ),
    Newsmodel(
      imagePath: 'assets/images/community2.png',
      titleTxt: 'SAS highlight the latest ...',
      subTxt:
          'Dubai,UAE, 14 October 2023,The 25th Water,Energy,Technology and Environment.',
    ),
    Newsmodel(
      imagePath: 'assets/images/community3.png',
      titleTxt: 'Dubai Lootah sets new Guilfing..',
      subTxt:
          'Situated 157m above the ground.Sky Track is a 335m rooftop running track locate....',
    ),
    Newsmodel(
      imagePath: 'assets/images/community4.png',
      titleTxt: 'Wasl Residency',
      subTxt: 'Wembley, London',
    ),
  ];
}
