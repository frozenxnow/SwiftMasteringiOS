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

## [Image Picker View Example] Slot Machine

빠칭코의 슬롯머신은 휠이 세개가 있고, 세 이미지가 모두 동일할 경우 잭팟이 터집니다.

이미지를 images 배열에 넣고, 셔플 버튼을 누를 때마다 이미지가 각 열에서 랜덤으로 배치되며, 세개가 모두 일치할 경우 알림창을 띄우는 애플리케이션을 만들었습니다.

여기에서 신경써야할 조건이 여러개 있습니다.

1. 슬롯의 이미지는 모두 연결되어 보여야 합니다. 첫 이미지나 마지막 이미지가 선택되었을 경우 이미지가 끊겨 보이지 않도록 합니다.
2. 이미지의 사이즈를 원본 사이즈보다 조금 크게 만듭니다.
3. 유저는 버튼 외 피커뷰를 직접 조작할 수 없습니다. 

우선 알아야 할 사항이 있습니다. 이전 Text Picker View에서는 `→ String?` 형태였으나 이번에는 이미지를 리턴하는 `→ UIView` 메서드를 사용합니다. 문자열에 비해 비교적 크기 때문에 피커뷰를 조작할 때마다 이미지뷰를 생성하기보다는 이미 생성된 이미지뷰가 있다면 그것을 재사용하는 방향으로 사용합니다.

```jsx
// UIPickerViewDelegate 
func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
	  if let imageView = view as? UIImageView {
	      imageView.image = images[row % images.count]
	      return imageView
	  }
	  let imageView = UIImageView()
	  imageView.image = images[row % images.count]
	  imageView.contentMode = .scaleAspectFit
	  
	  return imageView
}
```

마지막 파라미터로 전달되는 `view`는 UIView? 형태입니다. 이미 만들어진 이미지뷰가 있는지 없는지를 확인하는 과정입니다. 이미 생성된 이미지뷰가 있다면 if let 구문을 실행해 해당 이미지뷰를 재사용합니다. 

view가 UIImageView의 형태라면 그 view를 imageView라는 임시변수에 저장해 if let 구문을 수행합니다. 

imageView의 이미지에 view의 번호에 해당하는 이미지를 넣고 그 이미지뷰를 리턴합니다.

만약 생성된 이미지뷰가 없을 경우 아래의 코드를 실행합니다. 새로운 UIImageView를 생성하고 마찬가지로 전달받은 순번의 이미지를 imageView의 이미지에 삽입합니다. 이때 imageView에 이미지가 배치되는 contentMode를 설정해야합니다. 

이미지뷰를 리턴합니다.

복잡해보이지만 이게 기본적인 방식인 것 같고, 코드를 조금 더 자유자재로 사용한다면 아주아주 쉬운 코드일것 같습니다! 

이미지 목록이 끊임없어 보이도록 하기 위해 출력되는 데이터의 수를 늘립니다. 우선 휠의 개수는 세개, 그리고 위/아래가 끊기지 않아 보이도록 우리는 중간에 있는 이미지만 사용자에게 보여줄 예정입니다. 

```jsx
extension ImagePickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count * 3 // 무한 스크롤 효과
    }
}
```

이미지의 사이즈를 조절합니다.

```jsx
// UIPickerViewDelegate
func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
	  return 60
}
```

피커뷰에서의 터치 이벤트를 비활성화합니다.

```jsx
override func viewDidLoad() {
	  super.viewDidLoad()
	  picker.isUserInteractionEnabled = false
}
```

셔플 버튼을 구현합니다.

```jsx
@IBAction func shuffle(_ sender: Any?) {
    let firstIndex = Int.random(in: 0..<images.count) + images.count
    let secondIndex = Int.random(in: 0..<images.count) + images.count
    let thirdIndex = Int.random(in: 0..<images.count) + images.count
    
    // pickerView에서 특정한 항목을 선택하는 함수 selectRow()
    picker.selectRow(firstIndex, inComponent: 0, animated: true)
    picker.selectRow(secondIndex, inComponent: 1, animated: true)
    picker.selectRow(thirdIndex, inComponent: 2, animated: true)
}
```

