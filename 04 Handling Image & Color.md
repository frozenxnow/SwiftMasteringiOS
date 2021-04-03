# Handling Image & Color

# 1. Image View (Xcode12)

이미지뷰 label을 속성하면 인스펙터에서 이미지를 직접 지정할 수 있고 물론 코드로도 입력이 가능합니다. 잘 알아야 할 속성 중 하나는 Content Mode인데, 이미지뷰와 이미지의 크기가 다를 때 이미지를 나타내는 옵션입니다. 가장 많이 사용하는 옵션은 `Aspect Fit`으로 이미지의 종횡비를 유지하며 모든 이미지가 프레임 안에 나타날 수 있도록 출력됩니다. 또한 `Aspect Fill`도 많이 사용되는데 이 또한 종횡비가 유지되지만 이미지가 프레임을 꽉 채우도록 표현되기 때문에 프레임을 벗어나는 이미지가 발생할 수 있습니다. 이 때 속성값 중 Clips to bounds에 체크를 할 경우 프레임을 벗어나는 이미지는 보이지 않고 반대로 체크를 해제하면 프레임 즉, 이미지뷰를 벗어난 이미지도 존재합니다. 

인스펙터에서 이미지뷰의 `Highlighted` 상태를 설정할 수 있습니다. 다른 이미지를 설정할 수 있기 때문에 이러한 기능은 이미지 토글이 필요한 경우 사용합니다. 이미지 토글이 필요한 경우 또 다른 이미지뷰를 생성해야겠다고 생각했지만 그보다는 토글이 데이터 사용에도 용이하고 코드 작성도 간편합니다. 이렇게 highlighted 옵션에 추가한 후 필요할 때마다 불러오는 방식으로 사용합니다. 

이미지는 `Instrinsic content size`를 가지고 있습니다. 각각의 크기를 가지고 있으며, 이미지뷰를 먼저 추가하고 이미지를 넣었을 때에는 Content mode에 따라 이미지가 리사이징 되기 때문에 알 수 없지만 이 이미지뷰에 특정 제약을 추가할 경우 사이즈는 다시 본래의 크기로 조정되어 이미지뷰의 사이즈도 변경됩니다. 이때 이미지를 삭제하면 기준이 되는 이미지가 없어지는 것이기 때문에 제약 오류가 발생합니다. 

이미지는 .jpg, .png 등 표준 이미지를 허용하지만 .gif의 움직이는 이미지는 허용하지 않습니다. 그러나 애니메이션을 사용해 움직이는 듯한 이미지를 연출할 수 있습니다. 이미지 시퀀스를 사용한다고 표현합니다. 

```jsx
let images = [
	  UIImage(systemName: "speaker")!,
	  UIImage(systemName: "speaker.1")!,
	  UIImage(systemName: "speaker.2")!,
	  UIImage(systemName: "speaker.3")!
]
```

반복하고자 하는 이미지 시퀀스는 위와 같이 배열에 저장합니다.

```jsx
override func viewDidLoad() {
    super.viewDidLoad()
    imageView.animationImages = images
}
```

이미지뷰에 애니메이션을 생성하는 방법입니다. 

```jsx
@IBAction func startAnimation(_ sender: Any) {
    imageView.startAnimating()
}

@IBAction func stopAnimation(_ sender: Any) {
    if imageView.isAnimating {
        imageView.stopAnimating()
    }
}
```

화면에는 애니메이션을 실행하고 중지하는 각각의 버튼이 존재하고, 해당 버튼을 눌렀을 때 애니메이팅이 시작되거나 멈추도록 코드를 작성합니다. 이 때 중지하는 버튼에는 조건절을 추가했습니다. 만약 이미지가 작동하고 있다면 이미지를 멈추도록 구현합니다. 

현재 이 상태만으로도 반복되는 이미지를 화면에서 확인할 수 있습니다. 그러나 이미지의 전환 속도가 너무 빠르고 계속해서 반복되기 때문에 어느정도 조율이 필요합니다. 

애니메이션을 처음 생성했을 때 속도는 1초당 30 프레임이 출력되고 기본 반복 횟수는 무한대입니다. 이를 변경하기 위해 이미지뷰의 속성을 사용합니다.

