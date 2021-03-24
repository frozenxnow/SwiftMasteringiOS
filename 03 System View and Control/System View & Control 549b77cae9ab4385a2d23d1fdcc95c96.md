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

코드 인스펙터에서 버튼의 이미지 속성을 변경할 경우 버튼이 System(기본)타입에서 `Custom` 타입으로 변경됩니다. 텍스트 컬러는 초기 `default` 값인 system 컬러로 설정되며 커스텀 타입으로 변경될 경우 default 컬러가 변경되어 이미지와 함께 출력되는 텍스트의 색상이 변경됩니다. 이 때 직접 색상을 직접 다른 색으로 변경할 수 있습니다. 

만약 루트뷰의 틴트 컬러를 특정한 색상으로 설정하고 (system타입)버튼을 추가하면 텍스트 색상은 루트뷰의 틴트 컬러를 따라가지만, 이 또한 직접 색상을 변경할 수 있습니다. 

버튼은 이미지를 텍스트의 왼쪽에 배치합니다. 이미지를 원하는 위치에 배치하는 방법을 제공하지 않지만 `transform` 속성을 조작할 경우 가능해집니다. attribute에서 semantic option을 변경해 force~ 를 선택하여 변경할 수 있지만 이렇게 변경할 경우 제대로 동작하지 않는 일이 발생할 수 있어 추천하지 않습니다. 

**이미지뷰, 레이블, 버튼, 스택뷰를 사용해 원하는 레이아웃을 구현할 수 있습니다.**

1. 화면에 이미지뷰와 레이블을 추가합니다. 이미지뷰를 특정 이미지로 선택합니다.
2. 이미지뷰와 레이블을 함께 선택한 후 스택뷰를 선택하면 각 레이블이 스택뷰에 임베드됩니다. 
이 경우 각 이미지와 레이블에 따라 자동으로 크기가 설정되는데 제약을 추가함으로써 사이즈를 조절할 수 있습니다. 
3. 스택뷰를 선택한 상태에서 뷰를 클릭하면 스택뷰가 일반 뷰에 임베드됩니다. 
4. 다시 한번 스택뷰를 선택하고 영역 전체를 추가하도록 제약을 추가합니다. (상하좌우0)
5. 버튼은 스택뷰 내부가 아니라 스택뷰 위에 와야합니다. 스택뷰와 동일한 계층으로 추가할 수 있도록 도큐먼트 아웃라인을 이용합니다. 
6. 버튼의 텍스트를 삭제하고 도큐먼트를 선택합니다. 제약에서 리딩(좌)과 바텀(하)의 값을 0으로 설정합니다. 
7. 이렇게 생성된 버튼 이미지에서는 도큐먼트 아웃라인에서 순서를 바꾸어주면 좌우 혹은 상하 위치를 쉽게 변경할 수 있고, 스택뷰를 선택해 Axis(축)을 변경하면 이미지와 레이블을 가로로 나열할지 세로로 나열할지 결정할 수 있습니다.

## background-image

background-image를 설정하기 위해 width, height 제약을 추가합니다. background-image를 선택할 경우 종횡비가 망가지기 때문에 이를 수정하기 위해 content mode를 변경해야하는데, 코드 인스펙터에 있는 content mode는 버튼 자체에 대한 속성입니다. 이미지를 수정하기 위해서는 버튼의 이미지뷰에 접근해야하는데, 배경 이미지에 접근하는 속성은 제공하지 않습니다. 

그래서 위에서 사용한 방법을 통해 버튼을 새롭게 생성해야합니다. (스택뷰 이용)

## code

```jsx
class ImageButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImage = UIImage(named: "plus-normal")
        let highlightedImage = UIImage(named: "plus-highlighted")
        
        btn.setImage(normalImage, for: .normal)
        btn.setImage(highlightedImage, for: .highlighted)

    }
}
```

이 외에도 background image를 설정하는 `setBackgroundImage()` 함수도 있습니다.

# 4. Picker View #3. Text Picker

Cocoa touch에서 제공하는 기본 피커뷰는 두가지가 있습니다.