셔플 버튼을 누르면 랜덤으로 두번째 이미지 목록 중 한 그림이 랜덤으로 나옵니다. 슬롯은 총 세개이므로 랜덤한 숫자를 세개 만들어야하는데, 0부터 images.count 미만의 숫자 중 하나를 랜덤으로 고르고 그 숫자에 images.count를 더해 두번째 이미지 목록에서의 이미지가 나오도록 구현합니다. 

그리고 `selectRow()` 함수를 사용해 특정한 순번의 이미지가 선택되도록 코드를 구현합니다.

이제 사용자는 셔플 버튼이 아닌 것을 조작할 수 없고, 이미지는 랜덤으로 출력되는 슬롯머신을 작동할 수 있습니다.

도전과제로 잭팟이 터졌을 경우 게임을 종료하는 코드를 작성하라고 하셨는데, 저는 alert 창을 만들어 게임이 종료됨을 사용자에게 알려주었습니다.

그리고 추가로 게임을 시작할 때 첫 이미지 목록을 동일하게 보여지도록 코드를 구현했습니다.

```jsx
@IBAction func shuffle(_ sender: Any?) {
    // 세개가 일치하면 게임이 끝나는 알림창 띄우기
    let alert = UIAlertController(title: "잭팟ㅋ", message: "ㅊㅋㅊㅋ!!", preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: .default)
    alert.addAction(okAction)
    if firstIndex==secondIndex && secondIndex == thirdIndex {
        present(alert, animated: false, completion: nil)
    }    
}

override func viewDidLoad() {
    super.viewDidLoad()
    picker.isUserInteractionEnabled = false
    
    // 첫 선택 이미지를 두번째 바퀴의 첫번째 그림으로 설정
    picker.selectRow(images.count, inComponent: 0, animated: true)
    picker.selectRow(images.count, inComponent: 1, animated: true)
    picker.selectRow(images.count, inComponent: 2, animated: true)
}
```

# 5. Page Control #1

페이지 컨트롤은 바탕화면에서 찾아볼 수 있습니다. 페이지 컨트롤은 페이지의 개수와 현재 페이지를 표시하는 `page indicator`를 가지고 있습니다. 

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-25__2.45.06.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-25__2.45.06.png)

이 인디케이터는 두가지 색상으로 이루어져있으며

기본 색상인 `Tint color`와

현재 페이지를 타나내는 `Current color`를

설정할 수 있습니다.

1. 페이지컨트롤 레이블을 추가해 Outlet으로 코드와 연결합니다.
2. viewDidLoad() 함수 내에서 페이지 컨트롤을 초기화합니다. 
(생성할 페이지 인디케이터의 개수와 색상 등을 설정할 수 있습니다.)
3. 페이지 컨트롤과 컬렉션뷰 페이지를 연결합니다.
→ 코드와 연결한다고 해서 자동으로 페이지를 인식하는것이 아니라 현재 컬렉션뷰와 페이지컨트롤은 별개입니다. 이를 연결한 후 컬렉션뷰를 스크롤할 때마다 현재 페이지를 계산해 current page에 저장하도록 구현합니다.
4. 페이지 컨트롤을 Action으로 연결해 인디케이터를 탭할 때 페이지가 이동하는 Value Change Action을 구현합니다. 이 때 Action의 타입은 UIPageController로 선택합니다. 

