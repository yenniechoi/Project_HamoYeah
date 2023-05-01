<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Detail</title>
<style>
#content {
	text-align: center;
}
#host {
	text-align: center;
}
#participate {
	text-align: center;
}
#comments {
	text-align: center;
}
#modal.modal-overlay {
	width: 100%; /* 뒤 블러 배경 꽉 차게 */
	height: 100%; /* 뒤 블러 배경 꽉 차게 */
	position: absolute;
	left: 0;
	top: 0;
	display: none; /* 모달창 항시 띄울 지 말 지*/
	flex-direction: column; /* 아이템(글자)가 세로방향으로 */
	align-items: center; /* 모달창 가로 위치 */
	justify-content: center; /* 모달창 세로 위치 */
	background: rgba(255, 255, 255, 0.25);
	/*  	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); */
	backdrop-filter: blur(1.5px); /* 오버레이 배경 흐리게 */
	/*  	-webkit-backdrop-filter: blur(1.5px); */
	/* 	border-radius: 10px; */
	/* 	border: 1px solid rgba(255, 255, 255, 0.18); */
}

#modal .modal-window {
	background: rgba(1, 1, 1, 0); /* 모달창 배경색 */
	box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37); /* 테두리 그림자 */
	/* 	-webkit-backdrop-filter: blur(13.5px); */
	border-radius: 10px; /* 테두리 둥글게 */
	border: 5px solid rgba(0, 0, 0, 0); /* 경계 투명 */
	width: 400px;
	height: 300px;
	position: relative;
	top: -100px;
	padding: 10px;
}

#modal .title {
	padding-left: 160px;
	display: inline;
	/* 	text-shadow: 1px 1px 2px gray; */
	color: black;
}

#modal .title h3 {
	display: inline;
}

#modal .close-area {
	display: inline;
	float: right;
	padding-right: 10px;
	cursor: pointer;
	/* 	text-shadow: 1px 1px 2px gray; */
	color: black;
}

#modal .content {
	margin-top: 20px;
	padding: 0px 10px;
	/* 	text-shadow: 1px 1px 2px gray; */
	color: gray;
}
</style>
<script type="text/javascript">

//참가신청 버튼 실행시
function par(){
// 	const xhttp = new XMLHttpRequest();
// 	let param = "memberId=" + ${sessionScope.loginId};
// 	param += "&boardNum=" + ${boardvo.boardNum}; 
// 	xhttp.open("POST", "${pageContext.request.contextPath}/board/boardDetail.do");
// 	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
// 	xhttp.send(param);		
}

//댓글
function comm(){
	//alert("comm");
	const xhttp = new XMLHttpRequest();
    
    xhttp.onload = function(){ 
    	//alert("result");
    	let arr = JSON.parse(xhttp.responseText);
    	html = '';
    	for(let obj of arr){
    		html += '<div id=' + obj.repNum + '>';
    		html += '<span class="author">' + obj.memberId + '   </span>';
    		html += '<span class="content">' + obj.content;
    		// 여기부터 
    		html += '<c:if test="${sessionScope.loginId eq' + obj.memberId + '}">';
    		html += "<input type='button' value='삭제' onclick='del(\"" + obj.repNum + "\")'>";
    		// 여기까지 안 됨 ^^..
    		html += '</c:if></span></div><br/>'
    	}
		let div = document.getElementById("reps");
    	div.innerHTML = html;
    	repf.content.value = '';
	}


	let param = "memberId=${sessionScope.loginId}";
	param += "&boardNum=${boardvo.boardNum}"; 
	param += "&content=" + repf.content.value; 
	param += "&reRepNum=0";
	//alert(param);
	xhttp.open("POST", "${pageContext.request.contextPath}/board/comment.do");
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(param);	
}	
//댓글 삭제
function del(repNum) {
    //alert("del");
    const xhttp = new XMLHttpRequest();
  
    xhttp.onload = function(){ 
//         alert("delrep");
//         let arr = JSON.parse(xhttp.responseText);
//         html = '';

        // 화면에서 데이터 지우기 
        let repDiv = document.getElementById("reps");
        let delrep = document.getElementById(repNum);
        repDiv.removeChild(delrep);
    };
    
   		// db에서 데이터 삭제
   		let param =  "repNum=" + repNum;
    	//alert(param);
    	xhttp.open("POST", "${pageContext.request.contextPath}/board/delcomment.do");
    	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    	xhttp.send(param);
   
}

