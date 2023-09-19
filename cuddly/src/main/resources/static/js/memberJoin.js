$(function(){


    var status={
        id:false,
        pw:false,
        pwCheck:false,
        nickname:false,
        email:false,
        contact:false,
        birth:false,
        address:false,
        ok:function(){
            return this.id && this.pw && this.pwCheck &&this.nickname 
                && this.email && this.contact && this.birth && this.address;
        }
    };



    $("[name=memberId]").blur(function(e){
        var regex=/^[a-z][a-z0-9-_]{4,19}$/;
        var inputId=$(e.target).val();
        
        var isValid=regex.test(inputId);
        $(e.target).removeClass("success fail fail2");
        if(isValid){//형식이 유효하다면
          $.ajax({
            url:"http://localhost:8080/rest/member/idCheck",
            method:"post",
            // data : {memberId : e.target.value},
            data :{memberId:$(e.target).val()},
            success:function(response){
                if(response =="Y"){//사용가능
                    $(e.target).addClass("success");
                    status.id=true;
                }
                else{//사용불가(중복)
                    $(e.target).addClass("fail2");
                    status.id=false;
                }
            },
            error:function(){
                alert("서버와의 통신이 원활하지 않습니다");
            },
          });
        }
        else{
            $(e.target).addClass("fail");
            status.id=false;
        }
   
    });

    $("[name=memberPw]").blur(function(){
        var regex=/^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var inputPw=$(this).val();
        
        var isValid=regex.test(inputPw);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.pw=isValid;
    });

    $("#password-check").blur(function(){
        var inputPw=$("[name=memberPw]").val();
        var checkPw=$(this).val();

        var isValid=inputPw==checkPw;

        $(this).removeClass("success fail fail2");
        if(inputPw.length==0){
            $(this).addClass("fail2");
            status.pwCheck=false;

        }
        else if(isValid){
            $(this).addClass("success");
            status.pwCheck=true;
        }
        else{
            $(this).addClass("fail");
            status.pwCheck=false;
        }
    });

    $("[name=memberNickname]").blur(function(e){
        var regex=/^[ㄱ-하-ㅣ가-힣0-9]{1,10}$/;
        var inputNickname=$(e.target).val();
        
        var isValid=regex.test(inputNickname);
        // $(e.target).removeClass("success fail fail2");
        if(isValid){//형식 통과
            $.ajax({
                url:"http://localhost:8080/rest/member/nicknameCheck",
                method:"post",
                // data:{memberNickname:e.target.value},//JS
                data:{memberNickname:$(e.target).val()},//jQuery
                success:function(response){
                    $(e.target).removeClass("success fail fail2");
                    if(response =="Y"){//사용가능
                        $(e.target).addClass("success");
                        status.nickname=true;
                    }
                    else{//사용불가(중복)
                        $(e.target).addClass("fail2");
                        status.nickname=false;
                    }

                },
                error:function(){
                    alert("서버와 통신이 원활하지 않은데요");
                }
            });
        }
        else{//형식 오류
            $(e.target).removeClass("success fail fail2");
            $(e.target).addClass("fail");
            status.nickname=false;
        }
    });
    $("[name=memberEmail]").blur(function(){
        var regex=/^(.*?)@(.*?)$/;
        var inputEmail=$(this).val();
        
        var isValid=$(this).val().length==0 || regex.test(inputEmail);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.email=isValid;
    });
    $("[name=memberContact]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var inputContact=$(this).val();
        
        var isValid=$(this).val().length==0 || regex.test(inputContact);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.contact=isValid;
    });
    $("[name=memberBirth]").blur(function(){
        var regex=/^(19[0-9]{2}|20[0-9]{2})-(((0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))|((0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30))|((02)-(0[1-9]|1[0-9]|2[0-9])))$/;
        var inputBirth=$(this).val();
        
        var isValid=$(this).val().length==0 || regex.test(inputBirth);
        $(this).removeClass("success fail");
        $(this).addClass(isValid ? "success" : "fail");
        status.birth=isValid;
    });



    $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").blur(function(){
        var inputPost=$("[name=memberPost]").val();
        var inputAddr1=$("[name=memberAddr1]").val();
        var inputAddr2=$("[name=memberAddr2]").val();

        var isBlank = inputPost.length==0 && inputAddr1.length==0 && inputAddr2.length ==0;
        var isFill = inputPost.length>0 && inputAddr1.length>0 && inputAddr2.length >0;

        var isValid= isBlank || isFill;

        $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").removeClass("success fail");
        $("[name=memberPost],[name=memberAddr1],[name=memberAddr2]").addClass(isValid ? "success" : "fail");
        status.address=isValid;
    });
    //페이지 이탈 방지
    //- window에 beforeunload 이벤트 설정
    $(window).on("beforeunload", function(){
        return false;
    });

    //-form 전송할 때는 beforeunload 이벤트를 제거
    $(".join-form").submit(function(e){
        $(".form-input").blur();
        
        if(!status.ok()){
            e.preventDefault();
        }
        else{
            $(window).off("beforeunload");
        }
    });

 });