```jsx
// 1.
@IBOutlet weak var pager: UIPageControl!

// 2.
override func viewDidLoad() {
    super.viewDidLoad()
    pager.numberOfPages = list.count
    pager.currentPage = 0
    
    pager.pageIndicatorTintColor = UIColor.systemGray3 // 기본 컬러 저장 
    pager.currentPageIndicatorTintColor = UIColor.systemRed // current Page 컬러 저장
    
}

// 3.
extension PageControlViewController: UIScrollViewDelegate { // UIScrollViewDelegate 채용
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width // 페이지 계산을 위한 너비 저장 
        let x = scrollView.contentOffset.x + (width/2) // 현재 스크롤한 x좌표 저장, 보정을 위해 너비의 절반을 더합니다.
        
        let newPage = Int(x/width) // 새로운 페이지 계산 후 저장 
        if pager.currentPage != newPage { // 해당 페이지로 이동 
            pager.currentPage = newPage
        }
    }
}

// 4.
@IBAction func pageChanged(_ sender: UIPageControl) {
    let indexPath = IndexPath(item: sender.currentPage, section: 0)
    listCollectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
}
```

마지막 4번 함수의 경우 실제로 인디케이터를 탭했을 때 좌우로 이동하는 페이지를 확인할 수 있지만, 해당 인디케이터를 터치한다고 해서 그 페이지로 이동하는 것이 아니라, 가운데를 기준으로 좌우로만 페이지가 넘어가는 것을 확인할 수 있습니다. 이는 터치 영역이 매우 작기 때문에 생기는 한계입니다.

# 6. Slider #1

thumb를 수평으로 드래그하여 지정된 범위 내의 값을 선택하는 컨트롤입니다.

코드 인스펙터에서 최소값과 최대값, 초기값을 설정할 수 있으며 thumb를 움직일 때마다 value changed 이벤트가 반복적으로 전달됩니다. 이 이벤트는 target-action pattern으로 처리합니다.

슬라이더를 세개 추가하고, RGB color를 변경해 배경 색으로 지정하는 코드를 만들기 위해 슬라이더를 아울렛으로 각각 연결하고, @IBAction을 추가합니다. 이 함수는 슬라이더 세개가 동작할 때마다 실행되어야하기 때문에 함수를 구현하는 코드 생성 후 한 함수를 모두 세 슬라이더에 연결합니다. 

RGB 값을 모두 입력받아 각각을 변수에 저장하는데, UIColor를 사용한 색을 얻기 위해서는 이 값을 CGFloat로 바꾸어야합니다. 

```jsx
let r = CGFloat(redSlider.value)
let g = CGFloat(greenSlider.value)
let b = CGFloat(blueSlider.value)
```

그리고 이렇게 구한 r,g,b를 사용해 배경색으로 지정합니다. root-view인 view를 이용합니다.

```jsx
let newColor = UIColor(red: r, green: g, blue: b, alpha: 1)
view.backgroundColor = newColor
```

여기에서 만든 이 함수는 슬라이더가 동작할 때마다 valueChanged 이벤트가 반복적으로 전달될 때마다 실행되기 때문에 슬라이더를 동작함과 동시에 바탕화면의 color가 변하는 것을 확인할 수 있습니다.

코드 인스펙터가 아니라 코드를 사용해 초기 값과 최소값, 최대값을 지정할 수 있습니다.

# 7. Slider #2

슬라이더의 틴트컬러와 이미지 속성은 배타적인 요소로 둘 중 하나만 설정이 가능합니다. 

thumb의 이미지는 코드를 사용해 변경이 가능합니다.

```jsx
let img = UIImage(systemName: "lightbulb") 
slider.setThumbImage(img, for: .normal)
slider.minimumTrackTintColor = UIColor.systemRed
slider.maximumTrackTintColor = UIColor.black

slider.thumbTintColor = UIColor.blue
slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
```

`slider.setThumbImage(img, for: .normal)` : img에 저장된 이미지를 thumb 이미지로 사용합니다. 두번째 파라미터는 상태를 입력하는데, 실제로 앱을 만들 때에는 모든 상태에 대하여 설정합니다.

`slider.minimumTrackTintColor`, `slider.maximumTrackTintColor` : 슬라이더의 막대 색상을 지정합니다.

`slider.thumbTintColor` : thumb의 색을 설정합니다.

