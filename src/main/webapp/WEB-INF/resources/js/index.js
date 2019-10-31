$(function(){
    $(".run-now").click(function(){
        $(this).removeClass("btn-dark");
        $(this).addClass("btn-danger");
        $(".run-next").removeClass("btn-danger");
        $(".run-next").addClass("btn-dark");
    });

    $(".run-next").click(function(){
        $(".run-now").removeClass("btn-danger");
        $(".run-now").addClass("btn-dark");
        $(this).removeClass("btn-dark");
        $(this).addClass("btn-danger");
    });
    
    $(".logout-btn").click(function(){
    	if(confirm("정말 로그아웃 하시겠습니까?")){
    		return true;
    	} else{
    		return false;
    	}
    })
})