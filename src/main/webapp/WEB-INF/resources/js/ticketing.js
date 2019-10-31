$(function(){
var d = new Date();
var b = 0;
var c = 0;
var today = new Date();
var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
today = new Date(today.getFullYear(), today.getMonth(), today.getDate());
/*console.log(today);
console.log(today.getDate());
console.log(lastDate);*/
for(a=0;a<7;a++){

	if((d.getDate()+b-c)-(today.getDate()) >= 0){
		if((d.getDate()+b-c)<10){
			$(".dateList").append("<div class=' btn-group btn-group-toggle mb-1'><label class='btn '><input type='radio' name='jb-radio4' value='"+(d.getFullYear())+"-"+(d.getMonth()+1)+"-0"+(d.getDate()+b-c)+"'>"+(d.getDate()+b-c)+"</label></div>");
		}else{
			$(".dateList").append("<div class='btn-group btn-group-toggle mb-1'><label class='btn '><input type='radio' name='jb-radio4' value='"+(d.getFullYear())+"-"+(d.getMonth()+1)+"-"+(d.getDate()+b-c)+"'>"+(d.getDate()+b-c)+"</label></div>");
		}
		
	}
	else{
		if((d.getDate()+b-c)<10){
			$(".dateList").append("<div class='btn-group btn-group-toggle mb-1'><label class='btn '><input type='radio' name='jb-radio4' value='"+(d.getFullYear())+"-"+(d.getMonth()+2)+"-0"+(d.getDate()+b-c)+"'>"+(d.getDate()+b-c)+"</label></div>");
		}else{
			$(".dateList").append("<div class='btn-group btn-group-toggle mb-1'><label class='btn '><input type='radio' name='jb-radio4' value='"+(d.getFullYear())+"-"+(d.getMonth()+2)+"-"+(d.getDate()+b-c)+"'>"+(d.getDate()+b-c)+"</label></div>");
		}

	}

	if(d.getDate() + b-c == lastDate.getDate()){
		$(".dateList").append("<div class='mb-2'><h2 id='date-result-4'></h2></div>");
	    c=lastDate.getDate();
	}  
	b++;
};
$("#date-result-2").html(d.getFullYear());
$("#date-result-3").html(d.getMonth()+1);
$("#date-result-4").html(d.getMonth()+2);
$('.scrDate').hide();

	
    
  })