```jsx
imageView.animationDuration = 1.0
imageView.animationRepeatCount = 3
```

animationDuration은 이미지가 전환되는 속도를 가리키는데 위와 같이 1.0으로 정의할 경우 모든 프레임이 1초동안 반복된다는 뜻입니다. 즉, 네장의 사진이기 때문에 사진은 한 장당 0.25초 씩 출력되는 것입니다. 

animationRepeatCount는 애니메이션이 반복되는 횟수를 지정합니다. 위와 같이 3으로 정의할 경우 애니메이션은 세 번 동작한 후 더이상 작동하지 않습니다. 기본값은 0으로 무한대를 의미합니다.

여기에서 추가적으로 알아야할 것이 있다면 시뮬레이터에서 화면을 구동했을 때 버튼을 누르기 전까지는 빈 화면이 보인다는 것입니다. placeholder가 필요합니다. 이는 인스펙터에서 이미지뷰의 초기 화면을 직접 이미지 시퀀스 중 하나로 지정하거나 코드에서 직접 images[0]을 이미지뷰에 보여지도록 초기값을 설정할 수 있습니다. 

# 2. Image #1

주로 .png 파일과 .jpg 파일을 사용합니다. 그 중 애플이 권고하는 형식은 `.png` 입니다.

프로젝트에 이미지를 삽입할 때에는 `Asset Library`를 사용합니다. 폴더 형태의 Asset Library는 프로젝트에서 사용하는 이미지를 모아둔 폴더입니다. 폴더를 열면 왼쪽에 리스트가 표시되는데 추가하고자 하는 이미지를 드래그 앤 드롭으로 추가할 수 있습니다. 

이미지를 하나 추가하고 화면을 보면 단순히 이미지가 추가되는 것이 아니라 Image Set이 추가된 것을 확인할 수 있습니다. 이는 말 그대로 이미지의 집합 형태입니다. 1x, 2x, 3x와 같은 숫자들이 있고 그 중 한칸에 이미지가 추가되는데, 이는 이미지의 스케일을 나타내는 것으로 1x는 저해상도, 2x는 일반적인 레티나 디스플레이, 그리고 3x는 고해상도 이미지를 저장합니다. Asset Library 인스펙터를 살펴보면 여러 디바이스를 추가할 수 있습니다. 지원하는 디바이스를 추가할 경우 각 스케일 별 이미지를 추가하도록 빈칸이 더 생기는데 각 항목마다 이미지를 추가해 많이 저장한다고 해서 성능에 영향을 주지는 않습니다. 이것이 Asset Library의 장점입니다. Asset Library에는 이미지를 출력하기 위해 디바이스별로 다양한 크기의 이미지를 가지고 있습니다. 그러나 애플리케이션을 다운로드 할 때 알아서 필요한 이미지만을 저장하도록 설계되어 있습니다. 

파일을 추가할 때 리스트로 드래그 앤 드롭을 하면 이미지는 1x에 저장됩니다. 그러나 파일 이름을 fileName@2x.png, fileName@3x.png와 같이 설정할 경우 앳 뒤에 오는 2x나 3x에 해당 이미지를 추가합니다. 혹은 이미 추가된 이미지에 대해서도 간편하게 드래그 앤 드롭으로 저장 위치를 변경할 수 있습니다.

이미지를 추가하는 방법은 이미지뷰를 추가한 후 인스펙터를 통해 이미지뷰에 이미지를 삽입하는 방법과, 이미지라이브러리에서 이미지를 선택해 바로 이미지를 삽입하는 방법이 있습니다. 

코드에서 이미지를 사용하는 방법에는 두가지가 있습니다. 

1. UIImage 사용 
2. ImageLiteral 사용

```jsx
let img1 = UIImage(named: "fileName")
let img2 = 🍎 
```

img2는 ImageLiteral을 사용해 추가하는 것입니다. 이렇게 코드에서 이미지를 곧장 볼 수 있다는 장점이 있지만 오류가 날 확률이 있고 Asset에서 해당 이미지를 나중에 삭제하게 되면 img1은 nil을 리턴하지만 img2를 사용하는 어플리케이션에서는 크래시가 발생합니다. 따라서 주로 img1(UIImage) 방법을 사용합니다.

