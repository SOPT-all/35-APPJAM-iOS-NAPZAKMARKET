# 👽 NAPZAKMARKET-iOS

**덕후들이 사랑하는 거래 공간**

> 납작한 것만 취급하는 오타쿠 전용 중고거래 서비스

![트위터 배경](https://github.com/user-attachments/assets/7d86d5cb-23be-40fb-9895-0e013270917a)


![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white)

</br>

## 프로젝트 설명

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
  
<br/>


## 👩🏻‍💻🧑🏻‍💻 Developers
| [조혜린](https://github.com/Johyerin) | [김한열](https://github.com/OneTen19) | [박어진](https://github.com/lalaurrel) | [조호근](https://github.com/joho2022) |
| :--------: | :--------: | :--------: | :--------: | 
| <img width="200px" src="https://github.com/user-attachments/assets/9d373027-209d-43af-8963-494b914ec68a"/> | <img width="200px" src="https://github.com/user-attachments/assets/61b9ec5f-fec0-40f3-9f55-205f3fea1fd3"/> | <img width="200px" src="https://github.com/user-attachments/assets/ffe1b365-a967-4abc-be82-7ad96db25acf"/> | <img width="200px" src="https://github.com/user-attachments/assets/52cd7bfb-cfdb-4ae8-9e43-b7b15da8d3da"/> |
| <p align = "center">`탐색` `상세 페이지`<br/> | <p align = "center">`등록`<br/> | <p align = "center">`마이페이지` `마켓 보기` `탭바`<br/> | <p align = "center">`온보딩` `홈`<br/> | 

<br/>

## 📌 Project Design & Flow Chart

<img width="6352" alt="iOS 1차 과제" src="https://github.com/user-attachments/assets/1bf0a178-251a-4df9-86c3-6479ebe6b9d6" />| <img width="5920" alt="iOS 1차 과제 (1)" src="https://github.com/user-attachments/assets/58dba982-a459-411a-a822-8ca8e9b2a7a1" />
---|---|


<br/>

## 📌 Code Convention
[🫸🏻 💟 납작한 코드 컨벤션 💟 🫷🏻](https://understood-soldier-501.notion.site/Code-Convention-16df54d645db81d5958efb898ce90b3e?pvs=4)

<br/>

## 📌 Foldering
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
│   └── 📁 Domain1
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
