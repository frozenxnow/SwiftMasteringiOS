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

# 3. UIView #2

UIView를 추가하는 방법에는 두가지가 있습니다. 우선 Root View의 존재를 알아야합니다. Scene에서 화면을 구성할 때에는 Root View에 SubView를 추가합니다. 

스토리보드에서는 drag&drop 으로 서브뷰를 생성하고, 그 서브뷰를 루트뷰에 추가합니다.

코드로 작성할 때에는 이 모든 작업을 따로 실행합니다.

```jsx
import UIKit

class CreatingViewObjectViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        let v = UIView(frame: frame)
        
        view.addSubview(v)
    }
}
```

1. 우선 뷰의 위치와 크기를 저장하는 frame을 선언합니다.
2. 그 frame을 값으로 가지는 (서브)뷰를 생성합니다.
3. 루트뷰인 view에 addSubview(view:)를 사용해 서브뷰를 추가합니다.

## Image View

Image View는 UIImageView 클래스로 이루어져있고 이 클래스는 UIView 클래스를 상속합니다. 

Content Mode란 이미지뷰 프레임 내 이미지가 위치하는 모습을 설정하는 속성으로 다양한 설정 조건이 존재합니다.

- Aspect Fit : 프레임 내부에서 원본 비율을 유지합니다.
- Aspect Fill : 원본 비율을 유지하며 프레임에 빈 공간이 없도록 위치하기 때문에 프레임보다 이미지가 커질 수 있습니다.
- Scale To Fill : 비율을 유지하지 않고 프레임에 꽉 채우도록 이미지가 변형됩니다.
- Redraw : 캐시에 저장된 이미지를 사용하지 않고 이미지를 무조건 다시 그립니다. 따라서 그리기 성능이 매우 저하되며 꼭 필요한 상황이 아니라면 사용하지 않습니다.
- 나머지는 원본 이미지를 그대로 유지하며 용어에 따라 프레임에서 이미지의 위치를 고정합니다.

# 4. UIView #3

## View Tagging

View의 속성 중 Tag라는 속성에 대해 알아보겠습니다. 뷰에 접근하는 방법으로 Outlet을 사용하지만, 태그를 이용하면 Outlet 없이 속성에 접근할 수 있습니다. 기본값은 0이고 0이 아닌 다른 숫자로 지정했을 경우 코드에서 그 숫자를 사용해 뷰에 접근합니다. 이러한 방법을 `View Tagging`이라고 합니다. 

```jsx
@IBAction func changeColor(_ sender: Any) {
    if let v = view.viewWithTag(0) {
        v.backgroundColor = .black
    }
}
```

Scene의 버튼을 IBAction으로 연결했습니다. 이 버튼을 클릭할 경우 배경이 바뀌도록 구현했습니다. 

루트뷰에는 현재 서로 다른 색상의 뷰가 두 개 있고, 두 뷰의 태그 속성값은 0입니다.

위와 같이 구현한 후 버튼을 탭하면 루트뷰의 바탕 색이 검정색으로 변합니다.

여기에서 viewWithTag() 함수에 대해 살펴보겠습니다. 이 함수는 view.viweWithTag(0)으로 앞에 붙어있는 view는 RootView를 의미합니다. 이 함수를 실행하면 루트뷰부터 태그가 0인 뷰를 찾게 되고, 루트뷰의 태그값 또한 0이기 때문에 루트뷰의 배경 색을 검정으로 변경한 후 함수의 실행이 종료됩니다.

그렇다면 색상을 바꾸고자 하는 뷰의 태그 속성값을 변경하고, 이 속성값을 통해 해당 뷰의 배경색을 변경하면 될 것 같습니다. 그렇게 구현하고 다시 실행하겠습니다. 각 뷰의 태그값을 326, 99로 변경하고(viewWithTag()함수의 파라미터는 Int를 필요로 합니다.) 위 함수에서 0이 아닌 326과 99를 입력, 배경 색을 다른 색으로 변경하도록 구현했더니 올바르게 실행되었습니다. 루트뷰도 태그값을 가지고 있고, 이 또한 0이라고 생각하면 될것 같습니다. 