// 즐겨찾기 
function fav(board, id) {
	const xhttp = new XMLHttpRequest();
	
	xhttp.onload = function() {
		let obj = JSON.parse(xhttp.responseText);
		let img = document.getElementById("img");
		if(obj.color == 0){
			img.src = "../img/F1.png";
		} else {
			img.src = "../img/F2.jpeg";
		}
	}
	
    let param = "boardNum=" + board;
    param += "&memberId=" + id;
	xhttp.open("Post", "${pageContext.request.contextPath}/board/favorites.do");
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send(param);
	
}

// 게시글 삭제 
function delBoard(boardNum, memberId) {
	let check = confirm("정말 삭제하시겠습니까?");
	if (check == true) {
		let param = "?boardNum=" + boardNum;
		param += "&memberId=" + memberId;
		location.href = "${pageContext.request.contextPath}/board/deleteBoard.do" + param;
	}
}
// 신고하기 기타의견 제약조건
function reportBoard(){
	let checkedRadio = document.querySelector("input[type=radio]:checked").value;
	if(checkedRadio == 6){
		let etc = document.getElementById("etc").value; // textarea value 먼저 변수에 담고
		if(etc == ''){ // value가 널이라면
			alert("기타 의견을 입력해 주세요.");
			event.preventDefault();
			return;
		}
		document.getElementById("warnetc").value = etc; // 널이 아니면 라디오버튼에 담기
	}
	const xhttp = new XMLHttpRequest();
	let param = "?memberId=${sessionScope.loginId}";
	param += "&boardNum=${boardvo.boardNum}";
	param += "&content=" + document.querySelector("input[type=radio]:checked").value;
	xhttp.open("get", "${pageContext.request.contextPath}/board/warning.do" + param);
	xhttp.send();

	xhttp.onload = function() {
		let val = xhttp.responseText;
		let obj = JSON.parse(val);
		if (obj.flag) {
			alert("신고 접수가 완료되었습니다.");
			event.preventDefault();
			return;
		} else {
			alert("이미 신고한 게시글입니다.");
			event.preventDefault();
			return;
		}
	}
}
</script>
</head>
<body>
<!-- 작성자가 본인일 경우 + 옐로카드 3미만일 경우 -->
<c:if test="${sessionScope.loginId eq boardvo.memberId && boardvo.y_card < 3}">
	<input type="button" value="수정" onclick="javascript:location.href='${pageContext.request.contextPath}/board/editBoard.do?boardNum=${boardvo.boardNum }'">
	<input type="button" value="삭제" onclick="delBoard('${boardvo.boardNum}', '${sessionScope.loginId}')">
