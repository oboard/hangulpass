import 'dart:math';
import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

List<Dismissible> items = new List<Dismissible>();

/// 创建EventBus
EventBus eventBus = EventBus();

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HangulPass',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future loadList(int listIndex) async {
    String description='';
    String descriptions = '''
ㅏ：嘴自然张开，舌头接触下齿龈，但不要贴上，嘴唇不要紧张，也不要成圆形。发音与汉语拼音的“a”相似，但比“a”稍靠后。
ㅐ：嘴张的比“ㅏ”要小一些，嘴唇向两边拉紧一点，舌尖顶住下齿，舌面抬起靠近硬腭，这时舌面左右两边夹在上下齿之间，舌面与硬腭形成扁的椭圆形。
ㅓ：口形比“ㅏ”小一些，舌后部稍微抬起，嘴唇不要紧张，也不要成圆形。
ㅔ：口形比“ㅐ”要小一些，嘴唇两边放松，舌尖顶住下齿，这时舌面硬腭之间比“ㅐ”圆。与汉语拼音中“ye,jie”的韵母e发音。
ㅗ：嘴稍微张开，舌后部抬起，双唇向前拢成圆形。与汉语拼音的“o”相似，但比“o”口形要小且圆。
ㅛ：先发“ㅣ”，然后迅速滑到“ㅗ”。
ㅜ：口形比“ㅗ”小一些，双唇向前拢成圆形。与汉语拼音的韵母“u”相似。
ㅠ：先发“ㅣ”，然后迅速滑到“ㅜ”。
ㅡ：嘴稍微张开，舌身稍向后缩，舌前部放平，舌后部略向软腭抬起，嘴唇向两边拉开。发音为在英语音标 [w] 的基础上带有发“wu”的爆破音。
ㅣ：与汉语拼音的“yi”相似。
ㅑ：先发“ㅣ”，然后迅速滑到“ㅏ”，与汉语拼音的“ya”相似。
ㅕ：先发“ㅣ”，然后迅速滑到“ㅓ”。
ㅒ：先发一个“ㅣ”，然后迅速滑到“ㅐ”，即可发出此音。
ㅖ：先发一个“ㅣ”，然后迅速滑到“ㅔ”，即可发出此音，与汉语拼音的“ye”相似。
ㅘ：先发一个“ㅗ”，然后迅速滑到“ㅏ”，即可发出此音。
ㅚ：嘴张的与“ㅗ”相同，但舌位及舌形与“ㅔ”相同。练习时，先发一个“ㅔ”，然后变一下口形再发一个“ㅚ”，就这样可以交替练习。
ㅙ：先发一个“ㅚ”，然后迅速滑到“ㅐ”，即可发出此音。
ㅝ：先发一个“ㅜ”，然后迅速滑到“ㅓ”，即可发出此音。
ㅞ：先发一个“ㅜ”，然后迅速滑到“ㅔ”，即可发出此音。与汉语拼音的“yue"相似。
ㅟ：口形与“ㅜ”相同，但舌位及舌形与“ㅣ”相同。练习时，先发一个“ㅜ”，然后变一下口形再发一个“ㅟ”，就这样可以交替练习。
ㅢ：先发一个“ㅡ”，然后迅速滑到“ㅣ”，即可发出此音。
ㄱ：发音时，将舌面后部抬起，使舌根接触软腭，堵住气流，然后放开，使气流冲出而发声。它与汉语拼音的“g”相似，但力度要小一点。
ㄴ：发音时，先用舌尖抵住上齿龈，堵住气流，然后使气流从鼻腔中留出来，同时舌尖离开上齿龈，震动声带而发音。它与汉语拼音的“n”相似。
ㄷ：发音时，先用舌尖抵住上齿龈，堵住气流，然后舌尖离开上齿龈，使气流冲出，爆发、破裂成声。它与汉语拼音的“d”相似。
ㄹ：发音时，先使舌尖和上齿龈接近，然后使气流通过口腔，这是舌尖轻轻振弹一下而发声。与汉语拼音的“r”相比，舌尖靠前的，而且舌尖也不可卷起来。
ㅁ：发音时，首先紧闭嘴唇，堵住气流，然后使气流从鼻腔中流出的同时，双唇破裂成声。它与汉语拼音的“m”相似。
ㅂ：发音时，双唇紧闭并稍向前伸，堵住气流，然后用气流把双唇冲开，爆发成声。它与汉语拼音的“b"相似，但力度稍轻一点。
ㅅ：发音时，舌尖抵住下齿，舌面前部接近硬腭，使气流从舌面前部和硬腭之间的空隙处挤出来，磨擦成声。它与汉语拼音的“s”相似。
ㅇ：做为字的首音时不发音，只是起到装饰作用。
ㅈ：发音时，舌尖抵住下齿，舌面前部向上接触上齿龈和硬腭堵住气流，使气流冲破阻碍的同时，磨擦出声。它与汉语拼音的“z”相似。
ㅊ：发音时，方法与辅音“ㅈ”基本相同，只是发音时要用爆破性的气流推出。它与汉语拼音的“c"相似。
ㅋ：发音时，方法与辅音“ㄱ”基本相同，只是发音时要用爆破性的气流推出。它与汉语拼音的“k"相似。
ㅌ：发音时，方法与辅音“ㄷ”基本相同，只是发音时要用爆破性的气流推出。它与汉语拼音的“t"相似。
ㅍ：发音时，方法与辅音“ㅂ”基本相同，只是发音时要用爆破性的气流推出。它与汉语拼音的“p"相似。
ㅎ：发音时，使气流从声门挤出，这时声带磨擦就发出此音。它与汉语拼音的“h”相似。
ㄲ：发音时，与辅音“ㄱ”时基本相同，只是力度上要大一点。
ㄸ：发音时，与辅音“ㄷ”时基本相同，只是力度上要大一点。
ㅃ：发音时，与辅音“ㅂ”时基本相同，只是力度上要大一点。
ㅆ：发音时，与辅音“ㅅ”时基本相同，只是力度上要大一点。
ㅉ：发音时，与辅音“ㅈ”时基本相同，只是力度上要大一点。
''';
    String what;
    switch (listIndex) {
      case 0:
        what = 'ㅏ a ㅓ eo ㅗ o ㅜ u ㅡ eu ㅣ i ㅐ ae ㅔ e' +
            ' ㅑ ya ㅕ yeo ㅛ yo ㅠ yu ㅢ ui ㅒ yae ㅖ ye' +
            ' ㅘ wa ㅝ wae ㅚ oe ㅟ wi ㅙ wae ㅞ we' +
            ' ㄱ g ㄷ d ㅂ b ㅅ s ㅈ j' +
            ' ㅊ ch ㅋ k ㅌ t ㅍ p ㅎ h' +
            ' ㄲ kk ㄸ tt ㅃ pp ㅆ ss ㅉ jj' +
            ' ㄴ n ㅁ m ㄹ r,l';
        break;
      case 1:
        what =
            '가 Ga 갸 Gya 거 Geo 겨 Gyeo 고 Go 교 Gyo 구 Gu 규 Gyu 그 Geu 기 Gi 나 Na 냐 Nya 너 Neo 녀 Nyeo 노 No 뇨 Nyo 누 Nu 뉴 Nyu 느 Neu 니 Ni 다 Da 댜 Dya 더 Deo 뎌 Dyeo 도 Do 됴 Dyo 두 Du 듀 Dyu 드 Deu 디 Di 라 Ra 랴 Rya 러 Reo 려 Ryeo 로 Ro 료 Ryo 루 Ru 류 Ryu 르 Reu 리 Ri 마 Ma 먀 Mya 머 Meo 며 Myeo 모 Mo 묘 Myo 무 Mu 뮤 Myu 므 Meu 미 Mi 바 Ba 뱌 Bya 버 Beo 벼 Byeo 보 Bo 뵤 Byo 부 Bu 뷰 Byu 브 Beu 비 Bi 사 Sa 샤 Sya 서 Seo 셔 Syeo 소 So 쇼 Syo 수 Su 슈 Syu 스 Seu 시 Si 아 A 야 Ya 어 Eo 여 Yeo 오 O 요 Yo 우 U 유 Yu 으 Eu 이 I 자 Ja 쟈 Jya 저 Jeo 져 Jyeo 조 Jo 죠 Jyo 주 Ju 쥬 Jyu 즈 Jeu 지 Ji';
        break;
      case 2:
        what =
            '개 Gae 걔 Gyae 게 Ge 계 Gye 과 Gwa 괘 Gwae 괴 Goe 궈 Gwo 궤 Gwe 귀 Gwi 긔 Gui 내 Nae 냬 Nyae 네 Ne 녜 Nye 놔 Nwa 놰 Nwae 뇌 Noe 눠 Nwo 눼 Nwe 뉘 Nwi 늬 Nui 대 Dae 댸 Dyae 데 De 뎨 Dye 돠 Dwa 돼 Dwae 되 Doe 둬 Dwo 뒈 Dwe 뒤 Dwi 듸 Dui 래 Rae 럐 Ryae 레 Re 례 Rye 롸 Rwa 뢔 Rwae 뢰 Roe 뤄 Rwo 뤠 Rwe 뤼 Rwi 릐 Rui 매 Mae 먜 Myae 메 Me 몌 Mye 뫄 Mwa 뫠 Mwae 뫼 Moe 뭐 Mwo 뭬 Mwe 뮈 Mwi 믜 Mui 배 Bae 뱨 Byae 베 Be 볘 Bye 봐 Bwa 봬 Bwae 뵈 Boe 붜 Bwo 붸 Bwe 뷔 Bwi 븨 Bui 새 Sae 섀 Syae 세 Se 셰 Sye 솨 Swa 쇄 Swae 쇠 Soe 숴 Swo 쉐 Swe 쉬 Swi 싀 Sui Ae 애 Yae 얘 E 에 Ye 예 Wa 와 Wae 왜 Oe 외 Wo 워 We 웨 Wi 위 Ui 의 Jae 재 Jyae 쟤 Je 제 Jye 졔 Jwa 좌 Jwae 좨 Joe 죄 Jwo 줘 Jwe 줴 Jwi 쥐 Jui 즤 Chae 채 Chyae 챼 Che 체 Chye 쳬 Chwa 촤 Chwae 쵀 Choe 최 Chwo 춰 Chwe 췌 Chwi 취 Chui 츼 Kae 캐 Kyae 컈 Ke 케 Kye 켸 Kwa 콰 Kwae 쾌 Koe 쾨 Kwo 쿼 Kwe 퀘 Kwi 퀴 Kui 킈 Tae 태 Tyae 턔 Te 테 Tye 톄 Twa 톼 Twae 퇘 Toe 퇴 Two 퉈 Twe 퉤 Twi 튀 Tui 틔 Pae 패 Pyae 퍠 Pe 페 Pye 폐 Pwa 퐈 Pwae 퐤 Poe 푀 Pwo 풔 Pwe 풰 Pwi 퓌 Pui 픠 Hae 해 Hyae 햬 He 헤 Hye 혜 Hwa 화 Hwae 홰 Hoe 회 Hwo 훠 Hwe 훼 Hwi 휘 Hui 희 Kkae Kkyae 깨 Kke 꺠 Kkye 께 Kkwa 꼐 Kkwae 꽈 Kkoe 꽤 Kkwo 꾀 Kkwe 꿔 Kkwi 꿰 Kkui 뀌 Ttae 끠 Ttyae 때 Tte 떄 Ttye 떼 Ttwa 뗴 Ttwae 똬 Ttoe 뙈 Ttwo 뙤 Ttwe 뚸 Ttwi 뛔 Ttui 뛰 Ppae 띄 Ppyae 빼 Ppe 뺴 Ppye 뻬 Ppwa 뼤 Ppwae 뽜 Ppoe 뽸 Ppwo 뾔 Ppwe 뿨 Ppwi 쀄 Ppui 쀠 Ssae 쁴 Ssyae 쌔 Sse 썌 Ssye 쎄 Sswa 쎼 Sswae 쏴 Ssoe 쐐 Sswo 쐬 Sswe 쒀 Sswi 쒜 Ssui 쒸 Jjae 씌 Jjyae 째 Jje 쨰 Jjye 쩨 Jjwa 쪠 Jjwae 쫘 Jjoe 쫴 Jjwo 쬐 Jjwe 쭤 Jjwi 쮀 Jjui';
        break;
      case 3:
        what =
            '각 Gak 간 Gan 갇 Gat 갈 Gal 감 Gam 갑 Gap 강 Gang 낙 Nak 난 Nan 낟 Nat 날 Nal 남 Nam 납 Nap 낭 Nang 닥 Dak 단 Dan 닫 Dat 달 Dal 담 Dam 답 Dap 당 Dang 락 Rak 란 Ran 랃 Rat 랄 Ral 람 Ram 랍 Rap 랑 Rang 막 Mak 만 Man 맏 Mat 말 Mal 맘 Mam 맙 Map 망 Mang 박 Bak 반 Ban 받 Bat 발 Bal 밤 Bam 밥 Bap 방 Bang 삭 Sak 산 San 삳 Sat 살 Sal 삼 Sam 삽 Sap 상 Sang 악 Ak 안 An 앋 At 알 Al 암 Am 압 Ap 앙 Ang 작 Jak 잔 Jan 잗 Jat 잘 Jal 잠 Jam 잡 Jap 장 Jang 착 Chak 찬 Chan 찯 Chat 찰 Chal 참 Cham 찹 Chap 창 Chang 칵 Kak 칸 Kan 칻 Kat 칼 Kal 캄 Kam 캅 Kap 캉 Kang 탁 Tak 탄 Tan 탇 Tat 탈 Tal 탐 Tam 탑 Tap 탕 Tang 팍 Pak 판 Pan 팓 Pat 팔 Pal 팜 Pam 팝 Pap 팡 Pang 학 Hak 한 Han 핟 Hat 할 Hal 함 Ham 합 Hap 항 Hang';
        break;
    }
    List<String> whats = what.split(' ');
    int i = 0;
    for (i = whats.length ~/ 2; i-- != null; i >= 0) {
      if (listIndex == 0) {
        description = descriptions.split(whats[i * 2] + "：")[1].split("\n")[0];
      }
      addCard(whats[i * 2], whats[i * 2 + 1], description);
    }
  }

  Future addCard(String word, String letter, String description) {
    final int last = items.length;
    Dismissible d = Dismissible(
      key: ObjectKey(Random().nextInt(10000)),
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        constraints: BoxConstraints(
          minWidth: double.maxFinite,
          minHeight: double.maxFinite,
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  color: Color.fromARGB(255, Random().nextInt(155) + 100,
                      Random().nextInt(155) + 100, Random().nextInt(155) + 100),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: double.maxFinite,
                ),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        letter,
                        style: TextStyle(fontSize: 100.0),
                      ),
                      Text(
                        word,
                        style: TextStyle(fontSize: 200.0),
                      ),
                      Text(
                        description,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onDismissed: (DismissDirection direction) async {
        items.removeAt(last);
        eventBus.fire('setState');
      },
    );
    items.add(d);
  }

  @override
  void initState() {
    //订阅eventbus
    eventBus.on().listen((event) {
      setState(() {
        switch (event.toString()) {
          case 'setState':
            setState(() {});
            break;
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HangulPass"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ActionChip(
                  label: Text('基础字母'),
                  onPressed: () {
                    setState(() {
                      loadList(0);
                    });
                  },
                ),
                ActionChip(
                  label: Text('元音+辅音'),
                  onPressed: () {
                    setState(() {
                      loadList(1);
                    });
                  },
                ),
                ActionChip(
                  label: Text('双元音+辅音'),
                  onPressed: () {
                    setState(() {
                      loadList(2);
                    });
                  },
                ),
                ActionChip(
                  label: Text('元音+辅音+收音'),
                  onPressed: () {
                    setState(() {
                      loadList(3);
                    });
                  },
                ),
              ],
            ),
          ),
          Stack(
            children: items.toList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            items.clear();
          });
        },
        label: Text('重新开始'),
      ),
    );
  }
}
