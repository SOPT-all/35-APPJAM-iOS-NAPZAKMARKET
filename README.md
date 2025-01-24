# 👽 NAPZAKMARKET-iOS

**덕후들이 사랑하는 거래 공간**

> 납작한 것만 취급하는 오타쿠 전용 중고거래 서비스

![트위터 배경](https://github.com/user-attachments/assets/7d86d5cb-23be-40fb-9895-0e013270917a)

</br>



## 👩🏻‍💻🧑🏻‍💻 Developers
| [조혜린](https://github.com/Johyerin) | [김한열](https://github.com/OneTen19) | [박어진](https://github.com/lalaurrel) | [조호근](https://github.com/joho2022) |
| :--------: | :--------: | :--------: | :--------: | 
| <img width="200px" src="https://github.com/user-attachments/assets/9d373027-209d-43af-8963-494b914ec68a"/> | <img width="200px" src="https://github.com/user-attachments/assets/61b9ec5f-fec0-40f3-9f55-205f3fea1fd3"/> | <img width="200px" src="https://github.com/user-attachments/assets/ffe1b365-a967-4abc-be82-7ad96db25acf"/> | <img width="200px" src="https://github.com/user-attachments/assets/52cd7bfb-cfdb-4ae8-9e43-b7b15da8d3da"/> |
| <p align = "center">`탐색` <br/> `상세 페이지`<br/> | <p align = "center">`등록`<br/> | <p align = "center">`마이페이지` <br/> `마켓 보기` <br/> `탭바`<br/> | <p align = "center">`온보딩` <br/> `홈`<br/> | 

</br>


## 👽 Project 

**1️⃣ 덕후 취향 반영 온보딩**
- 관심 장르를 직접 설정하고 취향에 딱 맞는 아이템들을 한눈에 확인해요
- 개인 맞춤 상품 추천으로 취향 저격 아이템을 발견해보세요
  
**2️⃣ 500여개 장르로 세분화된 상세 탐색**
- 불편한 검색은 이제 그만! 애니메이션, 게임 등 세분화된 장르로 더욱 편리하고 정확하게 상품을 찾아봐요
- 검색, 필터 기능을 통해 원하는 장르 및 아이템을 쉽고 정확하게 탐색해보세요

**3️⃣ 원하는 상품은 '구해요'에서 쉽게 찾고, 팔고 싶은 굿즈는 '팔아요'에서 빠르게 거래해요**
- (‘팔아요’와 ‘구해요’ 카테고리를 통해) 거래 목적에 맞게, 보다 편리하고 확실하게 거래해보세요

**4️⃣ 덕후들의 거래 방식에 딱 맞는 등록 시스템!**
- 원하는 아이템을 구하기 위해 **매일 검색하거나 찾아다니지 않아도 돼요!**
- **장르 설정**부터 **상품 상태 설정**까지, 빠르고 간편한 거래가 가능해요
- **가격 제시 버튼**과 **원하는 가격대 설정 기능**으로 위시템을 구할 수 있어요

**5️⃣ 나만의 덕질 마켓**
- 자신만의 독특한 스타일로 마켓의 개성을 드러낼 수 있어요
- 관심 장르, 소개글, 프로필 이미지로 직접 커스텀하여 나만의 마켓을 꾸며보세요
  

</br>


## 🛠 Development Environment

![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

|  | Purpose            | Version                                                |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| SwiftUI             | 코드의 간결성과 직관성을 통해 빠르고 쉽게 사용자 인터페이스를 설계하고 유지보수가 가능 | ![SwiftUI](https://img.shields.io/badge/SwiftUI-6.0-blue) |
| Moya           | 간결한 네트워크 요청과 구조화된 관리 방식으로 코드 가독성과 유지보수성 향상        | ![Moya](https://img.shields.io/badge/Moya-15.0.3-orange) |
| Kingfisher           | 효율적인 이미지 다운로드 및 캐싱을 통해 네트워크 이미지 로딩 성능 향상 | ![Kingfisher](https://img.shields.io/badge/Kingfisher-8.11.0-yellow) |

</br>


## 👽 Project Architecture
<img width="2477" alt="iOS 1차 과제 (2)" src="https://github.com/user-attachments/assets/63153480-b28e-4b5c-a68d-4719b2b68b37" />

### SwiftUI와 MV 패턴: 단순함 속에서 생산성을 극대화하다
SwiftUI의 **선언적 UI**와 **데이터 바인딩 시스템**을 최대한 활용하기 위해 저희는  **MV(Model-View) 패턴**을 채택했습니다. 복잡한 MVVM 아키텍처를 배제하고 **@State**와 **@Binding**을 활용한 데이터와 UI 간의 자동 동기화를 통해 간결하고 효율적인 코드베이스를 유지합니다.

이 접근 방식은 불필요한 레이어를 제거하여 **개발 속도**를 극대화하는 동시에 단순함 속에서도 **유지보수성**과 **확장성**을 자연스럽게 확보하는 것을 도와줍니다. 특히 추가적인 ViewModel 레이어 없이도 SwiftUI만으로 **효과적인 상태 관리**를 구현할 수 있습니다.



## 👽 Project Design & Flow Chart

<img width="6352" alt="iOS 1차 과제" src="https://github.com/user-attachments/assets/1bf0a178-251a-4df9-86c3-6479ebe6b9d6" />| <img width="5920" alt="iOS 1차 과제 (1)" src="https://github.com/user-attachments/assets/58dba982-a459-411a-a822-8ca8e9b2a7a1" />
---|---|


<br/>

## 👽 Code Convention
[🔗 Code Convention](https://understood-soldier-501.notion.site/Code-Convention-16df54d645db81d5958efb898ce90b3e?pvs=4)


```
Naming:
- 타입: UpperCamelCase
- 변수/상수: lowerCamelCase
- 약어(URL/ID/API): 대문자

Structure:
- Protocol → extension으로 분리
- import: 내장 먼저, 서드파티는 한 줄 띄움
- 90자 초과시 줄바꿈

Image:
- icn_/btn_/img_ 접두어
- snake_case
- SVG 우선

self/강제 언래핑 지양, 긴 View는 extension으로 분리
```

<br/>

## 👽 Foldering
```
📁 Project
├── 📁 Applacation
│   ├── 📁 Preview Content
│   ├── Napzakmarket_iOSApp.swift
├── 📁 Global
│   ├── 📁 Modifier
│   ├── 📁 Extensions
│   ├── 📁 Components
│   ├── 📁 Literals
│   │   ├── StringLiterals.swift
│   │   ├── FonrLiterals.swift
│   └── 📁 Resources
│       ├── Font
│       └── Assets.xcassets
├── 📁 Network
│   ├── 📁 Base
│   └── 📁 Domain
│       ├── 📁 DTO
│       │   ├── 📁 Request
│       │   └── 📁 Response
│       ├── Domain1API.swift
│       └── Domain1Service.swift
└── 📁 Presentation
    ├── 📁 Splash
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── SplashView.swift
    ├── 📁 Onboarding
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── OnboardingView.swift
    ├── 📁 Home
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── HomeView.swift
    ├── 📁 Search
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── SearchView.swift
    ├── 📁 Register
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── RegisterView.swift
    ├── 📁 Detail
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── DetailView.swift
    ├── 📁 Mypage
    │    ├── 📁 Model
    │    └── 📁 View
    │        └── MypageView.swift
    └── 📁 Tabbar
         ├── 📁 Model
         └── 📁 View
             └── TabbarView.swift
```
<br/>


## 🔥 Trouble Shooting
[🔗 Trouble Shooting](https://understood-soldier-501.notion.site/Trouble-Shooting-16df54d645db81138475c736f61398e9?pvs=4)