코드를 사용해 이미지의 사이즈를 확인할 수 있습니다. img1?.size 이렇게 size 속성에 접근하면 img1의 크기를 point 단위로 리턴합니다.

```jsx
if let ptSize = img1?.size {
		print("Image Size(pt): \(ptSize))
}
```

만약 px 단위로 값을 표시하고 싶다면 pt 사이즈에 scale 값을 곱합니다. `px size = pt size * scale` 

```jsx
if let ptSize = img1?.size, let scale = img1?.scale {
		let pxSize = CGSize(width: ptSize.width * scale, height: ptSize.height * scale
		print("Image Size(px): \(pxSize))
}
```

몇가지 속성과 메서드를 더 살펴보겠습니다.

```jsx
img1?.cgImage
img1?.ciImage
```

기본적으로 UIImage 인스턴스와 ImageLiteral 인스턴스는 불변객체입니다. 따라서 이 인스턴스들은 비트맵 데이터에 직접 접근할 수 없는데 만약 필요한 경우가 생긴다면 코어그래픽스 혹은 코어이미지를 사용해야합니다. 여기에서 사용되는 이미지의 형식은 CGImage와 CIImage인데 위 코드와 같이 해당 속성을 이용하면 손쉽게 사용할 수 있습니다.

```jsx
img1?.pngData()
img1?.jpegData(param: 압축률)
```

이미지를 다른 곳으로 전송하거나 파일을 저장하기 위해서는 이미지를 binary형태로 변환해야합니다. 이 변환 과정에 쓰이는 함수는 위와 같습니다. 각각 png binary로, jpeg binary로 변환하는 함수입니다. .jaegData()의 경우 파라미터로 압축률을 받습니다. 여기에는 0.0부터 1.0까지의 숫자가 올 수 있고, 숫자가 낮을수록 압축률이 높고 숫자가 높을수록 이미지의 품질이 높아집니다.

# 3. Image #2

## Resizable Images

이미지 리사이징에 대해 알아보겠습니다. 

버튼을 추가하고 버튼의 background image로 특정 이미지를 선택했을 때 버튼의 크기에 맞게 이미지의 크기가 변하면서 깨지고 품질이 떨어지는 경우가 발생하는데, 이 때 리사이징이 필요합니다. 

Asset Library에서 배경이미지로 사용할 이미지를 선택한 후 인스펙터를 살펴보면 하단에 slicing에 대한 메뉴가 있습니다. 이미지 슬라이싱을 통해 이미지를 리사이징할 수 있습니다. 직접 드래그하여 영역을 선택하거나 인스펙터에서 직접 pt 값을 입력하면 됩니다. 가로나 세로, 혹은 가로와 세로를 조정하여 슬라이싱 영역을 선택할 수 있고, 색이 선명한 부분이 리사이징되어 우리가 사용하는 부분이고 희미하게 보이는 부분은 무시되는 영역입니다. 

기본적으로 타일 형태로 리사이징된 이미지가 나열되어 있는데 이는 인스펙터에서 tile → stretched로 변경하면 이미지가 크기에 맞게 늘어나게 됩니다. 

코드를 통해 리사이징 이미지를 생성하겠습니다. 버튼의 배경 이미지를 변경하기 위해 기존의 이미지를 리사이징하여 저장한 후, 버튼의 배경 이미지로 설정합니다.

```jsx
1. UIInset 구조체로 inset 값을 생성합니다. 이 부분은 리사이징 되지 않는 영역입니다.
let capInset = UIEdgeInset(top: 14, left: 14, bottom: 14, right: 14)

2. 새로운 resizable image를 생성합니다.
let bckImage = img.resizableImage(withCapInsets: capInset)

3. 버튼의 배경 이미지로 설정합니다.
btn.setBackgroundImage(bckImage, for: .normal)
```

첫번째 구한 capInset은 리사이징 시 제외되는 영역입니다. 이때 나머지(가운데) 부분이 resizable image 영역입니다. asset library에서 영역을 직접 드래그하면 필요한 부분만 선택이 가능하지만 이렇게 코드를 사용해 resizable image를 구할 때에는 나머지 모든 영역이 resizable image입니다. 