```jsx
// 수정한 코드
class TagViewController: UIViewController {
    
    @IBAction func changeColor(_ sender: Any) {
        if let v = view.viewWithTag(326) {
            v.backgroundColor = .blue
        }
        if let v = view.viewWithTag(99) {
            v.backgroundColor = .systemRed
        }
    }
}
```

`viewWithTag()` 함수를 제대로 사용하기 위해서는 뷰마다 `고유한 태그값`을 지정해주어야 합니다. 만약 동일한 값을 가진 뷰 모두에 적용되는 것이 아니라 **먼저 검색된 하나의 뷰에만 영향을 미치기 때문에** 주의해야합니다.

## Interaction

뷰의 속성을 살펴보면 Interaction 속성에 체크박스가 두 개 있는것을 확인할 수 있습니다.

- [ ]  User Interaction Enabled
- [ ]  Multiple Touch

기본적으로 User Interaction Enabled에는 체크가 되어있고 Multiple Touch에는 체크가 되어있지 않습니다. 

User Interaction Enabled는 사용자의 터치 이벤트를 인식하는 것이고 

Multiple Touch는 여러 개의 터치를 인식하는 것입니다. 만약 Multiple Touch에 터치가 되어있지 않은 상태에서 두 개 이상의 터치 이벤트가 발생한다면 먼저 터치된 값만 인식합니다. 

# 5. UIView #4

## Alpha

투명도입니다. `0.0 ~ 1.0` 까지의 값을 가지고 있고, 0.0은 완전히 투명하게 설정됩니다. 

이때 서브뷰의 알파값은 슈퍼뷰에 영향을 미치지 않으며, 반대로 슈퍼뷰의 알파값은 서브뷰에 영향을 미칩니다.

## Background color

스토리보드에서 변경하는 것은 어렵지 않습니다. 색을 직접 선택할 수도 있고 컬러 팔레트를 사용할 수도 있습니다.

그러나 코드에서 직접 변경할 때는 UIColor를 사용해야 하고 알아야 할 내용도 상당히 많기 때문에 뒤에서 학습하도록 하겠습니다.

## Hidden

히든 속성을 체크할 경우 스토리보드에는 희미하게 표시가 되어있으나 실제로 실행하면 보이지도 않고 이벤트를 처리할수도 없게 됩니다.

## Clip to Bounds

슈퍼뷰와 서브뷰가 있을 때 서브뷰는 슈퍼뷰의 프레임 밖에 위치할 수도 있습니다. 이때 Clip to Bounds 속성에 체크하게 되면 슈퍼뷰의 프레임 밖으로 벗어난 서브뷰의 이미지는 숨김처리되어 노출되지 않습니다.

## Opaque

기본으로 체크되어 있습니다. 두 뷰가 겹쳐져있고 알파값이 1이 아닐때 겹쳐진 부분에서는 색의 합성값을 계산하는 과정이 필요합니다. 

체크되어 있을 경우 이 과정을 무시하고 색상을 합성하지 않습니다. (알파값이 1.0일 때 체크합니다.)

체크되지 않았을 경우 색을 합성하는 과정이 추가되어 상대적으로 느려집니다. (알파값이 1.0 미만일 때 체크를 해제합니다.)

## Clears Graphics Context

체크되어 있을 경우 뷰가 그리기 코드를 실행하기 전 그리기 버퍼를 알파값이 0.0인 검정색으로 초기화합니다. 새로운 내용을 그리기 전 이전 내용을 완전 삭제하는 과정입니다. 

체크되지 않았을 경우 위 과정이 무시되어 그리기 성능이 향상되지만, 구현에 따라 이전 내용이 표시될 수 있습니다.