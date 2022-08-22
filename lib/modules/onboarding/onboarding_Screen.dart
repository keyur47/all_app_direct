// import 'package:all_app_direct/helper/shared_preferences.dart';
// import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
// import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
// import 'package:all_app_direct/widgets/newt_box_buttons.dart';
// import 'package:flutter/material.dart';
//
// class onBoardingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow,
//       body: Stack(
//         children: [
//           Center(child: Text("SplashBox1")),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 25, right: 15),
//             child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: boxNext(onTap: () async {
//                   SharedPrefs.setInt(1);
//                   SharedPrefs.getInt();
//                   Navigation.pushNamed(Routes.loginPage);
//                 })),
//           )
//         ],
//       ),
//     );
//   }
// }

///
// import 'package:all_app_direct/helper/shared_preferences.dart';
// import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
// import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
//
// class onBoardingScreen extends StatefulWidget {
//   @override
//   _onBoardingScreenState createState() => _onBoardingScreenState();
// }
//
// class _onBoardingScreenState extends State<onBoardingScreen> {
//   final introKey = GlobalKey<IntroductionScreenState>();
//
//   void _onIntroEnd(context)async {
//     SharedPrefs.setInt(1);
//     SharedPrefs.getInt();
//     Navigation.pushNamed(Routes.loginPage);
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(builder: (_) => HomePage()),
//     // );
//   }
//
//   Widget _buildFullscreenImage() {
//     return Image.asset(
//       'assets/fullscreen.jpg',
//       fit: BoxFit.cover,
//       height: double.infinity,
//       width: double.infinity,
//       alignment: Alignment.center,
//     );
//   }
//
//   Widget _buildImage(String assetName, [double width = 350]) {
//     return Image.asset('assets/$assetName', width: width);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const bodyStyle = TextStyle(fontSize: 19.0);
//
//     const pageDecoration = const PageDecoration(
//       titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
//       bodyTextStyle: bodyStyle,
//       bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
//       pageColor: Colors.white,
//       imagePadding: EdgeInsets.zero,
//     );
//
//     return IntroductionScreen(
//       key: introKey,
//       globalBackgroundColor: Colors.white,
//       globalHeader: Align(
//         alignment: Alignment.topRight,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 16, right: 16),
//             child: _buildImage('flutter.png', 100),
//           ),
//         ),
//       ),
//       globalFooter: SizedBox(
//         width: double.infinity,
//         height: 60,
//         child: ElevatedButton(
//           child: const Text(
//             'Let\'s go right away!',
//             style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//           ),
//           onPressed: () => _onIntroEnd(context),
//         ),
//       ),
//       pages: [
//         PageViewModel(
//           title: "Fractional shares",
//           body:
//           "Instead of having to buy an entire share, invest any amount you want.",
//           image: _buildImage('img1.jpg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Learn as you go",
//           body:
//           "Download the Stockpile app and master the market with our mini-lesson.",
//           image: _buildImage('img2.jpg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Kids and teens",
//           body:
//           "Kids and teens can track their stocks 24/7 and place trades that you approve.",
//           image: _buildImage('img3.jpg'),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Full Screen Page",
//           body:
//           "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
//           image: _buildFullscreenImage(),
//           decoration: pageDecoration.copyWith(
//             contentMargin: const EdgeInsets.symmetric(horizontal: 16),
//             fullScreen: true,
//             bodyFlex: 2,
//             imageFlex: 3,
//           ),
//         ),
//         PageViewModel(
//           title: "Another title page",
//           body: "Another beautiful body text for this example onboarding",
//           image: _buildImage('img2.jpg'),
//           footer: ElevatedButton(
//             onPressed: () {
//               introKey.currentState?.animateScroll(0);
//             },
//             child: const Text(
//               'FooButton',
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.lightBlue,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//             ),
//           ),
//           decoration: pageDecoration,
//         ),
//         PageViewModel(
//           title: "Title of last page - reversed",
//           bodyWidget: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: const [
//               Text("Click on ", style: bodyStyle),
//               Icon(Icons.edit),
//               Text(" to edit a post", style: bodyStyle),
//             ],
//           ),
//           decoration: pageDecoration.copyWith(
//             bodyFlex: 2,
//             imageFlex: 4,
//             bodyAlignment: Alignment.bottomCenter,
//             imageAlignment: Alignment.topCenter,
//           ),
//           image: _buildImage('img1.jpg'),
//           reverse: true,
//         ),
//       ],
//       onDone: () => _onIntroEnd(context),
//       //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
//       showSkipButton: false,
//       skipOrBackFlex: 0,
//       nextFlex: 0,
//       showBackButton: true,
//       //rtl: true, // Display as right-to-left
//       back: const Icon(Icons.arrow_back),
//       skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
//       next: const Icon(Icons.arrow_forward),
//       done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
//       curve: Curves.fastLinearToSlowEaseIn,
//       controlsMargin: const EdgeInsets.all(16),
//       controlsPadding: kIsWeb
//           ? const EdgeInsets.all(12.0)
//           : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
//       dotsDecorator: const DotsDecorator(
//         size: Size(10.0, 10.0),
//         color: Color(0xFFBDBDBD),
//         activeSize: Size(22.0, 10.0),
//         activeShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(25.0)),
//         ),
//       ),
//       dotsContainerDecorator: const ShapeDecoration(
//         color: Colors.black87,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         ),
//       ),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: const Center(child: Text("This is the screen after Introduction")),
//     );
//   }
// }


