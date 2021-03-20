# View & Window

# 1. Overview

## Window

모든 앱은 적어도 하나의 윈도우를 가지고 있습니다. 외부 디스플레이를 연결할 경우 윈도우는 두 개가 됩니다. 

눈에 보이지 않는 요소인 윈도우는 `터치 이벤트`를 전달하며 `뷰의 컨테이너 역할`을 수행합니다. 이때 표시되는 뷰는 반드시 윈도우에 추가되어있어야 합니다. 

## View

윈도우에서 시각적으로 표시되는 모든 요소입니다. 뷰의 역할은 크게 세 가지입니다.

1. Displaying Contents : 화면에 텍스트나 이미지 출력
2. Handling touch event : 터치 이벤트를 전달
3. Laying out Subviews : 자신이 포함된 뷰를 관리

## System Views

1. TextViews : Label, TextField, TextView(텍스트가 많을 경우 수직 스크롤)
2. Controls : Button, Switch, Slider, Page Control, Date Picker, Segmented Control(여러 옵션 중 하나를 선택할 때 사용), Stepper(숫자 증감)
3. Content Views : Image View, Picker View, Progress View(진행 상황을 표시), Activity Indicator View(로딩 표시), Web View, Map View
4. Container Views : Scroll View, Table View, Collection View(grid)
5. Bars : Navigation Bar, Tab Bar(하단에 위치), Tool Bar, Search Bar

## UIKit

UIKit Framework에는 UIView라는 클래스가 구현되어 있습니다. 여기에는 크기, 투명도, 배경색과 같이 뷰에서 공통적으로 제공되는 기능이 구현되어 있습니다. System View는 이 클래스를 상속하고있기 때문에 이를 사용하기 위해서는 UIKit를 import 해야합니다. 

# 2. UIView #1

뷰의 기본적인 기능은 컨텐츠를 화면에 표시하고, 터치 이벤트를 전달하고, 자신에게 포함된 다른 뷰를 관리하는 것입니다.

## Displaying Contents

뷰는 `비트맵캐시`를 사용해 화면에 그림을 그립니다. 뷰는 모두 고유한 영역인 프레임을 가지고 있고, 이 안에서 모든 작업을 수행합니다. 하지만 그림을 그려내는 영역은 프레임 내부 뿐 아니라 외부까지도 가능합니다. 매번 그림을 그려내면 데이터를 많이 사용해야하기 때문에 처음 그렸던 최종 결과를 캐시에 저장하고 이것을 재사용하는 방식을 택했습니다. 이를 `On-demanded Drawing Model`이라고 합니다.

## Handling Touch Events

뷰에서 일어난 터치이벤트를 직접 처리하기도 하고, 슈퍼뷰로 전달하기도 합니다. 뷰는 터치이벤트를 처리하는 뷰와 처리하지 않는 뷰로 구분할 수 있고, 주로 터치이벤트를 처리하는 뷰는 컨트롤뷰라고 부르며 기본적으로 이벤트 처리 기능이 활성화되어 있습니다. 

탭, 더블탭, 플리킹, 패닝, 롱프레스 등 다양한 터치 동작을 입력받을 때 필요한 모든것은 UIKit에 구현되어 있습니다. 

## Laying Out Subviews

뷰는 자신에게 포함된 다른 뷰를 관리할 수 있습니다. 이때 뷰 사이에는 계층구조가 생기며 계층구조에서 위에 있는 뷰를 슈퍼뷰, 다른 뷰를 서브뷰라고 합니다. 뷰는 여러개의 서브뷰를 가질 수 있지만, 여러 뷰에 속할수 없습니다. 다시 말해, 슈퍼뷰는 단 하나입니다. 

![View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__10.40.40.png](View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__10.40.40.png)

뷰는 서브뷰를 배열로 관리합니다. 

배열은 순서를 가지고 있기 때문에 서브뷰들 사이에 표시되는 순번을 부여합니다. 

가장 먼저 저장된 뷰는 바닥에 깔려있고, 가장 마지막에 저장된 뷰는 가장 위에 위치하게 됩니다. 

클래스처럼 슈퍼뷰에 변화가 생기면 서브뷰도 그에 맞게 변합니다. 

예를 들어 슈퍼뷰의 투명도가 0이 되었을때, 나머지 서브뷰는 자신들의 투명도 설정과 관계 없이 함께 뷰에서 투명하게 표시됩니다. 

## 좌표 체계

![View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__10.43.57.png](View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__10.43.57.png)

기본 좌표 체계는 왼쪽 상단에서 시작하며 오른쪽으로 갈수록 x 좌표가 증가하고, 아래쪽으로 갈수록 y 좌표가 증가합니다. 

모든 단위는 `pt(point)`를 사용합니다.

![View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__11.02.59.png](View%20&%20Window%209825181dfdee45898b6d176ac14ac64e/_2021-03-20__11.02.59.png)

윈도우와 뷰는 고유한 지역좌표를 가지고 있습니다. 

뷰에서 content를 표현할때는 뷰의 지역좌표를 사용합니다. 

(Local coordinate system)

위치와 크기를 나타낼 때에는 슈퍼뷰의 지역좌표를 사용합니다. (Superview's Local coordinate system)

위치와 크기를 묶어 프레임(frame)이라고 하며 UIView 클래스에 `frame`이라는 이름으로 선언되어 있습니다. 

타입은 `CGRect` 구조체입니다. 

```jsx
var frame: CGRect
var bounds: CGRect

struct CGRect {
		var origin: CGPoint // 원점 저장
		var size: CGSize // 크기 저장
}

```

```jsx
struct CGPoint {
		var x: CGFloat
		var y: CGFloat
}

struct CGPoint {
		var width: CGFloat
		var height: CGFloat
}
```

`bounds` 속성은 frame과 혼동하기 쉽습니다.

frame은 슈퍼뷰의 지역좌표에서 뷰의 크기와 위치를 나타내는 속성이고

bounds는 현재 뷰의 지역좌표에서 뷰의 크기를 저장하는 속성입니다. origin의 기본값으로는 0이 저장되어 있고, size는 프레임의 크기가 저장되어 있습니다.