</c:if>
<!-- 로그인 했지만 작성자가 아닐 경우 -->
<c:if test="${not empty sessionScope.loginId && sessionScope.loginId ne boardvo.memberId }">
	<c:if test="${boardvo.fav eq 0}"> 
		<img src="../img/F2.jpeg" id="img" style="width:20px; height:20px;"  onclick="fav('${boardvo.boardNum}', '${sessionScope.loginId }')">
	</c:if>
	<c:if test="${boardvo.fav eq 1}"> 
		<img src="../img/F1.png" id="img" style="width:20px; height:20px;"  onclick="fav('${boardvo.boardNum}', '${sessionScope.loginId }')">
	</c:if>
	<input type="button" id="reportbtn" value="신고">
		<div id="modal" class="modal-overlay">
		<div class="modal-window">
			<div class="title">
				<h3>신고하기</h3>
			</div>
			<div class="close-area">X</div>
			<div class="content">
				<form action="" method="post" name="f">
				<input type="hidden" name="memberId" value="${sessionScope.loginId }">
				<input type="hidden" name="boardNum" id="${boardvo.boardNum}" value="${boardvo.boardNum}">
				<input type="radio" name="content" id="warn" value="1" onclick="this.form.textarea.disabled=true">정치적 글<br/>
				<input type="radio" name="content" id="warn" value="2" onclick="this.form.textarea.disabled=true">테러조장 글<br/>
				<input type="radio" name="content" id="warn" value="3" onclick="this.form.textarea.disabled=true">폭력적 글<br/>
				<input type="radio" name="content" id="warn" value="4" onclick="this.form.textarea.disabled=true">홍보목적 글<br/>
				<input type="radio" name="content" id="warn" value="5" onclick="this.form.textarea.disabled=true">유해한 글<br/>
				<input type="radio" name="content" id="warnetc" value="6" onclick="this.form.textarea.disabled=false">기타<br/>
				<textarea name="textarea" id="etc" cols="50" rows="7" style="scrolling:yes" placeholder="기타 의견을 입력해 주세요." disabled></textarea>
				<input type="hidden" name="memberId" id="id" value="s1">
				<input type="hidden" name="boardNum" id="num" value="4">
				<input type="button" value="신고" id="reportbtn2" onclick="reportBoard()">
				</form>
			</div>
		</div>
	</div>
	<script>
	const modal = document.getElementById("modal")
	function modalOn() {
		modal.style.display = "flex"
	}
	function isModalOn() {
		return modal.style.display === "flex"
	}
	function modalOff() {
    	modal.style.display = "none"
	}
	const btnModal = document.getElementById("reportbtn")
	btnModal.addEventListener("click", e => {
    	modalOn()
	})
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
    	modalOff()
	})
	modal.addEventListener("click", e => {
    	const evTarget = e.target
    	if(evTarget.classList.contains("modal-overlay")) {
        	modalOff()
    	}
	})
	window.addEventListener("keyup", e => {
    	if(isModalOn() && e.key === "Escape") {
        	modalOff()
    	}
	})
	</script>
</c:if>
	
<div id="content">
<%-- 	<input type="button" value="목록" onclick="javascript:location.href='${pageContext.request.contextPath }/board/boardList.do'"> --%>
	<br/><img src="${boardvo.imagepath }" style="width:300px; height:300px;"> <!-- boardvo 등록된 게시글 이미지 -->
	<h2> ${boardvo.title } </h2><!-- boardvo 제목 -->
	<h4> 장소 |  ${boardvo.place } </h4>
	<h4> 날짜 |  ${boardvo.dDay } </h4>
	<h5> ${boardvo.ok } 명 / ${boardvo.peopleMax} 명 </h5>
	<br/><br/>
	<h4> ${boardvo.content } </h4> <!-- boardvo 게시글 등록 내용 -->
</div>
	
	<br/><br/>
<div id="host">
	<h4> host </h4>
	<img src="${membervo.imagepath }" style="width:50px; height:50px;"><!-- membervo 프로필사진  -->
	<p>${membervo.nickname } </p>
<%-- 	<h5>${membervo.intro }</h5> <!-- membervo 한줄소개  --> --%>
</div>

	<br /> <br/>
	<br /> 
	
<div id="participate">	
	<!-- 참여자 리스트 -->
<!-- 	<div id="ok"> -->
<%-- 		<c:forEach var="membervo" items="${mvolist }"> --%>
<%-- 			<div id="${membervo.memberId }"> --%>
<%-- 			<img src="${membervo.imagepath }"><br/> --%>
<%-- 			${membervo.nickname }<br/> --%>
<!-- 			</div> -->
<%-- 		</c:forEach> --%>
<!-- 	</div> -->
	
	<input type="button" value="참여신청" onclick="par()">
	<br/><br/>
</div>

<c:if test="${not empty sessionScope.loginId && boardvo.y_card < 3}">
	<!-- 댓글 -->
<div id="comments">
		<h4> comment </h4>
		<div id="reps">
			<c:forEach var="rep" items="${boardvo.reps}">
				<div id="${rep.repNum}">
					<span class="author">${rep.memberId}</span> <span class="content">
						${rep.content}
					<c:if test="${sessionScope.loginId eq rep.memberId}">
					<input type="button" value="삭제" onclick="del('${rep.repNum}')">					
					</c:if>					
					</span>
				</div>
				<br />
			</c:forEach>
		</div>
		
		<form action="" name="repf" method="post">
			<input type="hidden" name="boardNum" value="${boardvo.boardNum}" readonly> 
			<input type="hidden" name="memberId"value="${sessionScope.loginId}" readonly>
			<input type="text" name="content" id="content"> 
			<input type="button" value="작성" onclick="comm()">
		</form>
</div>
</c:if>
</body>
</html>