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
  
  //상품번호를 매개변수로 전달->request.getParameter("pno")
  int pno=Integer.parseInt(request.getParameter("pno"));
  //-----------------------------------------------------------------
  
  try{
     //pool=DBConnectionMgr.getInstance();
     con=pool.getConnection();
     //System.out.println("폰목록보기위한 DB접속 확인(con=>)"+con);
    
     String sql="select * from phone where productnum=?";
     pstmt=con.prepareStatement(sql);
     //추가
     pstmt.setInt(1,pno);
     //------------------------
     rs=pstmt.executeQuery();
%>
<!-- page지정(3가지 구성요소) -->
<div data-role="page">
   <!--1.header 지정(머리말)  -->
    <div data-role="header">
       <h1>휴대폰 상세보기</h1>
      <!-- <a href="#" data-icon="arrow-l">이전</a> 디자인만  -->
      <a data-icon="arrow-l" data-rel="back">이전</a>
    </div>
   <!--2.content 지정(본문)  -->
   <div data-role="content">
         <%
              if(rs.next()){
            	 int productnum=rs.getInt("productnum");//상품번호
            	 String model=rs.getString("model");//모델명
                 String company=rs.getString("company");//제조사(회사)
                 int price=rs.getInt("price");//가격
                 String color=rs.getString("color");//폰의 색깔
                 String image=rs.getString("image");//폰의 이미지
         %>
        <div class="image_phone">
             <img src="../image/<%=image %>">
        </div>
        <div class="content_phone">
            <p>모델명:<%=model%></p>
            <p>제조사:<%=company%></p>
            <p>가   격:<%=price%></p>
            <p>색   상:<%=color%></p>
        </div>
          <% } %>
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
  }
%>
</body>
</html>




