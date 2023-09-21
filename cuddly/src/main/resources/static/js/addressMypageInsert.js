$(function(){


    var status={
        name:false,
        contact:false,
        address:false,
        ok:function(){
            return this.name && this.contact && this.address;

        }
    };



   

    $("[name=addressName]").blur(function(){
        var regex=/^[가-힣]{2,7}$/;
        var inputName=$(this).val();
        var isValid=regex.test(inputName);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.name=isValid;

    });

    $("[name=addressContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var inputContact=$(this).val();
        
        var isValid=regex.test(inputContact);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.contact=isValid;
    });

    $("[name=addressPost],[name=addressAddr1],[name=addressAddr2]").blur(function(){
        var inputPost=$("[name=addressPost]").val();
        var inputAddr1=$("[name=addressAddr1]").val();
        var inputAddr2=$("[name=addressAddr2]").val();

        var isValid= inputPost.length>0 && inputAddr1.length>0 && inputAddr2.length >0;

        $("[name=addressPost],[name=addressAddr1],[name=addressAddr2]").removeClass("success fail");
        $("[name=addressPost],[name=addressAddr1],[name=addressAddr2]").addClass(isValid ? "success" : "fail");
        status.address=isValid;
    });
    




    //페이지 이탈 방지
    //- window에 beforeunload 이벤트 설정
    $(window).on("beforeunload", function(){
        return false;
    });

    //-form 전송할 때는 beforeunload 이벤트를 제거
    $(".address-insert-form").submit(function(e){
        $(".form-input").blur();
        
        if(!status.ok()){
            e.preventDefault();
        }
        else{
            $(window).off("beforeunload");
        }
    });

 });