<%@ page import="java.sql.*" %>
<%@ page import="beans.JavaBeans" %>
<jsp:useBean id="DB" class="beans.JavaBeans" scope="page"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

 
		<!DOCTYPE html>
		<html lang="en">
		<head>

			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<meta name="description" content="">
			<meta name="author" content="">

				<title>쪽지함</title>

				<!-- Bootstrap core CSS -->
				<link href="css/bootstrap.css" rel="stylesheet">

				<!-- Add custom CSS here -->
				<link href="css/style.css" rel="stylesheet">
				<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
				<link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
				<link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
				 <!-- bootstrap.min css -->
		  <link rel="stylesheet" href="plugins/bootstrap/css/bootstrap.min.css">
		  <!-- Ionic Icon Css -->
		  <link rel="stylesheet" href="plugins/Ionicons/css/ionicons.min.css">
		  <!-- animate.css -->
		  <link rel="stylesheet" href="plugins/animate-css/animate.css">
		  <!-- Magnify Popup -->
		  <link rel="stylesheet" href="plugins/magnific-popup/dist/magnific-popup.css">
		  <!-- Owl Carousel CSS -->
		  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick.css">
		  <link rel="stylesheet" href="plugins/slick-carousel/slick/slick-theme.css">

		  <!-- Main Stylesheet -->
		  <link rel="stylesheet" href="css/style.css">
		  <link rel="stylesheet" href="./css/swiper.min.css">

				<!-- 추가한부분-->
		    <link rel="stylesheet" href="style1.css">
			<meta charset="UTF-8">
			<meta http-equiv="X-UA-Compatible" content="ie=edge">
			<title>오잉</title>
			<style>
		input[type="submit"]{
		  background-color: #28B4B4;
		  border: none;
		  color: white;
		  padding: 15px 32px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 16px;
		  border-radius:10px;
		  width:260px;
		  height:38px;
		}

		.box{
			position:center;
			top:0;left:0;bottom:0;right:0;
			height:10%;
			margin:15% auto;
			text-align:center;
		}
		input[type="text"]{
			border:none;
			border-bottom:2px solid #0A9696;
		}
		input[type="password"]{
			border:none;
			border-bottom:2px solid #0A9696;
		}
		.btn1{
		  background-color: white;
		  border: none;
		  color: black;
		  padding: 15px 32px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 20px;
		  border-radius:10px;
		  width:30px;
		  height:38px;
		}
		.swiper-container {
     	 	width: 90%;
     	 	height: 100%;
    	}
	</style>
	</head>
		<body id ="body">
		
	<%
		ResultSet rs=null;
 		request.setCharacterEncoding("utf-8");
 		//String login_user = (String)session.getAttribute("user_id");
 		String user_id = (String)session.getAttribute("user_id");
 		String sender="",content="", time="";
 		String sql = "";
 		
	%>
	  <%@ include file = "sidemenubar.jsp" %>
	
		<section class="page-title bg-2">
			<div class="container">
			  <div class="row">
				<div class="col-md-12">
				  <div class="block">
					<h1>쪽지함  </h1>
				  </div>
				</div>
			  </div>
			</div>
		  </section>
						
			 <div class="col-md-12">
				 <div class="post post-single">	  
				<div class="post-comments-form">
					<h3 class="post-sub-heading" style="text-align: center;"></h3> 
					 <div class="row">
					 <%
					 sql= "select * from message where receiver='"+ user_id+"'";
					 rs =DB.getResult(sql);
				 		while (rs.next()){
				 			sender = rs.getString("sender");
				 			content = rs.getString("content");
				 			time = rs.getString("time");
				 			
				 			String date = time.substring(0,10);
							String tt = time.substring(11,19);
					 %>
						<!-- 	 for (let data of results){ -->
								<div class="col-md-6 form-group">
									<!-- Name -->
									
									<form method="post" action="message.jsp" id="form" role="form">
										<div class=" from-group col-md-12" >
											<p>내용: <%=content %> <button type="submit" style="float: right;">
													  답장하기  
												 </button></p>
											<h5>보낸 사람 :  &nbsp <%=sender%> &nbsp[<%=date%> / <%=tt %>] </h5>
											
											<input type = "hidden" name = "user_id" value="<%= sender%>"/>
											<hr width = "100%">
											
										</div>
									</form>
								</div>
						<% }%>
					  </div>
					  

				</div>
				</div>
				</div>

    </body>
</html>
				