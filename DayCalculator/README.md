# 기념일 계산기

### 첫번째 화면

DatePicker, ImageView, Label로 화면 구성

DatePicker 값에 따라 D+100, D+200, D+300, D+400의 Label 변경

ImageView 코너 둥글게, 오른쪽으로 90도 회전

DateFormatter로 ```"yyyy년\nMM월 dd일"``` 설정

기념일 계산 ```date + 86400 * (일수)``` ex) D+100 : date + 86400 * 100

viewWillDisappear시 UserDefaults에 카운트 저장

<img src="https://velog.velcdn.com/images/rytak108/post/357ee074-2a50-4ee7-8777-1a639695463c/image.gif" width="200" height="400"/>