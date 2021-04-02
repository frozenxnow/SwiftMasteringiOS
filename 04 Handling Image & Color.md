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