두번째로 resizableImage(withCapInsets:)를 사용해 새로운 resizable image를 생성했습니다. asset library에서와의 차이점으로, asset library에서 slicing할 경우 원본 이미지를 수정하는 반면 resizableImage 함수를 사용하면 새로운 이미지를 생성하고 리턴하게 됩니다. resizableImage(withCapInsets:) 함수에 파라미터가 하나 더 추가된 형태의 함수도 존재합니다. resizableImage(withCapInsets:resizingMode:) 함수는 리사이징된 이미지를 tile형으로 삽입할지 stretched형으로 삽입할지에 대한 선택이 가능합니다. asset library에서와 마찬가지로 기본값은 tile 입니다. 

## Vector Images

단순한 이미지의 경우 resizable image를 생성할 수 있지만 이미지가 복잡할 경우 이 방법을 사용할 수 없습니다. 이 때 사용할 수 있는 Vector Images입니다. 원본 크기로 추가했을 때에는 문제가 없던 이미지의 크기를 무작정 키웠을 경우 이미지 품질이 현저히 낮아집니다. 물론 크기에 맞는 다른 이미지를 추가하는 것도 하나의 방법이지만 벡터 이미지를 사용할 경우 한 장으로 해결이 가능합니다. 

Vector 이미지의 종류는 두가지 입니다.

1. PDF image: 낮은 버전부터 이용했기 때문에 거의 모든 기기에서 호환이 가능합니다. 그러나 변환이 번거롭다는 단점이 있습니다.
2. SVG image: ios13, xcode12부터 사용이 가능해졌으나 웹개발에서는 많이 사용하고 있고 유료서비스도 많이 사용하고 있습니다. 호환도 잘 되는 편이지만 배포 버전이 iOS 13보다 낮다면 사용하지 않는 편이 좋습니다. 

Vector 이미지를 추가할 때에는 기본 설정을 추가해야합니다. 이미지를 선택한 후 인스펙터에서 Resizing의 Preserve Vector Data에 체크하고 Appearances 속성을 Single Scale로 선택합니다. 

# 4. Image #3

Image Rendering과 template image에 대해 알아보겠습니다.

우선 Template Image란 이미지에서 컬러를 모두 제거하고 불투명한 영역을 모두 같은 색으로 채워넣은 이미지를 말합니다. 버튼이나 이미지뷰에 추가되는 이미지는 default 상태에서 그대로 출력되지만 특정한 경우에는 탬플릿 이미지가 추가됩니다. 

asset 폴더에 들어가 이미지를 선택한 후 인스펙터를 살펴보면 Render As 항목이 있습니다. 기본은 default로 설정되어 있는데 이는 컴퓨터가 자동으로 출력할 이미지를 선택합니다. 나머지 original image, template image는 늘 원본 이미지를 출력하거나 전부 탬플릿 이미지로 출력할 때 사용합니다.

코드로 설정이 가능합니다. 

```jsx
@IBOutlet weak var imageView: UIImageView!

override func viewDidLoad() {
    super.viewDidLoad()
    
    if let img = UIImage(named: "clover")?.withRenderingMode(.alwaysTemplate) {
        imageView.image = img
    }
}
```

처음 이미지를 추가할 때 .withRenderingMode() 함수를 사용해 랜더링 모드를 설정할 수 있습니다. 이렇게 생성한 이미지를 이미지뷰의 이미지에 추가하게 되면 해당 아울렛은 탬플릿 이미지로 추가됩니다.

어려운 내용은 없습니다.

# 5. Image #4

## Custom Drawing

추가된 View는 Root View와 같은 사이즈를 가지고 있고 View에 사용자가 원하는 위치에 이미지를 삽입하는 방법입니다. 

우선 View와 연결된 클래스를 정의하고 그 클래스 안에 삽입하고자 하는 이미지를 선언합니다. 그리고 draw() 메서드를 오버라이딩해서 그리기 코드를 직접 구현합니다. UIImage가 제공하는 방법으로 그릴 수 있는데 크게 세 가지가 있습니다. 