///
///
// import 'dart:math';
//
//
// import 'package:all_app_direct/helper/shared_preferences.dart';
// import 'package:all_app_direct/utils/navigation/dart/navigation.dart';
// import 'package:all_app_direct/utils/navigation/dart/route_page.dart';
// import 'package:flutter/material.dart';
//
// Duration kButtonAnimationDuration = Duration(milliseconds: 600);
// Duration kCardAnimationDuration = Duration(milliseconds: 400);
// Duration kRippleAnimationDuration = Duration(milliseconds: 400);
// Duration kLoginAnimationDuration = Duration(milliseconds: 1500);
// const double kPaddingS = 8.0;
// const double kPaddingM = 16.0;
// const double kPaddingL = 32.0;
// const Color kBlue = Color(0xFF306EFF);
// const Color kLightBlue = Color(0xFF4985FD);
// const Color kDarkBlue = Color(0xFF1046B3);
// const Color kWhite = Color(0xFFFFFFFF);
// const Color kGrey = Color(0xFFF4F5F7);
// const Color kBlack = Color(0xFF2D3243);
// const double kSpaceS = 8.0;
// const double kSpaceM = 16.0;
//
//
//
// class Onboarding extends StatefulWidget {
//   final double? screenHeight;
//
//   const Onboarding({
//     this.screenHeight,
//   });
//
//   @override
//   _OnboardingState createState() => _OnboardingState();
// }
//
// class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
//   late final AnimationController _cardsAnimationController;
//   late final AnimationController _pageIndicatorAnimationController;
//   late final AnimationController _rippleAnimationController;
//
//   late Animation<Offset> _slideAnimationLightCard;
//   late Animation<Offset> _slideAnimationDarkCard;
//   late Animation<double> _pageIndicatorAnimation;
//   late Animation<double> _rippleAnimation;
//
//   int _currentPage = 1;
//
//   ///
//
//
//   @override
//   void initState() {
//     super.initState();
//     _cardsAnimationController = AnimationController(
//       vsync: this,
//       duration: kCardAnimationDuration,
//     );
//     _pageIndicatorAnimationController = AnimationController(
//       vsync: this,
//       duration: kButtonAnimationDuration,
//     );
//     _rippleAnimationController = AnimationController(
//       vsync: this,
//       duration: kRippleAnimationDuration,
//     );
//
//     _rippleAnimation = Tween<double>(
//       begin: 0.0,
//       end: widget.screenHeight,
//     ).animate(CurvedAnimation(
//       parent: _rippleAnimationController,
//       curve: Curves.easeIn,
//     ));
//
//     _setPageIndicatorAnimation();
//     _setCardsSlideOutAnimation();
//   }
//
//   @override
//   void dispose() {
//     _cardsAnimationController.dispose();
//     _pageIndicatorAnimationController.dispose();
//     _rippleAnimationController.dispose();
//     super.dispose();
//   }
//
//   bool get isFirstPage => _currentPage == 1;
//
//   Widget _getPage() {
//     switch (_currentPage) {
//       case 1:
//         return OnboardingPage(
//           number: 1,
//           lightCardChild: const CommunityLightCardContent(),
//           darkCardChild: const CommunityDarkCardContent(),
//           lightCardOffsetAnimation: _slideAnimationLightCard,
//           darkCardOffsetAnimation: _slideAnimationDarkCard,
//           textColumn: const CommunityTextColumn(),
//         );
//       case 2:
//         return OnboardingPage(
//           number: 2,
//           lightCardChild: const EducationLightCardContent(),
//           darkCardChild: const EducationDarkCardContent(),
//           lightCardOffsetAnimation: _slideAnimationLightCard,
//           darkCardOffsetAnimation: _slideAnimationDarkCard,
//           textColumn: const EducationTextColumn(),
//         );
//       case 3:
//         return OnboardingPage(
//           number: 3,
//           lightCardChild: const WorkLightCardContent(),
//           darkCardChild: const WorkDarkCardContent(),
//           lightCardOffsetAnimation: _slideAnimationLightCard,
//           darkCardOffsetAnimation: _slideAnimationDarkCard,
//           textColumn: const WorkTextColumn(),
//         );
//       default:
//         throw Exception("Page with number '$_currentPage' does not exist.");
//     }
//   }
//
//   void _setCardsSlideInAnimation() {
//     setState(() {
//       _slideAnimationLightCard = Tween<Offset>(
//         begin: const Offset(3.0, 0.0),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _cardsAnimationController,
//         curve: Curves.easeOut,
//       ));
//       _slideAnimationDarkCard = Tween<Offset>(
//         begin: const Offset(1.5, 0.0),
//         end: Offset.zero,
//       ).animate(CurvedAnimation(
//         parent: _cardsAnimationController,
//         curve: Curves.easeOut,
//       ));
//       _cardsAnimationController.reset();
//     });
//   }
//
//   void _setCardsSlideOutAnimation() {
//     setState(() {
//       _slideAnimationLightCard = Tween<Offset>(
//         begin: Offset.zero,
//         end: const Offset(-3.0, 0.0),
//       ).animate(CurvedAnimation(
//         parent: _cardsAnimationController,
//         curve: Curves.easeIn,
//       ));
//       _slideAnimationDarkCard = Tween<Offset>(
//         begin: Offset.zero,
//         end: const Offset(-1.5, 0.0),
//       ).animate(CurvedAnimation(
//         parent: _cardsAnimationController,
//         curve: Curves.easeIn,
//       ));
//       _cardsAnimationController.reset();
//     });
//   }
//
//   void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
//     final multiplicator = isClockwiseAnimation ? 2 : -2;
//
//     setState(() {
//       _pageIndicatorAnimation = Tween(
//         begin: 0.0,
//         end: multiplicator * pi,
//       ).animate(
//         CurvedAnimation(
//           parent: _pageIndicatorAnimationController,
//           curve: Curves.easeIn,
//         ),
//       );
//       _pageIndicatorAnimationController.reset();
//     });
//   }
//
//   void _setNextPage(int nextPageNumber) {
//     setState(() {
//       _currentPage = nextPageNumber;
//     });
//   }
//
//   Future<void> _nextPage() async {
//     switch (_currentPage) {
//       case 1:
//         if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
//           _pageIndicatorAnimationController.forward();
//           await _cardsAnimationController.forward();
//           _setNextPage(2);
//           _setCardsSlideInAnimation();
//           await _cardsAnimationController.forward();
//           _setCardsSlideOutAnimation();
//           _setPageIndicatorAnimation(isClockwiseAnimation: false);
//         }
//         break;
//       case 2:
//         if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
//           _pageIndicatorAnimationController.forward();
//           await _cardsAnimationController.forward();
//           _setNextPage(3);
//           _setCardsSlideInAnimation();
//           await _cardsAnimationController.forward();
//         }
//         break;
//       case 3:
//         if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
//           await _goToLogin();
//         }
//         break;
//     }
//   }
//
//   Future<void> _goToLogin() async {
//     await _rippleAnimationController.forward();
//     SharedPrefs.setInt(1);
//     SharedPrefs.getInt();
//     Navigation.pushNamed(Routes.loginPage);
//     // Navigator.of(context).push(
//     //   MaterialPageRoute(
//     //     builder: (_) => Login(screenHeight: widget.screenHeight),
//     //   ),
//     // );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBlue,
//       body: Stack(
//         children: <Widget>[
//           SafeArea(
//             child: Padding(
//               padding:  EdgeInsets.all(kPaddingL),
//               child: Column(
//                 children: <Widget>[
//                   Header(onSkip: _goToLogin),
//                   Expanded(child: _getPage()),
//                   AnimatedBuilder(
//                     animation: _pageIndicatorAnimation,
//                     builder: (_, Widget? child) {
//                       return OnboardingPageIndicator(
//                         angle: _pageIndicatorAnimation.value,
//                         currentPage: _currentPage,
//                         child: child!,
//                       );
//                     },
//                     child: NextPageButton(onPressed: _nextPage),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           AnimatedBuilder(
//             animation: _rippleAnimation,
//             builder: (_, Widget? child) {
//               return Ripple(radius: _rippleAnimation.value);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
// class CommunityLightCardContent extends StatelessWidget {
//   const CommunityLightCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:  <Widget>[
//         IconContainer(
//           icon: Icons.person,
//           padding: kPaddingS,
//         ),
//         IconContainer(
//           icon: Icons.group,
//           padding: kPaddingM,
//         ),
//         IconContainer(
//           icon: Icons.insert_emoticon,
//           padding: kPaddingS,
//         ),
//       ],
//     );
//   }
// }
//
//
// class CommunityDarkCardContent extends StatelessWidget {
//   const CommunityDarkCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: const <Widget>[
//         Padding(
//           padding: EdgeInsets.only(top: kPaddingL),
//           child: Icon(
//             Icons.brush,
//             color: kWhite,
//             size: 32.0,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: kPaddingL),
//           child: Icon(
//             Icons.camera_alt,
//             color: kWhite,
//             size: 32.0,
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(top: kPaddingL),
//           child: Icon(
//             Icons.straighten,
//             color: kWhite,
//             size: 32.0,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
// class CommunityTextColumn extends StatelessWidget {
//   const CommunityTextColumn();
//
//   @override
//   Widget build(BuildContext context) {
//     return const TextColumn(
//       title: 'Community',
//       text:
//       'Eu sint do id aliqua qui tempor sint cillum commodo id voluptate qui.',
//     );
//   }
// }
//
//
//
//
// class TextColumn extends StatelessWidget {
//   final String title;
//   final String text;
//
//   const TextColumn({
//     required this.title,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Text(
//           title,
//           textAlign: TextAlign.center,
//           style: Theme.of(context)
//               .textTheme
//               .headline5!
//               .copyWith(color: kWhite, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: kSpaceS),
//         Text(
//           text,
//           textAlign: TextAlign.center,
//           style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kWhite),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class EducationLightCardContent extends StatelessWidget {
//   const EducationLightCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:  const <Widget>[
//         IconContainer(
//           icon: Icons.brush,
//           padding: kPaddingS,
//         ),
//         IconContainer(
//           icon: Icons.camera_alt,
//           padding: kPaddingM,
//         ),
//         IconContainer(
//           icon: Icons.straighten,
//           padding: kPaddingS,
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//
// class EducationDarkCardContent extends StatelessWidget {
//   const EducationDarkCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return const Icon(
//       Icons.laptop_mac,
//       color: kWhite,
//       size: 96.0,
//     );
//   }
// }
//
//
//
// class EducationTextColumn extends StatelessWidget {
//   const EducationTextColumn();
//
//   @override
//   Widget build(BuildContext context) {
//     return const TextColumn(
//       title: 'Keep learning',
//       text: 'Ipsum magna enim cupidatat culpa elit cillum velit occaecat.',
//     );
//   }
// }
//
//
//
// class WorkLightCardContent extends StatelessWidget {
//   const WorkLightCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children:  const <Widget>[
//         IconContainer(
//           icon: Icons.event_seat,
//           padding: kPaddingS,
//         ),
//         IconContainer(
//           icon: Icons.business_center,
//           padding: kPaddingM,
//         ),
//         IconContainer(
//           icon: Icons.assessment,
//           padding: kPaddingS,
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class WorkDarkCardContent extends StatelessWidget {
//   const WorkDarkCardContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: const <Widget>[
//             Icon(
//               Icons.person_pin,
//               color: kWhite,
//               size: 32.0,
//             ),
//           ],
//         ),
//         const SizedBox(height: kSpaceM),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: const <Widget>[
//             Icon(
//               Icons.person,
//               color: kWhite,
//               size: 32.0,
//             ),
//             Icon(
//               Icons.group,
//               color: kWhite,
//               size: 32.0,
//             ),
//             Icon(
//               Icons.insert_emoticon,
//               color: kWhite,
//               size: 32.0,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class WorkTextColumn extends StatelessWidget {
//   const WorkTextColumn();
//
//   @override
//   Widget build(BuildContext context) {
//     return const TextColumn(
//       title: 'Work together',
//       text:
//       'Adipisicing anim ex excepteur duis quis in tempor eu ullamco adipisicing.',
//     );
//   }
// }
//
// class IconContainer extends StatelessWidget {
//   final IconData icon;
//   final double padding;
//
//   const IconContainer({
//     required this.icon,
//     required this.padding,
//   });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(padding),
//       decoration: BoxDecoration(
//         color: kWhite.withOpacity(0.25),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         icon,
//         size: 32.0,
//         color: kWhite,
//       ),
//     );
//   }
// }
//
//
// class OnboardingPageIndicator extends StatelessWidget {
//   final double angle;
//   final int currentPage;
//   final Widget child;
//
//   const OnboardingPageIndicator({
//     required this.angle,
//     required this.currentPage,
//     required this.child,
//   });
//
//   Color _getPageIndicatorColor(int pageIndex) {
//     return currentPage > pageIndex ? kWhite : kWhite.withOpacity(0.25);
//   }
//
//   double get indicatorGap => pi / 12;
//   double get indicatorLength => pi / 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _OnboardignPageIndicatorPainter(
//         color: _getPageIndicatorColor(0),
//         startAngle:
//         (4 * indicatorLength) - (indicatorLength + indicatorGap) + angle,
//         indicatorLength: indicatorLength,
//       ),
//       child: CustomPaint(
//         painter: _OnboardignPageIndicatorPainter(
//           color: _getPageIndicatorColor(1),
//           startAngle: 4 * indicatorLength + angle,
//           indicatorLength: indicatorLength,
//         ),
//         child: CustomPaint(
//           painter: _OnboardignPageIndicatorPainter(
//             color: _getPageIndicatorColor(2),
//             startAngle: (4 * indicatorLength) +
//                 (indicatorLength + indicatorGap) +
//                 angle,
//             indicatorLength: indicatorLength,
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
//
// class _OnboardignPageIndicatorPainter extends CustomPainter {
//   final Color color;
//   final double startAngle;
//   final double indicatorLength;
//
//   const _OnboardignPageIndicatorPainter({
//     required this.color,
//     required this.startAngle,
//     required this.indicatorLength,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0;
//
//     canvas.drawArc(
//       Rect.fromCircle(
//         center: Offset(size.width / 2, size.height / 2),
//         radius: (size.shortestSide + 12.0) / 2,
//       ),
//       startAngle,
//       indicatorLength,
//       false,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(_OnboardignPageIndicatorPainter oldDelegate) {
//     return color != oldDelegate.color || startAngle != oldDelegate.startAngle;
//   }
// }
//
//
// class Header extends StatelessWidget {
//   final VoidCallback onSkip;
//
//   const Header({
//     required this.onSkip,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         const Logo(
//           color: kWhite,
//           size: 32.0,
//         ),
//         GestureDetector(
//           onTap: onSkip,
//           child: Text(
//             'Skip',
//             style: Theme.of(context).textTheme.subtitle1!.copyWith(
//               color: kWhite,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
// class Logo extends StatelessWidget {
//   final Color color;
//   final double size;
//
//   const Logo({
//     required this.color,
//     required this.size,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform.rotate(
//       angle: -pi / 4,
//       child: Icon(
//         Icons.format_bold,
//         color: color,
//         size: size,
//       ),
//     );
//   }
// }
//
// class OnboardingPage extends StatelessWidget {
//   final int number;
//   final Widget lightCardChild;
//   final Widget darkCardChild;
//   final Animation<Offset> lightCardOffsetAnimation;
//   final Animation<Offset> darkCardOffsetAnimation;
//   final Widget textColumn;
//
//   const OnboardingPage({
//     required this.number,
//     required this.lightCardChild,
//     required this.darkCardChild,
//     required this.lightCardOffsetAnimation,
//     required this.darkCardOffsetAnimation,
//     required this.textColumn,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         CardsStack(
//           pageNumber: number,
//           lightCardChild: lightCardChild,
//           darkCardChild: darkCardChild,
//           lightCardOffsetAnimation: lightCardOffsetAnimation,
//           darkCardOffsetAnimation: darkCardOffsetAnimation,
//         ),
//         SizedBox(height: number % 2 == 1 ? 50.0 : 25.0),
//         AnimatedSwitcher(
//           duration: kCardAnimationDuration,
//           child: textColumn,
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
// class CardsStack extends StatelessWidget {
//   final int pageNumber;
//   final Widget lightCardChild;
//   final Widget darkCardChild;
//   final Animation<Offset> lightCardOffsetAnimation;
//   final Animation<Offset> darkCardOffsetAnimation;
//
//   const CardsStack({
//     required this.pageNumber,
//     required this.lightCardChild,
//     required this.darkCardChild,
//     required this.lightCardOffsetAnimation,
//     required this.darkCardOffsetAnimation,
//   });
//
//   bool get isOddPageNumber => pageNumber % 2 == 1;
//
//   @override
//   Widget build(BuildContext context) {
//     final darkCardWidth = MediaQuery.of(context).size.width - 2 * kPaddingL;
//     final darkCardHeight = MediaQuery.of(context).size.height / 3;
//
//     return Padding(
//       padding: EdgeInsets.only(top: isOddPageNumber ? 25.0 : 50.0),
//       child: Stack(
//         alignment: AlignmentDirectional.center,
//         clipBehavior: Clip.none,
//         children: <Widget>[
//           SlideTransition(
//             position: darkCardOffsetAnimation,
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.0),
//               ),
//               color: kDarkBlue,
//               child: Container(
//                 width: darkCardWidth,
//                 height: darkCardHeight,
//                 padding: EdgeInsets.only(
//                   top: !isOddPageNumber ? 100.0 : 0.0,
//                   bottom: isOddPageNumber ? 100.0 : 0.0,
//                 ),
//                 child: Center(child: darkCardChild),
//               ),
//             ),
//           ),
//           Positioned(
//             top: !isOddPageNumber ? -25.0 : null,
//             bottom: isOddPageNumber ? -25.0 : null,
//             child: SlideTransition(
//               position: lightCardOffsetAnimation,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 color: kLightBlue,
//                 child: Container(
//                   width: darkCardWidth * 0.8,
//                   height: darkCardHeight * 0.5,
//                   padding:  EdgeInsets.symmetric(horizontal: kPaddingM),
//                   child: Center(child: lightCardChild),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
//
//
//
// class Ripple extends StatelessWidget {
//   final double radius;
//
//   const Ripple({
//     required this.radius,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Positioned(
//       left: screenWidth / 2 - radius,
//       bottom: 2 * kPaddingL - radius,
//       child: Container(
//         width: 2 * radius,
//         height: 2 * radius,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: kWhite,
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
// class NextPageButton extends StatelessWidget {
//   final VoidCallback onPressed;
//
//   const NextPageButton({
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RawMaterialButton(
//       padding: const EdgeInsets.all(kPaddingM),
//       elevation: 0.0,
//       shape: const CircleBorder(),
//       fillColor: kWhite,
//       onPressed: onPressed,
//       child: const Icon(
//         Icons.arrow_forward,
//         color: kBlue,
//         size: 32.0,
//       ),
//     );
//   }
// }