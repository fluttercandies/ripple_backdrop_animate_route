# ripple_backdrop_animate_route

[![pub package](https://img.shields.io/pub/v/ripple_backdrop_animate_route.svg)](https://pub.dartlang.org/packages/ripple_backdrop_animate_route)
[![GitHub stars](https://img.shields.io/github/stars/fluttercandies/ripple_backdrop_animate_route)](https://github.com/fluttercandies/ripple_backdrop_animate_route/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/fluttercandies/ripple_backdrop_animate_route)](https://github.com/fluttercandies/ripple_backdrop_animate_route/network)
[![GitHub license](https://img.shields.io/github/license/fluttercandies/ripple_backdrop_animate_route)](https://github.com/fluttercandies/ripple_backdrop_animate_route/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/fluttercandies/ripple_backdrop_animate_route)](https://github.com/fluttercandies/ripple_backdrop_animate_route/issues)
<a target="_blank" href="https://jq.qq.com/?_wv=1027&k=5bcc0gy"><img border="0" src="https://pub.idqqimg.com/wpa/images/group.png" alt="FlutterCandies" title="FlutterCandies"></a>

A ripple animation with backdrop of route.

Screenshot:

![](https://user-gold-cdn.xitu.io/2019/8/21/16cb4d58e3458fd7)
## Getting Started
### Example Usage
```dart
import 'package:ripple_backdrop_animate_route/ripple_backdrop_animate_route.dart';

/.../

Navigator.of(context).push(TransparentRoute(
  builder: (context) => RippleBackdropAnimatePage(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("This is ripple backdrop animate page."),
      ],
    ),
    childFade: true,
    duration: 300,
    blurRadius: 20.0,
    bottomButton: Icon(Icons.visibility),
    bottomHeight: 60.0,
    bottomButtonRotate: false,
  ),
));

/.../
```
### Parameters
| parameter | description | default |
| --------- | ----------- | ------- |
| child | Child for page. | - |
| childFade | When enabled, [child] will fade in when animation is going and fade out when popping. | false |
| duration | Animation's duration, including [Navigator.push], [Navigator.pop]. | 300 |
| blurRadius | Blur radius for [BackdropFilter]. | 20.0 |
| bottomButton | [Widget] for bottom of the page. | - |
| bottomHeight | The height which [bottomButton] will occupy. | kBottomNavigationBarHeight |
| bottomButtonRotate | When enabled, [bottomButton] will rotate when to animation is going. | true |
| bottomButtonRotateDegree | The degree which [bottomButton] will rotate. | 45.0 |