`slider.setMinimumTrackImage()`, `slider.setMaximumTrackImage()` : 최소, 최대의 이미지를 설정합니다.

코드 인스펙터의 events를 살펴보면 `Continuous Updates`에 체크가 되어있습니다. 이 경우 thumb를 움직일 때마다 value changed 이벤트가 반복적으로 실행되며, 체크를 해제하면 thumb에서 손을 떼는 순간에만 value changed 이벤트가 실행됩니다. 

# 8. Segmented Control

두개 이상의 버튼을 하나로 묶어둔 형태로, 연관된 옵션 중 하나만을 선택할 수 있는 컨트롤입니다. 

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-28__8.22.28.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-28__8.22.28.png)

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-28__8.27.55.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-28__8.27.55.png)

- State의 Momentary에 기본적으로 체크가 해제되어 있고, 체크할 경우 선택한 상태를 유지하지 않습니다.
- Segments의 수를 직접 지정하고 그 이름을 Title에 저장할 수 있습니다.
- Segments의 수는 1일 경우 Segmented Control을 사용하는 의미가 없기 때문에 그 수로 1을 지정할 수 없습니다.
- segmented control을 사용하기 위해서는 @UIAction을 추가해야합니다.

Label의 Textalignment를 변경하는 코드를 작성합니다. segments의 수는 left, center, right의 세 가지이며 각 값을 선택할 때 Label의 textalignment 속성이 변경됩니다. 

```jsx
@IBOutlet weak var label: UILabel!
@IBOutlet weak var segmentedControl: UISegmentedControl!

@IBAction func alignmentChanged(_ sender: UISegmentedControl) {

	  label.textAlignment = NSTextAlignment(rawValue: sender.selectedSegmentIndex) ?? .center

}

override func viewDidLoad() {

    super.viewDidLoad()
    segmentedControl.selectedSegmentIndex = label.textAlignment.rawValue 

}
```

`label.textAlignment = NSTextAlignment(rawValue: sender.selectedSegmentIndex) ?? .center`

레이블의 정렬을 sender(segmented control)에서 선택된 index값을 NSTextAlignment로 바꾸어 변경합니다. 만약 선택된 값이 nil이라면 `.center`를 리턴합니다.

`segmentedControl.selectedSegmentIndex = label.textAlignment.rawValue`

segmentedControl에서 선택되는 초기 값을 label의 초기 Alignment의 rawValue 값으로 저장합니다. 

momentary 속성은 코드로도 제어가 가능합니다. 스위치를 토글하여 momentary 속성을 true/false로 제어하는 방법입니다.

```jsx
@IBOutlet weak var momentarySwitch: UISwitch!

override func viewDidLoad() {
    super.viewDidLoad()
    segmentedControl.selectedSegmentIndex = label.textAlignment.rawValue
    momentarySwitch.isOn = segmentedControl.isMomentary
}

@IBAction func toggleMomentary(_ sender: UISwitch) {
    segmentedControl.isMomentary = sender.isOn
}
```

`@IBOutlet weak var momentarySwitch: UISwitch!` 우선 스위치를 @IBOutlet으로 연결한 후,

`momentarySwitch.isOn = segmentedControl.isMomentary` viewDidLoad()에서 초기 값을 설정합니다.

Momentary 속성에 체크되어 있을 경우 스위치가 On, momentary에 체크되어있지 않은 경우 스위치가 Off됩니다.

그 다음 스위치와 연결한 @IBAction을 구현합니다. 스위치의 상태에 따라 Control의 momentary 속성의 상태가 변경됩니다.

```jsx
segmentedControl.setTitle("왼쪽", forSegmentAt: 0)
segmentedControl.setTitle("중앙", forSegmentAt: 1)
segmentedControl.setTitle("오른쪽", forSegmentAt: 2)
```

물론 viewDidLoad() 내에서 각 segments의 타이틀을 위와 같은 함수를 사용해 변경할 수 있습니다.

Segmented Control의 Segment를 추가하고 지우는 함수가 존재합니다.

