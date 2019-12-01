<%@ page import="java.sql.*" %>
<jsp:useBean id="DB" class="beans.JavaBeans" scope="page"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Festival Metro</title>

        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.css" rel="stylesheet">

        <!-- Add custom CSS here -->
        <link href="css/style.css" rel="stylesheet">
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet">
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Lobster' rel='stylesheet' type='text/css'>
<style>
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
		.btn2{
  background-color: white;
  border: none;
  color: black;
  font-size: 20px;
  height:38px;
	}
	A:link {text-decoration:none; color:white;}
   	A:visited {text-decoration: none; color:white;}
    A:active {text-decoration: none; color:white;}
    A:hover {text-decoration: none; color:white;}
</style>
    </head>

    <body>
       <%@ include file = "sidemenubar.jsp" %>
        <!-- Portfolio -->
        <div id="places" class="places">
            <div class="container">
				<table width="100%">
						<tr>
							<td><p algn="left"><a href="/"><button type="button" class="btn1">before</button></a></p></td>
							<td><p align="right"><a href="/theme"><button type="button" class="btn1">next</button></a></p></td>
						</tr>
					</table>
                <div class="row">
                    <div class="col-md-4 col-md-offset-4 text-center">
                        <h2 class="main-title">테마별 즐길거리</h2>
                        <hr>
                    </div>
                </div>
            </div>  
            <div class="divide50"></div>  
            <div class="container">
				<table width = "100%">
					<tr>
						<td><button type="button" class="btn2" onclick="location.href='line.jsp'">전체</button></td>	
						<% 
						String[] theme_arr=new String[]{"고궁","공연","랜드마크","박물관과 미술관","쇼핑","역사적 장소","오래가게","음식","자연"};
						for(int i=0;i<9;i++){ %>
						<td><button type="button" class="btn2" onclick="location.href='theme.jsp?id=<%=i%>'"><%=theme_arr[i]%></button></td>
						<%}%>				
					</tr>
				</table>
				
				<div class="row">
				<%
					int id=0;
					String name="", station="", img="", line="";
					String[] theme_a=new String[]{"고궁","공연","랜드마크","박물관과 미술관","쇼핑","역사적 장소","오래가게","음식","자연"};
					Statement stmt=null;
					PreparedStatement pstmt=null;
					ResultSet rs=null;
					String sql="";
					if(request.getParameter("id")!=null){
						id=Integer.parseInt(request.getParameter("id"));
						sql="select a.name, a.img, a.station, s.line from attraction a, station2 s, subwayLine l , theme t where a.station=s.name and s.line=l.line_num and a.theme=t.theme_name and t.id="+id+" order by a.name";
					}
					else{
						sql="select a.name, a.img, a.station, s.line from attraction a, station2 s, subwayLine l where a.station=s.name and s.line=l.line_num order by a.name";
					}
					rs=DB.getResult(sql);
					if(rs==null){
						out.println("DB연동 오류");
					}
					else{
						while(rs.next()){
							name=rs.getString("name");
							System.out.println(name);
							station=rs.getString("station");
							img=rs.getString("img");
							line=rs.getString("line");
						%>				
							<!-- DB에서 불러오기 -->
							<div class="col-md-6 col-sm-12 col-xs-12">
		                        <div class="grid center-block">
		                            <figure class="effect-zoe">
		                                <img src="<%=img %> " class="img-responsive center-block" style="width:800px;height:400px;">
		                                <figcaption>
		                                    <h2><%=name %> </h2>
		                                    <p class="icon-links">
		                                        <a href="#"><i class="fa fa-heart-o"></i></a>
		                                        <a href="#"><i class="fa fa-eye"></i></a>
		                                        <a href="#"><i class="fa fa-bookmark-o"></i></a>
		                                    </p>
		                                    <p class="description"><%=line%>호선 &nbsp<%=station %>역</p>
		                                </figcaption>           
		                            </figure>
		                        </div>
		                    </div>
						<% } %>					
					<%} %>					
				</div>
			</div>
		</div>

        <!-- Footer -->
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-md-6 col-md-offset-3 text-center">
                        <div class="top-scroll">
                            <a href="#top"><i class="fa fa-arrow-circle-up scroll"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!-- /Footer -->

        <!-- JavaScript -->
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/jquery.parallax-1.1.3.js"></script>

        <!-- Custom JavaScript for the Side Menu and Smooth Scrolling -->
        <script>
        $("#menu-close").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
        </script>
        <script>
        $("#menu-toggle").click(function(e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
        </script>
        <script>
        $(function() {
            $('a[href*=#]:not([href=#])').click(function() {
                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                    var target = $(this.hash);
                    target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                    if (target.length) {
                        $('html,body').animate({
                            scrollTop: target.offset().top
                        }, 1000);
                        return false;
                    }
                }
            });
        });
        </script>

        <!-- modal -->

        <script>
            $('.modal').on('shown.bs.modal', function () {
                var curModal = this;
                $('.modal').each(function(){
                    if(this != curModal){
                        $(this).modal('hide');
                    }
                });
            });
        </script>

    </body>
</html>
