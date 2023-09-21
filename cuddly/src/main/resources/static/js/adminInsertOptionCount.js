$(document).ready(function() {
    // "+" 버튼 클릭 이벤트 핸들러
        $(".editPlus").click(function() {
            var num = $(".editNumBox").val();
            if(num >= 0){
                var plusNum = Number(num) + 1;
                $(".editNumBox").val(plusNum); // 값을 증가시켜 input에 반영
            }
        });

        // "-" 버튼 클릭 이벤트 핸들러
        $(".editMinus").click(function() {
            var num = $(".editNumBox").val();
            if(num > 0){
                var minusNum = Number(num) - 1;
                $(".editNumBox").val(minusNum); // 값을 감소시켜 input에 반영
            }
        });

        $(".insertPlus").click(function() {
            var num = $(".insertNumBox").val();
            if(num >= 0){
                var plusNum = Number(num) + 1;
                $(".insertNumBox").val(plusNum); // 값을 증가시켜 input에 반영
            }
        });

        // "-" 버튼 클릭 이벤트 핸들러
        $(".insertMinus").click(function() {
            var num = $(".insertNumBox").val();
            if(num > 0){
                var minusNum = Number(num) - 1;
                $(".insertNumBox").val(minusNum); // 값을 감소시켜 input에 반영
            }
        });
    });