```jsx
@IBAction func insertSegment(_ sender: Any) {
    guard let title = titleField.text, title.count > 0 else {
        return
    }
    segmentedControl.insertSegment(withTitle: title, at: segmentedControl.numberOfSegments, animated: true)
    titleField.text = nil
    
}

@IBAction func removeSegment(_ sender: Any) {
    guard let title = titleField.text, title.count > 0 else {
        return
    }
    for i in 0..<segmentedControl.numberOfSegments {
        if let currentTitle = segmentedControl.titleForSegment(at: i), currentTitle == title {
            segmentedControl.removeSegment(at: i, animated: true)
        }
    }
    titleField.text = nil
}
```

화면에는 segmented control과 텍스트를 입력하는 titleField와 두 버튼이 있습니다. 이 버튼들은 액션으로 연결되어 있고 titleField에 입력된 이름의 segment를 추가하거나 찾아서 삭제하는 메서드입니다.

우선 `guard let`을 사용해 title에 입력받은 값을 저장합니다. 

insert 버튼을 클릭했을 때 title에 입력된 값이 있다면 그 title을 insertSegment 함수를 사용해 가장 끝(segmentedControl.numberOfSegments)에 추가합니다.

remove 버튼을 클릭했을 때 title에 입력된 값이 있다면 그 title을 removeSegment 함수를 사용해 삭제합니다. 우선 일치하는 텍스트를 찾기 위해 for in문을 사용해 비교하는 작업을 segmentedControl의 Segments 수만큼 반복합니다. 첫번째 segments부터 currentTitle에 저장하고, title과 같다면 그 인덱스에 해당하는 segment를 삭제하는 코드입니다. 

두 버튼은 모두 실행 후 titleField에 입력된 값을 삭제합니다. 

UISegmentedControl 클래스가 제공하는 method를 사용해 Segmented control의 UI를 변경할 수 있습니다.

```jsx
let normalImage = UIImage(named: "segment_normal")
let selectedImage = UIImage(named: "segment_selected")

segmentedControl.setBackgroundImage(normalImage, for: .normal, barMetrics: .default)
segmentedControl.setBackgroundImage(selectedImage, for: .selected, barMetrics: .default)
```

이미지를 변수에 저장하고, setBackgroundImage를 사용해 상태별로 배경을 지정합니다. 각 segments 사이가 부자연스럽기 때문에 이에 맞는 이미지를 사용해 dividerImage를 설정합니다.

```jsx
segmentedControl.setDividerImage(UIImage(named: "segment_normal_normal"), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
segmentedControl.setDividerImage(UIImage(named: "segment_normal_selected"), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
segmentedControl.setDividerImage(UIImage(named: "segment_selected_normal"), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
```

setDividerImage를 사용해 사이사이의 이미지를 변경했습니다. 왼쪽과 오른쪽이 각각 normal, selected일 때를 모두 고려하여 세 가지 경우의 코드를 작성합니다. 

dividerImage를 설정해서 양 끝 텍스트 alignment가 부자연스럽습니다. 이를 보완하기 위해 특정 이미지의 너비를 조작해 양 끝 너비를 조절해야하고, highlighted에 대한 설정이 없어 부자연스러운 부분이 생기는데, 이 또한 highlighted 상태에 normal 이미지를 나타내도록 구현해야합니다.

이 모든것을 조작한 후에도 부자연스러운 부분이 발생합니다. 때문에 이는 최대한 작게 만들어야 하며, 보통 이런 방법보다는 다른 방법을 사용해 구현합니다. 

정리하지 않겠습니다

# 9. Switch

스위치는 ON/OFF 상태를 구현하는 컨트롤입니다. 다른 컨트롤에 비해 아주 간단하며, 인스펙터에서 조작할 수 있는 항목도 다섯가지 뿐입니다. 그중 title과 style은 iOS 앱개발에서 사용하지 않으므로, 조작할 수 있는 항목은 총 세가지입니다. On, Off의 상태를 선택하고 상태별 색상을 선택할 수 있습니다. 

