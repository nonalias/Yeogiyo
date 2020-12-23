## 💺 여기요

### 여기요 (Yeogiyo)는 42 Seoul Cadet을 위한 유용한 좌석 서칭 프로그램입니다.
### 자신의 진도와 비슷한 사람의 좌석을 색깔로 구분하여 줍니다.
### 혼자하기 힘들었던 과제를 여기요를 통해 쉽게 해결할 수 있습니다.
   
[홍보영상](https://www.youtube.com/watch?v=cmB1KURhgb8&ab_channel=%EB%AC%B8%EA%B3%BC%EA%B0%9C%EB%B0%9C%EC%9E%90)
[pdf](https://github.com/nonalias/Yeogiyo/files/5735702/42._.pdf)

### 여기요 팀원
* [김태훈](https://github.com/nonalias)   
* [박준홍](https://github.com/feldblume5263)   
* [이재영](https://github.com/ejei0g)   
   
   
<details>
  <summary>프로토타입</summary>
  
  ![image](https://user-images.githubusercontent.com/43032377/102309358-ef333480-3fab-11eb-86d2-86d876e8a054.png)
  ![image](https://user-images.githubusercontent.com/43032377/102309375-f8240600-3fab-11eb-9d20-0cb4e03ab407.png)
  ![image](https://user-images.githubusercontent.com/43032377/102309385-ffe3aa80-3fab-11eb-8c00-7061708caee3.png)

</details>

## 🗓 기간
2020.12.16 ~ 2020.12.18

## 🔧 환경
IOS 14.xx

macOS Big Sur 11.0.1

## 💻 기능
* 42Seoul의 Inner Circle Subject 내의 과제를 검색하여 
* 클러스터 내 인원들의 과제 해결 여부를 체크후
* 좌석 시트별로 진행 과정을 알 수 있음.
* 좌석을 클릭하면, 그 사람의 인트라 계정 페이지로 접속된다.
![image](https://user-images.githubusercontent.com/43032377/102607335-7975c700-416b-11eb-8c15-ca5f7ce1ef57.png)
![image](https://user-images.githubusercontent.com/43032377/102607163-2865d300-416b-11eb-9a19-1b837ed46c75.png)


## ⚓️Workflow
![image](https://user-images.githubusercontent.com/43032377/103007543-f1caf680-4576-11eb-8b8b-dd1f20157332.png)

## 🕹기술스택
* Swift 5.3.1
  * CollectionView -> seats view
  * TableView -> Intro view
  * URLRequest -> Http connection
  * JSONSerialization -> JSON parser

* 42 API
  * Json
## 🔨 보완해야할 사항
* 서버구축
  * API를 매번 받아오는 것은 시간당 요청 가능 횟수(1200)을 초과할 우려가 있다.
  * 또한, API통신을 이용하여 원하는 기능을 구현하려면 API 요청이 많이 필요하다.
  * 그로인해, 클러스터에 상주한 인원이 많으면 속도가 느려진다.
  
* Tab으로 C1, C2 ... C8, C10 구분하기
  * 현재, 프로토타입으로 C1만 구현이 된 상태이다.
  * 탭뷰로 여러 뷰들을 관리하면 나머지 클러스터의 좌석도 구현할 수 있다.
  * 하나의 문제점으로는, API를 받아오는 것이 최대 30개가 허용이 되므로 이것은 [pagination](https://api.intra.42.fr/apidoc/guides/specification#pagination) 으로 해결해볼 예정이다.

* 정식 서비스하기
  * 만약 수요가 있다면, 정식으로 배포할 예정이다.
  * 아직은 토큰을 임시로 발급하여 사용하고 있는데, 실제로 서비스할 경우 어떻게 수행할지 생각해 보아야 한다.
