<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="phone.*,java.sql.*" %>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,
                                            maximum-scale=1.0,minimum-scale=1.0,
                                            user-scalable=no">
<title>jQueyMobile 예제</title>
<link rel="stylesheet" href="../mobile/jquery.mobile-1.3.2.min.css">
<style type="text/css">
     /* 불러오는 이미지에 대한 스타일과 DB정보의 각 필드에 대한 스타일 */
   .img_phone{
      width:100;
      margin:0 15px 0 0;
      float:left; /* 이미지는 왼쪽 정렬 기준,오른쪽 여백 설정 */
   }
   .content_phone{
       font-size:13pt;
   }
</style>

<script type="text/javascript" src="../mobile/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../mobile/jquery.mobile-1.3.2.min.js"></script>
</head>
<body>
<%
  Connection con=null;
  PreparedStatement pstmt=null;
  ResultSet rs=null;
  DBConnectionMgr pool;
  pool=DBConnectionMgr.getInstance();
  
  try{
     //pool=DBConnectionMgr.getInstance();
     con=pool.getConnection();
     System.out.println("폰목록보기위한 DB접속 확인(con=>)"+con);
     //가장 최근에 산 핸드폰의 목록이 맨앞에 위치
     String sql="select * from phone order by productnum desc";
     pstmt=con.prepareStatement(sql);
     rs=pstmt.executeQuery();
%>
<!-- page지정(3가지 구성요소) -->
<div data-role="page">
   <!--1.header 지정(머리말)  -->
    <div data-role="header">
       <h1>휴대폰 목록보기</h1>
    </div>
   <!--2.content 지정(본문)  -->
   <div data-role="content">
     <ul data-role="listview">
         <%
              while(rs.next()){
            	 int productnum=rs.getInt("productnum");
                 String company=rs.getString("company");
                 int price=rs.getInt("price");
                 String image=rs.getString("image");
         %>
          <li>
             <a href="phonedetail.jsp?pno=<%=productnum%>">
             <img src="../image/<%=image%>" width="80" height="80">
             <h1><%=company%></h1>
             </a>
          </li>
          <% } %>
     </ul>
    </div>
   <!--3.footer 지정(꼬리말)  -->
   <div data-role="footer">
       <h1>footer</h1>
    </div>
</div>
<%
  }catch(Exception e){
	  e.printStackTrace();
  }finally{
	  //DB연결 메모리 해제
	   pool.freeConnection(con, pstmt, rs);
	  /*
	    if(rs!= null){try{rs.close();}catch(SQLException e){};}
		if(pstmt!= null){try{pstmt.close();}catch(SQLException e){};}
		if(con!= null){try{con.close();}catch(SQLException e){};}
	   */
  }
%>
</body>
</html>




