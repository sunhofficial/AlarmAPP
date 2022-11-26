# AlarmAPP
Setting the day, inside what to do  then it will check in the background,using GCD.

<img src = "https://user-images.githubusercontent.com/76695159/204074196-3e3e0155-921d-4db7-9dfe-aaafccf1710f.PNG" width="300" height="500">

먼저 카카오 로그인 api를 이용하여 프로필정보와 닉네임을 가져와서 상단에 출력해준다.
datepicker를 이용해 날짜를 설정하고 textfield에 할일을 적어주고 할일 추가를 누르면 테이블뷰에 업데이트가 되고 백그라운드쓰레드에서 timer schedulertimer가10초마다 돌면서 확인하면서 일치하는 경우 
alert창 표시