1. .draw(at: CGPoint(x:y:)
2. .draw(in: CGRect(x:y:width;height)
3. .drawjAsPattern(in: CGRect(CGRect)

첫번째 메서드는 이미지의 좌표만을 지정합니다. 이미지의 크기는 원본 크기로 삽입됩니다.

두번째 메서드는 좌표 지정과 동시에 크기도 지정합니다. 

세번째 메서드는 지정된 프레임의 이미지를 그리는데 이미지 크기가 프레임보다 작으면 패턴 형태로 그려지는 함수입니다.

```jsx
  
class CustomDrawingView: UIView {
    let starImg = UIImage(systemName: "star")
    let bellImg = UIImage(systemName: "bell")
    let umbrellaImg = UIImage(systemName: "umbrella")
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        starImg?.draw(at: CGPoint(x: 0.0, y: 0.0))
        bellImg?.draw(in: CGRect(x: 0.0, y: 80, width: 40, height: 40))
        umbrellaImg?.drawAsPattern(in: rect)
        
    }
}

class CustomImageDrawingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

## Resizing

리사이징하는 방법은 여러가지가 있습니다. 그 중 Image Context를 사용하는 방법과 Bitmap Context를 사용하는 방법에 대해 알아보겠습니다.

### [Image Context 사용]

1. 이미지를 리사이징 하는 함수를 선언합니다. 이 함수는 리사이징하고자 하는 이미지와 그 크기를 파라미터로 받습니다. 
2. ImageContext를 생성합니다. 무언가를 그릴 수 있는 그림판을 만드는 것입니다. 첫번째 파라미터로 리사이징하는 크기를 전달합니다. 그리고 두번째 파라미터는 이미지에 투명한 부분이 있다면 false, 투명한 부분이 없다면 true를 전달합니다. 마지막 파라미터로는 이미지의 스케일을 전달하는데, 0.0을 전달할 경우 디바이스의 스케일을 그대로 사용하게 됩니다. 
3. 그림판은 만들어졌고 프레임 내부에 그림을 그리기 위해 프레임을 생성합니다. 
4. draw(in: frame) 메서드를 사용해 이미지를 프레임에 그립니다. 원본 이미지가 프레임 내부에 원본 크기로 축소되어 그려집니다. 
5. 컨텍스트에 그려진 이미지를 실제 이미지로 변환합니다. 현재 사용하는 이미지 컨텍스트에서 이미지를 가져오는 UIGraphicsGetImageFromCurrentImageContext() 함수를 사용합니다. 
6. 컨텍스트 작업 완료 후 반드시 컨텍스트를 해제합니다. // method 구현 완료
7. viewDidLoad() 함수에서 방금 만들었던 method를 호출합니다. 

```jsx
// 함수를 추가할 때에는 보통 extension을 사용합니다.

extension ImageResizingViewController {
    func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
        
        // 1. 컨텍스트를 생성한다
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        // 2. 프레임을 생성한다
        let frame = CGRect(origin: CGPoint.zero, size: size)
        // 3. 프레임에 그림을 그린다
        image.draw(in: frame)
        // 4. 컨텍스트에 있는 그림을 실제로 사용할 수 있도록 꺼낸다
        let img = UIGraphicsGetImageFromCurrentImageContext()
        // 5. 컨텍스트를 해제한다
        UIGraphicsEndImageContext()
        
        return img
    }
}

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "photo") {
            let size = CGSize(width: image.size.width / 5.0, height: image.size.height / 5.0)
            imageView.image = resizingWithImageContext(image: image, to: size)
        }
                
    }
}
```

비교적 단순한 방법이지만 Context를 만들 때 사용할 수 있는 옵션이 제한적입니다. 

### [Bitmap Context 사용]

1. Bitmap Context를 사용할 수 있도록 CoreGraphics를 import합니다.
2. 이미지를 리사이징 하는 함수를 선언합니다. 이 함수는 리사이징하고자 하는 이미지와 그 크기를 파라미터로 받습니다. 
3. cgImage 속성을 사용해 이미지의 형식을 core graphics로 변경합니다.
4. 비트맵 컨텍스트를 생성합니다.
첫번째 파라미터로는 랜더링할 포인트의 메모리를 전달해야하는데 nil을 입력하면 알아서 처리됩니다. 
두번째, 세번째 파라미터로는 너비와 높이를 입력하는데 이 메서드에서 파라미터로 받은 size를 int형으로 변환하여 입력합니다.
나머지 파라미터들은 비트맵과 관련된 속성으로 이번에 다루지 않고 강의에 나온대로 원본 이미지의 비트맵 속성값을 입력하겠습니다.
5. context의 속성 중 interpolationQuality속성을 사용해 이미지의 품질을 설정합니다.
6. 프레임을 생성합니다.
7. draw() 메서드를 사용해 그림을 그립니다. 여기에서 사용하는 draw() 메서드는 CGContext에 구현된 메서드로 앞서 사용한 메서드와는 다른 메서드입니다. 첫번째 파라미터로는 core graphics Image로 변환한 이미지를 전달하고, 두번째 파라미터로는 프레임을 전달합니다.
8. 컨텍스트에 그려진 이미지를 makeImage() 메서드를 이용해 실제 이미지로 바꾸어줍니다.
9. CGImage를 UIImage로 바꾸어 리턴합니다.
10. viewDidLoad()에서 method를 호출합니다. 

```jsx
extension ImageResizingViewController {
    func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
        