스위치는 @IBAction으로 연결해 스위치가 가지고 있는 isOn 속성을 조작합니다. 

```jsx
class SwitchViewController: UIViewController {
    @IBOutlet weak var bulbImageView: UIImageView!
    @IBOutlet weak var testSwitch: UISwitch!
    
    @IBAction func changedValue(_ sender: UISwitch) {
        bulbImageView.isHighlighted = sender.isOn
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        testSwitch.isOn = bulbImageView.isHighlighted
    }
}
```

우선 viewDidLoad()에서 스위치를 초기화합니다. `testSwitch.isOn = bulbImageView.isHighlighted` 스위치가 On 상태일 때 bulbImageView는 highlighted 상태의 이미지를 보여주는 것입니다. 이미지뷰의 속성에서 Normal 상태의 이미지와 Highlighted 상태의 이미지를 각각 저장해둔 상태입니다. 

그리고 ChangedValue() 함수에서 이미지뷰가 변경되도록 구현합니다. sender(switch)의 상태가 isOn일 경우 highlighted 이미지뷰를 전달합니다.

toggle이라는 이름의 버튼을 추가했습니다. 해당 버튼으로 스위치를 조작할 수 있지만, `testSwitch.isOn.toggle()`을 사용할 경우 두가지 문제가 발생합니다. 부자연스러운 움직임과, 스위치는 조작되지만 연결된 액션 메서드는 실행되지 않는다는 점입니다.

```jsx
@IBAction func toggle(_ sender: Any) {
    testSwitch.setOn(!testSwitch.isOn, animated: true)
    changedValue(testSwitch)
} 
```

위와같이 코드를 작성한다면 두 가지 문제점을 해결할 수 있습니다.

`testSwitch.setOn(!testSwitch.isOn, animated: true)`

제공되는 setOn() 함수를 사용합니다. 첫번째 파라미터로는 현재 스위치의 반대되는 값을 저장하고, 두번째 animate는 부드럽게 동작하도록 true를 전달합니다. 

다음은 이미지가 업데이트 될 수 있도록 이전에 구현한 changedValue() 액션을 호출합니다. 파라미터로는 스위치를 전달합니다.

결과적으로 토글 버튼을 누를 경우에도 이미지가 전환되고, 스위치가 부드럽게 전환되는 것을 확인할 수 있습니다. 

setOn() 함수에 대해 알아야겠다고 생각했는데, 개발자문서를 읽어봐도 아직 이해하지 못하겠습니다.

추후에 수정하겠습니다.

# 10. Stepper

Stepper는 지정된 범위 내의 숫자를 증가시키고 감소하는 두개의 버튼을 가진 컨트롤입니다.

인스페겉를 살펴보면 초기값을 설정하는 value, 최소값, 최대값을 설정하는 minimum, maximim이 있습니다. 그리고 체크박스 세 개가 있는데, autorepeat는 터치하는동안 반복적으로 해당 버튼이 눌리도록 하며 continuous는 터치가 반복적으로 실행되는동안 값 변화를 보일지 보이지 않을지에 대해 설정합니다. 마지막으로 wrap은 값의 순환을 설정합니다. 값이 On일 경우 값은 순환합니다. 

각 체크박스를 스위치버튼으로 연결하고, 토글하는 메서드를 연결했습니다. 그리고 stepper에 저장된 value를 label에 표기하고, 스위치의 활성화에 따라 stepper의 `.autorepeat`, `.isContinuous`, `.wraps` 속성을 변경합니다.

