# AlarmAPP
Setting the day, inside what to do  then it will check in the background,using GCD.
<img width="393" alt="스크린샷 2022-11-06 오후 5 37 17" src="https://user-images.githubusercontent.com/76695159/200162273-27dc2d93-2617-4abb-a229-b4de8e83507e.png">
datepicker를 이용해 날짜를 설정하고 textfield에 할일을 적어주고 할일 추가를 누르면 테이블뷰에 업데이트가 되고 백그라운드쓰레드에서 timer schedulertimer가 30초마다 돌면서 확인하면서 일치하는 경우 
alert창 표시