        // 1. 비트맵을 사용하기 위해 cgImage(coreGraphicsImage)로 변경한다
        guard let cgImage = image.cgImage else {
            return nil
        }
        
        // 2. 비트맵 컨텍스트를 생성한다
        guard let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: cgImage.bytesPerRow, space:  cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue) else {
            return nil
        }
        
        // 3. 이미지의 품질을 설정한다
        context.interpolationQuality = .high
        
        // 4. 프레임을 생성한다
        let frame = CGRect(origin: CGPoint.zero, size: size)
        
        // 5. 프레임에 그림을 그린다 (CGContext에 구현된 메서드로 앞서 사용한 메서드와 완전히 다르다)
        context.draw(cgImage, in: frame)
        
        // 6. 컨텍스트에 그려진 이미지를 실제 이미지로 변경한다
        guard let img = context.makeImage() else {
            return nil
        }
        
        // 7. CGImage를 UIImage로 변경하여 리턴한다
        return UIImage(cgImage: img)
    }
}

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(named: "photo") {
            let size = CGSize(width: image.size.width / 5.0, height: image.size.height / 5.0)
            imageView.image = resizingWithBitmapContext(image: image, to: size)
        }
    }
}
```

이미지를 리사이징 하면서 비트맵 속성을 바꾸어야한다면 두번째 방법을 사용하고 그게 아니라면 주로 첫번째 방법을 사용합니다. 

# 6. Color #1

Interface Builder에서 색상을 선택하는 것은 상당히 직관적입니다. 컬러의 미리보기와 컬러의 이름이 나란히 작성되어 있는 모습을 확인할 수 있습니다. 

코드에서 컬러를 사용할 때에는 주로 UIColor를 사용합니다. UIColor는 자주 사용하는 컬러를 type property로 제공하여 컬러의 이름을 직접 입력하여 사용할 수 있습니다. 이미 등록된 색상이 아닌 또다른 색상을 선택하기 위해서는 UIColor의 생성자를 사용합니다. 다양한 생성자들 중 주로 사용하는 것은 아래의 두 생성자입니다.

```jsx
UIColor(red:green:blue:alpha)
UIColor(displayP3Red:green:blue:alpha)
```

rgb 컬러를 기반으로 색을 조합하여 새로운 색을 만들어내는 생성자입니다. 기존에 알고 있는 rgb 색상 체계는 0 ~ 255 까지의 숫자로 이루어져있지만 UIColor 생성자의 파라미터로는 모두 0.0 ~ 1.0 사이의 숫자를 사용합니다. 따라서 29를 입력하고자 한다면 (29.0/255.0) 과 같이 입력해야합니다. 

두 생성자 중 아래에 있는 생성자는 위의 생성자보다 표기할 수 있는 색상의 범위가 더 넓고 아이폰의 디바이스는 대부분 displayP3 컬러스페이스를 지원합니다.

type property로 제공된 컬러의 alpha 값을 변경하고자 한다면 아래와 같이 작성합니다.

```jsx
UIColor.systemRed.withAlphaComponent(0.5)
UIColor.clear
```

첫번째 코드는 알파값을 0.5로 변경하는 함수이고, 두번째 코드는 색상을 알파값을 0으로 즉, 투명하게 만드는 코드입니다.

UIColor에 직접 r, g, b 숫자를 입력해 새로운 색상을 만들어내는 것과 반대로 기존 색상에서 r, g, b 값을 추출하는 함수도 존재합니다.

```jsx
/*		
getRed(<#T##red: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>, 
green: <#T##UnsafeMutablePointer<CGFloat>?#>, blue: <#T##UnsafeMutablePointer<CGFloat>?#>, 
alpha: <#T##UnsafeMutablePointer<CGFloat>?#>)
*/