```jsx
@IBOutlet weak var valueLabel: UILabel!
@IBOutlet weak var valueStepper: UIStepper!
@IBOutlet weak var autorepeatSwitch: UISwitch!
@IBOutlet weak var continuousSwitch: UISwitch!
@IBOutlet weak var wrapSwitch: UISwitch!

@IBAction func toggleAutorepeat(_ sender: UISwitch) {
    valueStepper.autorepeat = sender.isOn
}

@IBAction func toggleContinuous(_ sender: UISwitch) {
    valueStepper.isContinuous = sender.isOn
}

@IBAction func toggleWrap(_ sender: UISwitch) {
    valueStepper.wraps = sender.isOn
}

@IBAction func valueChanged(_ sender: UIStepper) {
    valueLabel.text = "\(sender.value)"
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    autorepeatSwitch.isOn = valueStepper.autorepeat
    continuousSwitch.isOn = valueStepper.isContinuous
    wrapSwitch.isOn = valueStepper.wraps
}
```

# 11. Activity Indicator View

Activity Indicator View는 작업 완료 시점을 정확히 알 수 없는 상태에서 사용자에게 `작업이 진행중임`을 나타냅니다.

![System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-29__7.56.53.png](System%20View%20&%20Control%20549b77cae9ab4385a2d23d1fdcc95c96/_2021-03-29__7.56.53.png)

Style은 activity indicator의 스타일을 지정하고, Color은 색상을 지정합니다.

Animating에 체크를 할 경우 빙글빙글 돌아가는듯 움직이며 Hides When Stopped를 체크하면 작업이 종료될 때 activity indicator view가 사라집니다. 

주로 Animating, Hides When Stopped 속성은 모두 체크된 상태로 실행합니다.

위 상태를 제어하는 코드를 작성하겠습니다. 

```jsx
@IBOutlet weak var loading: UIActivityIndicatorView!
@IBOutlet weak var hiddenSwitch: UISwitch!

@IBAction func toggleHidden(_ sender: UISwitch) {
    loading.hidesWhenStopped = sender.isOn
}

@IBAction func start(_ sender: Any) {
    if !loading.isAnimating {
	    loading.startAnimating()
    }
}

@IBAction func stop(_ sender: Any) {
    if loading.isAnimating {
        loading.stopAnimating()
    }
}

override func viewDidLoad() {
    super.viewDidLoad()
    
    loading.startAnimating()
    hiddenSwitch.isOn = loading.hidesWhenStopped
}
```

toggleHidden 스위치가 on 상태일때 loading의 hides when stopped 속성이 활성화됩니다. 이 때 stop 버튼을 클릭해 animating을 중지하면 loading은 화면에서 보이지 않게 됩니다. 

start 버튼을 탭할 경우 loading이 animating 상태가 아닐 때 animating을 시작합니다.

반대로 stop 버튼을 탭할 경우 loading이 animating 상태일 때 animating 동작을 중지합니다. 

# 12. Progress View

Activity Indicator View와는 달리 작업 진행 속도와 작업완료 시점을 알 때 사용자에게 이를 보여주기 위해 사용합니다.

상태바는 tint color, progress tint color를 각각 설정할 수 있고, 처음 입력되는 progress는 0.0 ~ 1.0 사이의 값으로 설정할 수 있습니다. 코드 인스펙터에서 설정할 수 있지만 코드로도 구현이 가능합니다. 

```jsx
@IBOutlet weak var progressBar: UIProgressView!
  
@IBAction func update(_ sender: Any) {
//  progressBar.progress = 0.8 // 부자연스럽게 변화합니다 
    progressBar.setProgress(0.8, animated: true)
}
override func viewDidLoad() {
    super.viewDidLoad()
    
    progressBar.progress = 0.0
    progressBar.progressTintColor = UIColor.systemRed
    progressBar.tintColor = UIColor.systemGray
    
}
```

초기 설정은 viewDidLoad()에서 설정합니다. progress는 처음 0.0이고, 틴트컬러는 회색, 진행 컬러는 빨간색으로 설정했습니다. 버튼을 클릭하면 progress가 0.8로 업데이트 되는 action을 구현하는데, progress 속성을 바로 0.8로 변경하는 코드는 시각적으로 매우 부자연스럽기 때문에 setProgress를 통해 애니메이션을 함께 전달합니다.