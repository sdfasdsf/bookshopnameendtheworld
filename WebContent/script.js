function writeSave(){
	if($('input[name=writer]').val()==""){
		alert("작성자를 입력하세요");
		$('input[name=writer]').focus();
		return false;
	}
	
	if($('input[name=subject]').val()==""){
		alert("제목을 입력하세요");
		$('input[name=subject]').focus();
		return false;
	}
	
	if($('input[name=email]').val()==""){
		alert("email을 입력하세요");
		$('input[name=email]').focus();
		return false;
	}
	
	if($('#abc').val()==""){
		alert("내용을 입력하세요");
		$('#abc').focus();
		return false;
	}
	
	if($('input[name=passwd]').val()==""){
		alert("passwd를 입력하세요");
		$('input[name=passwd]').focus();
		return false;
	}
}
var isCheck = false;
var isChange = false;
var use = "";

$(function(){
	
	$('input[name="id"]').keydown(function(){
		$('#idmessage').css('display','none');
		isChange = true;
		use="";
	});
	
	
});

function writeSave(){ // 
	if($('input[name="id"]').val()==""){
		alert("id를 입력하세요."); 
		$('input[name="id"]').focus();
		return false;
	}
	
	if(use == "impossible"){
		alert("이미 사용중인 아이디입니다.");
		return false;
	}
	
	if(isCheck == false || isChange == true){
		alert("중복체크 하세요");
		return false; 
	}
	
	
	
	if($('input[name="password"]').val()==""){
		alert("비번을 입력하세요.");
		$('input[name="password"]').focus();
		return false;
	}
	
	if(pwsame == "비번불일치"){
		alert("비번 불일치");
		return false;
	}
	
}//writeSave()


function duplicate(){ // 
	//alert("1");
	isCheck = true;
	isChange = false;
	
	$.ajax({
		url : "id_check_proc.jsp",
		data : ({
				userid:$('input[name="id"]').val() // userid=kim
		}),
		success : function(data){
			
			if($('input[name="id"]').val() == ""){
				$('#idmessage').html('<font color=red>id입력 누락</font>');
				$('#idmessage').show();
			}
			else if($.trim(data) == 'YES'){
				$('#idmessage').html('<font color=red>사용 가능합니다.</font>');
				$('#idmessage').show();
				use = "possible";
			}
			else{
				$('#idmessage').html('<font color=red>이미 사용중인 아이디입니다.</font>');
				$('#idmessage').show();
				use = "impossible";
				
			}
		}
	}); // ajax
	
} // duplicate()


function passwd_keyup(){
	//alert(2);
	
	if($('input[name=password]').val() == $('input[name=repassword]').val()){
		$('#pwmessage').html("<font color=red>비번일치</font>");
		$('#pwmessage').show();
		pwsame = "비번일치";
		
	}else{
		$('#pwmessage').html("<font color=red>비번 불일치</font>");
		$('#pwmessage').show();
		pwsame = "비번불일치";
	}
} // passwd_keyup의 끝