1. Date Picker : UI와 Data가 자동으로 제공됩니다.
2. Picker View : 표시할 데이터를 직접 입력하고 뷰를 구성해야합니다. 

## Picker View

피커뷰에서 데이터를 입력하고 뷰를 구성하기 위해서는 두 가지 프로토콜을 채용해야합니다.

### [UIPickerViewDataSource Protocol]

구현을 해야하는 필수 메서드가 두 개 있습니다.

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-24__5.57.21.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-24__5.57.21.png)

- func numberOfComponents(in pickerView: UIPickerView) -> Int
return n : 휠의 개수를 n개 리턴합니다.
- func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
return m : 각 선택지 m개를 리턴합니다.

### [UIPickerViewDelegate Protocol]

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-24__6.01.16.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-24__6.01.16.png)

- 필수 메서드는 존재하지 않지만 적어도 하나를 구현해야 올바른 데이터가 피커뷰에 출력됩니다.
- func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? : String
 : 텍스트 형식의 데이터를 나타냅니다.
- func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
 : 커스텀 뷰를 나타냅니다.
- func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) 
: 특정 항목이 선택되었을 때 처리해야하는 이벤트를 구현합니다.

```jsx
class TextPickerViewController: UIViewController {   
    let devTools = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    let fruits = ["Apple", "Orange", "Banana", "Kiwi", "Watermelon", "Peach", "Strawberry"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TextPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 휠의 수 리턴
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devTools.count // 선택지 수(데이터의 개수) 리턴
}
extension TextPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devTools[row] // 선택지 내용 리턴
}
```

protocol은 extension을 사용해 채용하며 UIPickerViewDataSource의 필수 함수를 모두 구현하고, 데이터 출력을 위해 UIPickerViewDelegate의 함수를 구현합니다. 데이터는 String 타입이기 때문에 String을 리턴하는 함수를 선택해 구현합니다. 

만약 numberOfComponents() 함수에서 두 개 이상의 숫자를 리턴하는 경우 데이터의 개수와 데이터를 출력하는 함수에서는 switch문을 사용해 각 케이스별로 데이터를 전달합니다.

```jsx
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
        return devTools.count
    case 1:
        return fruits.count
    default:
        return 0
    }
}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch component {
    case 0:
        return devTools[row]
    case 1:
        return fruits[row]
    default:
        return ""
    }
}
```

## Picker View - Action

항목을 선택과 동시에 처리해야하는 이벤트와, 항목 선택 후 특정 액션을 취했을 때 처리해야하는 이벤트를 나누어 살펴보겠습니다. 

앞서 설명했던 UIPickerViewDelegate Protocol의 함수 중 `func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)` 함수는 항목을 선택함과 동시에 처리되는 이벤트를 구현합니다.

```jsx
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  switch component {
  case 0:
      label.text = devTools[row]
      return
  case 1:
      label.text = fruits[row]
      return
  default:
      return
  }
}
```

위 함수는 UIPickerViewDelegate 프로토콜에 존재하는 함수이기 때문에 프로토콜을 채용하는 extension에서 구현합니다. row는 선택된 데이터의 순번을 저장하고 component로 각 휠을 구분합니다. 

예를 들어 항목선택 후 버튼을 클릭했을 때 일어나는 이벤트를 구현하고자 한다면 아래와 같이 구현합니다. 피커뷰는 outlet으로, 버튼은 action으로 연결합니다.

```jsx
@IBOutlet weak var picker: UIPickerView!
    
@IBAction func report(_ sender: Any) {
		let fruitSelectedRow = picker.selectedRow(inComponent: 0)
		let devToolsSelectedRow = picker.selectedRow(inComponent: 0)
		guard fruitSelectedRow >= 0 && devToolsSelectedRow >= 0 else {
		    print("not found")
		    return
		}
		print(fruits[fruitSelectedRow], devTools[devToolsSelectedRow])
}
```

picker에 접근해 `selectedRow()`로 데이터의 순번을 가져와 변수에 저장하고, 순번이 0 이상일 경우 콘솔에 해당 데이터를 출력하도록 구현했습니다.