// 실제로 사용하는 모습
view.backgroundColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
```

파라미터로 포인트 값을 입력받기 때문에 & 문자를 사용합니다. 위와 같이 얻은 r, g, b, a 값은 CGFloat 형태입니다.

CIColor와 CGColor 형식이 존재합니다. 필요하다면 CIColor와 CGColor를 생성해야하는데 생성자를 이용하기보다는 기존의 UIColor를 사용해 CIColor, CGColor를 생성하는 방법을 선호합니다. 훨씬 깔끔하고 쉽습니다.

```jsx
view.layer.borderColor = UIColor.systemYellow.cgColor
```

borderColor 속성은 CGColor type이며 UIColor의 각 type property는 cgColor 속성을 가지고 있어 해당 속성에 접근하면 타입이 CGColor로 변경됩니다. CIColor도 마찬가지입니다.

반대의 경우 즉, CGColor와 CIColor를 UIColor로 변경하는 방법도 간단합니다. 아래의 생성자를 사용해 파라미터로 해당 타입의 컬러를 입력합니다.

```jsx
UIColor(cgColor:)
UIColor(ciColor:)
```

# 7. Color #2

## Pattern Color

asset에 패턴 이미지를 저장하고 이 이미지를 배경으로 채우는 방법입니다. UIColor 생성자에 중 파라미터로 patternImage를 받는 생성자가 있습니다.

```jsx
if let pattern = UIImage(named: "pattern") {
	view.backgroundColor = UIColor(patternImage: pattern)
}
```

개별 패턴은 사용하는 이미지의 원본 크기로 표시됩니다. 만약 패턴의 사이즈를 변경하고싶다면 속성에 직접 접근하여 수정하는 것은 불가능하고, 패턴 이미지 자체의 크기를 변경해야합니다.

## Color Literal

Color Literal 이라고 입력하면 자동완성에 Color Literal이 있습니다. 이를 탭하면 네모모양의 미리보기 색상으로 변경됩니다. 이 네모를 클릭하면 다른 색으로 변경이 가능합니다. 컬러 리터럴의 개념은 단순합니다. 말 그대로 리터럴이기 때문에 상수에 저장할 수 있고, 파라미터로 전달할 수 있습니다.

## Color Set

Color Set은 Asse의 네비게이터에서 우클릭하면 추가할 수 있으며 기본으로 두가지를 함께 추가합니다. 이름은 하나이지만 Any Appearance는 기본 모드에서, Dark Appearance는 다크 모드에서 사용되는 컬러입니다. 색을 지정하는 각 네모칸은 Color Well이라고 합니다. Color Set을 사용하기 위해서는 UIColor의 생성자를 이용해named: 파라미터로 해당 Color Set 이름을 입력합니다. 그러나 같은 이름의 Color Set이 Asset에 존재하지 않을 경우 이 생성자는 nil을 리턴하기 때문에 기본 컬러를 함께 작성해주는 편이 좋습니다.

```jsx
view.backgroundColor = UIColor(named: "PrimaryColor") ?? UIColor.white
```

## Color Drawing

커스텀뷰에서 직접 그린 이미지들의 기본 컬러는 검정색입니다. 아무것도 색을 지정하지 않으면 검정색으로 화면에 표시되고, 이 컬러를 수정하는 코드를 알아보겠습니다.

CGContext가 제공하는 것으로 변경할 수 있지만 UIColor 클래스가 제공하는 method를 사용하면 아래와 같습니다.

```jsx
UIColor.systemRed.setStroke()
UIColor.systemBlue.setFill()
```

setStroke()는 그리는 라인의 색상을 변경하는 메서드이고 setFill()은 채우는 색상을 변경하는 메서드입니다.