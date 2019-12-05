<%@ page import="java.sql.*"%>
<jsp:useBean id="DB" class="beans.JavaBeans" scope="page" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>Enjoy SEOUL</title>

<!-- Bootstrap core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">

<!-- Add custom CSS here -->
<link href="css/style.css" rel="stylesheet">


</head>
<body id="body">
	<%@ include file="sidemenubar.jsp"%>

	<%
			String login_user = (String)session.getAttribute("user_id");  // 현재 로그인한 사용자 아이디 가져오기 
			//로그인 안 해도 글 볼 수 있게 처리 
			if ( login_user == null) login_user = "";
			ResultSet rs=null;
			 request.setCharacterEncoding("utf-8");
			 String user_id ="", score="", content="";
			 String name="", phone_number="", address="", station="",contents="", time="", holiday="", fee="", etc="", theme="", img="", line ="";
			 int id = Integer.parseInt(request.getParameter("id"));
			 String sql = "select a.*, s.line from attraction a, station2 s, subwayLine l where a.station=s.name and s.line=l.line_num and a.id="+id;

			 rs =DB.getResult(sql);
			 
				 if (rs.next()){
					 name = rs.getString("name");
					 phone_number = rs.getString("phone_number");
					 address = rs.getString("address");
					 station = rs.getString("station");
					 contents = rs.getString("contents");
					 time = rs.getString("time");
					 holiday = rs.getString("holiday");
					 fee = rs.getString("fee");
					 etc = rs.getString("etc");
					 theme = rs.getString("theme");
					 img = rs.getString("img");
					 line = rs.getString("line");
					 } 
		%>
	<section class="page-title bg-2">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block">
						<h1><%= name %></h1>
						<p><%=theme %></p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="page-wrapper">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="post post-single">
						<div class="post-thumb">
							<img class="img-responsive" src="<%=img %>" alt="" align="center" width="1000" height=auto>
						</div>
						<div class="post-content post-excerpt">
							<blockquote class="quote-post">
								<p>상세 설명</p>
							</blockquote>
							<p><%=contents%></p>
							<hr>
							<br>
							<% if(phone_number!=null && !phone_number.equals("없음")){%><p>전화번호 : <%=phone_number %></p><%} %>
							<% if(address!=null&&!address.equals("없음")){%><p>주소 : <%=address%></p><%} %>
							<% if(time!=null&&!time.equals("없음")){%><p>운영시간 : <%=time%></p><%} %>
							<% if(line!=null&&!line.equals("없음")){%><p>교통  : <%=line %>호선  <%=station%>역 </p><%} %>
							<% if(holiday!=null&&!holiday.equals("없음")){%><p>휴무일 : <%=holiday%></p><%} %>
							<% if(fee!=null&&!fee.equals("없음")){%><p>요금  : <%=fee%></p><%} %>
							<% if(etc!=null&&!etc.equals("없음")){%><p>비고  : <%=etc%></p><%} %>
						</div>
						<div class="post-comments-form">
							<h3 class="post-sub-heading">후기</h3>

							<div class="row">
								<%
							sql = "select * from review_test where kind = 'attraction' and posting_id = "+id;
							rs =DB.getResult(sql);
							if (!rs.isBeforeFirst()){
								%>
								<p>&nbsp&nbsp&nbsp후기가 없습니다 </p>
								<% 
							}
								while (rs.next()){
									user_id = rs.getString("user_id");
									score = rs.getString("score");
									content = rs.getString("content");
									time = rs.getString("time");
									
									String date = time.substring(0,10);
									String tt = time.substring(11,19);
							%>
								<!-- 	 for (let data of results){ -->
								<div class="col-md-6 form-group">
									<!-- Name -->
									<div class=" from-group col-md-12">
										<%
											if(login_user.equals(user_id) && login_user != ""){
										%>
									<form method="post" action="reviewDeleteAction.jsp" id="form" role="form">

										<%
											//이 부분에서 오류 난다면 다시 로그인 한 후 실행
											if(login_user.equals(user_id) && login_user != ""){
										%>
										<button type="submit" class="btn btn-main "
											style="float: right;">삭제</button>
										<% } %>
										<p>
											평점: &nbsp
											<%= score %></p>
										<p>
											<%=content%>
										</p>
										<h5>
											작성자: &nbsp
											<%=user_id%>
											&nbsp[<%=date%>
											/
											<%=tt %>]
										</h5>
										<input type="hidden" name = "time" value = "<%=time%>"/>
										<input type="hidden" name = "user_id" value = "<%=user_id %>"/>
										</form>
										<%
										}else{
										%>
									<form method="post" action="message.jsp" id="form" role="form">										
									<p>
									
											평점: &nbsp
											<%= score %></p>
										<p>
											내용:
											<%=content%>
										</p>
										
										<h5>작성자: &nbsp<%=user_id %> <button type="submit">쪽지 보내기 </button></h5>
										<h5>
											&nbsp[<%=date%>
											/
											<%=tt %>]
										</h5>
										
										
										<%} %>
										<input type="hidden" name = "time" value = "<%=time%>"/>
										<input type="hidden" name = "user_id" value = "<%=user_id %>"/>
										
										</form>
										</div>
										</div>
								<% } %>
								<hr width="100%">
							</div>
						</div>
						<jsp:include page="inputReview.jsp">
							<jsp:param name="c_name" value="<%=name %>" />
							<jsp:param name="id" value="<%=id %>" />
							<jsp:param name="kind" value="attraction" />
						</jsp:include>
					</div>

				</div>
			</div>
		</div>
	</section>
	<!-- JavaScript -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="js/jquery.parallax-1.1.3.js"></script>
</body>
</html>

