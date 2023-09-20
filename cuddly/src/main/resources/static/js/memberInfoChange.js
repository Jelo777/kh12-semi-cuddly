$(function(){


    var status={
       
        contact:false,
        email:false,
        birth:false,
        ok:function(){
            return this.contact && this.email && this.birth;
        }
    };





    $("[name=memberContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var inputContact=$(this).val();
        
        var isValid=$(this).val().length==0 || regex.test(inputContact);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.contact=isValid;
    });

    $("[name=memberEmail]").blur(function(){
        var regex=/^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        var inputEmail=$(this).val();
        
        var isValid=regex.test(inputEmail);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.email=isValid;
    });
    $("[name=memberBirth]").blur(function(){
        var regex=/^(19[0-9]{2}|20[0-9]{2})-(((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((02)-(0[1-9]|1[0-9]|2[0-9])))$/;
        var inputBirth=$(this).val();
        
        var isValid=$(this).val().length==0 || regex.test(inputBirth);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.birth=isValid;
    });




    //페이지 이탈 방지
    //- window에 beforeunload 이벤트 설정
    $(window).on("beforeunload", function(){
        return false;
    });

    //-form 전송할 때는 beforeunload 이벤트를 제거
    $(".change-form").submit(function(e){
        $(".form-input").blur();
        
        if(!status.ok()){
            e.preventDefault();
        }
        else{
            $(window).off("beforeunload");
        }
    });

 });