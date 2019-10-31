var i = 0;
$(function(){
    $(".more-btn").click(function (event) {
        event.preventDefault();
      while(true){
          if($(".card-deck").eq(i+2).hasClass("hide")){
              $(".card-deck").eq(i+2).removeClass("hide");
              i++;
              return;
          } else {
            i++;
              return;
          }
      }
   
  })
})