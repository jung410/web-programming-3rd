$(function(){
    $("form").submit(function(e){
        if(this.cardno1.value.trim() ==""){
            alert("카드번호를 입력하지 않았습니다.")
            return false;
        }
        if(!this.cardno1.value.match(/^(?:[0-9]\d{3})/)){
            alert("카드번호를 제대로 입력하지 않았습니다.")
            return false;
        }
        if(this.cardno2.value.trim() ==""){
        	alert("카드번호를 입력하지 않았습니다.")
        	return false;
        }
        if(!this.cardno2.value.match(/^(?:[0-9]\d{3})/)){
        	alert("카드번호를 제대로 입력하지 않았습니다.")
        	return false;
        }
        if(this.cardno3.value.trim() ==""){
        	alert("카드번호를 입력하지 않았습니다.")
        	return false;
        }
        if(!this.cardno3.value.match(/^(?:[0-9]\d{3})/)){
        	alert("카드번호를 제대로 입력하지 않았습니다.")
        	return false;
        }
        if(this.cardno4.value.trim() ==""){
        	alert("카드번호를 입력하지 않았습니다.")
        	return false;
        }
        if(!this.cardno4.value.match(/^(?:[0-9]\d{3})/)){
        	alert("카드번호를 제대로 입력하지 않았습니다.")
        	return false;
        }
        if(this.month.value.trim() ==""){
            alert("유효시간을 입력하지 않았습니다.")
            // console.log(this.month.value);
            return false;
        }
        if(!this.month.value.match(/^(?:0[1-9]|1[0-2])$/g)){
            alert("유효시간을 제대로 입력하지 않았습니다.")
            // console.log(this.month.value);
            return false;
        }
        if(this.year.value.trim() ==""){
            alert("유효기한을 입력하지 않았습니다.")
            // console.log(this.year.value);
            return false;
        }
        if(!this.year.value.match(/^(?:[0-9]{2})$/g)){
            alert("유효기한을 제대로 입력하지 않았습니다.")
            // console.log(this.year.value);
            return false;
        }
        if(this.cardpw.value.trim() ==""){
            alert("비밀번호를 입력하지 않았습니다.")
            return false;
        }
        if(this.cardpw.value.match(/^(?:[0-9]{1})$/g)){
            alert("비밀번호를 제대로 입력하지 않았습니다.")
            console.log(this.cardpw.value);
            return false;
        }
        if(this.birth.value.trim() ==""){
            alert("주민등록번호를 입력하지 않았습니다.")
            return false;
        }
        if(!this.birth.value.match(/^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))$/g)){
            alert("주민등록번호를 제대로 입력하지 않았습니다.")
            return false;
        }
        

            alert("결제 완료.")
            /*$(".hiddenValue").html('<input type="hidden" value="${param.reservationPk}" name="reservationPk">');*/
        });
        
    });