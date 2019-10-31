var c = 1;
for(a=0;a<5;a++){
    document.write("<div class='btn-group-toggle' data-toggle='buttons'>");
  for(b=1;b<8;b++){
    document.write("<lable class='btn btn-outline-primary s-style'><input type='checkbox' name='seat_pk_no' value='"+c+"'>"+b+"</lable>");
    c++;
  }
  document.write("</div>");
  // document.write("<p></p><br>");
  
}


$(function($) {
    $("input[name=seat_pk_no]:checkbox").change(function() {// 체크박스들이 변경됬을때
      var cnt = $("#selcnt").val();
      console.log(cnt);
      console.log($("input[name=seat_pk_no]:checkbox:checked").length);
      if( cnt <= $("input[name=seat_pk_no]:checkbox:checked").length ) {
        $(":checkbox:not(:checked)").attr("disabled", "disabled");
      } else {
        $("input[name=seat_pk_no]:checkbox").removeAttr("disabled");
      }
      if($("#selcnt").val() == $("input[name=seat_pk_no]:checkbox:checked").length){
    	  $(".nextBtn").removeAttr("disabled")
    	  
      }
    });
    

      $("#selcnt").change(function() {
      $("input[name=seat_pk_no]:checkbox").removeAttr("checked");
      $("input[name=seat_pk_no]:checkbox").removeAttr("disabled");
    });
    if($("#selcnt").change(function(){
      $(".s-style").removeClass("active");
      $("input[name=seat_pk_no]:checkbox").prop("checked", false);
      
      
    }));
    
  });