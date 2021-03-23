# System View & Control

# 1. UIControl & Target-Action

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__4.31.33.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__4.31.33.png)

Xcode에서 제공하는 컨트롤은 위와 같이 상당히 다양합니다. 컨트롤이 제공하는 기능은 `UIControl` 클래스에 구현되어 있습니다. UIControl은 UIView 클래스를 상속하고 UIButton, UISwitch, UISlider, UIPageControl, UIDatePicker, UISegmentedControl, UIStepper은 UIControl 클래스를 상속합니다. 

컨트롤은 다양한 상태를 가지고 있고, 그것을 시각적으로 표현합니다. 터치의 종류에 따라 다양한 이벤트를 전달하며 `Target-Action 매커니즘`으로 처리합니다.

UIControl 클래스에는 상태를 나타내는 statement가 선언되어 있습니다. statement의 타입은 구조체로 선언되어 있고, 일곱가지 중 다섯가지를 가장 많이 사용합니다. UIControl 클래스에는 초기 상태를 나타내는 변수를 가지고 있는데 isEnable, inSelected, isHighlighted가 있습니다. 이는 코드인스펙터에서 설정할 수 있지만 이와 같이 코드로 직접 작성이 가능합니다. 

iOS에서는 이벤트를 처리하기 위해 control과 target을 연결한 후 처리합니다. 이것을 `Target-Action 매커니즘` 혹은 `Target-Action 패턴`이라고 합니다.  Action은 이벤트가 발생하면 호출되는 메서드이고 Target은 이 메소드가 구현되어 있는 객체입니다. Target과 Control을 지정할 때 addTarget(_:action:for:) 함수를 이용합니다.

```jsx
func addTarget (_ target: Any?, 
									action: Selector,
									for controlEvents: UIControl.Event)
```

- target: Any? // 이 메서드가 구현되어 있는 객체를 전달받습니다.
- action: Selector // 실행할 코드가 구현되어 있는 메서드를 Selector 형태로 전달받습니다.
- for controlEvents: UIControl.Event // 메소드로 처리할 이벤트로서, UIControl.Event 구조체에 선언되어 있습니다. 이름을 살펴보면 어떤 이벤트인지 쉽게 알아차릴 수 있습니다. 
주로 button은 touchUpInside, slider나 picker control은 valueChanged 이벤트를 전달합니다.

## Target-Action Pattern: Interface Builder & Code 비교

[Interface Builder] control 키를 누른 채 drag&drop합니다. 아래와 같은 새 창이 생성됩니다.

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__5.13.53.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__5.13.53.png)

Conntection에서는 Action으로 연결할지 Outlet으로 연결할지 선택할 수 있습니다. 이벤트를 처리하는 기능을 구현하기 위해서는 Action으로 설정합니다.

여기에서 자동으로 생성되는 코드의 가장 앞에 `@IBAction`이라는 키워드에 대해 설명하겠습니다. IB는 Interface Builder의 약자로, Interface Builder를 통해 연결할 때 꼭 붙여야하는 키워드입니다. 코드로 추가할 경우에는 입력하지 않습니다.

Name은 생성되는 함수의 이름이며 이에 대한 파라미터는 가장 아래에 있는 Argument에서 선택할 수 있습니다. None, Sender, Sender and Event가 있으며, 파라미터가 없거나, Sender라는 이름의 파라미터가 한개, 혹은 Event라는 이름의 파라미터까지 두개 중 선택합니다. Event를 탭하면 여러가지 이벤트가 있고, 기본적으로 해당 컨트롤에 맞는 항목이 선택되어 있지만 이 과정에서 필요에 의해 변경이 가능합니다. 

[Code] 아래와 같이 입력합니다. UI 구성은 위와 동일합니다.

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__5.21.57.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-22__5.21.57.png)

@IBOutlet으로 버튼과 슬라이더를 연결합니다. 

그리고 함수를 선언하는데 action()을 사용하며, Interface Builder에서처럼 변수가 없거나, sender 하나이거나, 혹은 sender, event 두 가지를 갖도록 생성합니다. 여기에서 중요한 것은 **반드시 `와일드카드`가 있어야한다**는 점입니다. 이벤트가 발생할 때 콘솔에 함수의 이름을 출력하도록 구현했습니다.

이제 타겟과 액션을 연결해야하는데, 타겟과 액션을 연결할 때는 viewDidLoad() 함수 안에서 addTarget() 함수를 이용해 구현합니다. 첫번째 파라미터는 메서드가 구현되어 있는 객체 즉, 자기 자신을 입력합니다. 두번째 파라미터로는 Seletor 타입의 액션이 필요한데, 이를 위해 Selector로의 변환 과정(#selector(action(_:))이 필요합니다. 마지막 파라미터로는 어떤 동작이 있을 때 함수가 실행되는지 입력합니다. 

# 2. Button #1. Text Button

`Button`은 탭 이벤트를 처리하는 가장 기본적인 컨트롤입니다. Touch up inside가 기본이며, target-action 패턴을 따르고 있습니다. 미리 정의된 타입은 여섯가지이며 기본 타입 외 커스텀 타입을 구현할 수 있습니다.

1. system
2. detail disclosure
3. info light
4. info dark
5. add contact
6. close
7.  + custom

여기에서 2,3,4는 육안으로 보았을 때 구분이 불가능합니다. 

## State

버튼의 상태에는 네 가지가 있습니다.

1. default
2. highlighted
3. selecte
4. desabled

코드 인스펙터에서 다른 상태를 선택해도 버튼의 설정이 바뀌지 않습니다. 버튼이 해당 상태일때의 속성값을 각각 다르게 변경할 수 있도록 선택하는 것이며, 버튼의 설정을 바꾸고자 한다면 control의 state option에서 체크박스를 사용해야합니다.

체크박스는 `selected`, `enabled`, `highlighted` 총 세가지가 있고 중복 선택이 가능합니다.

처음 버튼을 생성했을 때는 default 상태이고 enabled에 선택이 되어있습니다.

반대로 disabled 상태로 변경하고자 할 경우 enabled의 체크를 해제합니다.

버튼의 상태를 변경하는 코드를 작성할 경우 버튼의 각 isEnabled, isHighlited, isSelected 를 true/false로 설정하거나, 혹은 toggle()하는 방식으로 작성합니다. 단, 초기화할 경우 세가지 속성을 모두 구현해야합니다.

## Text Button Attribute

텍스트 버튼의 속성은 코드 인스펙터에서 설정할 수 있습니다. 앞서 설명했듯 각 상태별 타이틀과 색상 등을 다르게 설정할 수 있으며 이 또한 코드로 작성이 가능합니다.

```jsx
btn.titleLabel?.backgroundColor = .systemYellow
btn.setTitle("Check States", for: .normal)
btn.setTitle("Haha Highlighted", for: .highlighted)
btn.setTitleColor(.systemRed, for: btn.state)
```

btn이라는 이름의 버튼을 아울렛으로 연결해 속성에 접근했습니다. 

titleLabel을 통해 배경색을 변경할 수 있지만, text나 color(font)는 변경이 불가능합니다. 이를 변경하기 위해서는 `UIButton클래스`에 정의된 함수인 `setTitle`과 `setTitleColor` 함수를 사용합니다. 주로 첫 파라미터에는 사용하고자 하는 텍스트와 컬러를 입력하고 두번째 파라미터로는 상태 속성을 전달합니다. 

# 3. Button #2. Image Button