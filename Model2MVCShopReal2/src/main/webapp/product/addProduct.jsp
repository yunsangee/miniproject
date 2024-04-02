<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width" initial-scale=1.0/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script type="text/javascript" src="../javascript/CommonScript.js"></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
    body{
    	padding-top : 50px
    	}
    </style>
    
   <script type="text/javascript">
	$(function(){
		$("#add").on("click",function(){
			self.location ="/product/addProduct";
		});
		
		$("#ok").on("click",function(){
			self.location = "/product/listProduct?menu=manage";
		});	
	});
	</Script>

</head>

<body>
<jsp:include page="/layout/toolbar.jsp" />

	<div class="col-sm-3 control-label page-header text-info">
	<h3> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 상품 등록 완료 </h3>
	
	<div class="container">
<form class="form-horizontal" name="detailForm" enctype = "multipart/form-data">
<div style="border: 5px solid #ccc; border-radius: 30px; padding: 10px;">
	<div class="form-group">
                <label for="product" class="col-sm-2 control-label" >상 품 명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="prodName" name="prodName" placeholder="${product.prodName }">
                </div>
                </div>
              
	<div class="form-group">
    <label for="product" class="col-sm-2 control-label">상품 상세정보</label>
    <div class="col-sm-6">
        <input type="text" class="form-control" id="prodDetail" name="prodDetail"  placeholder="${product.prodDetail }">
    </div>
</div>
		  
		  <div class="form-group">
		    <label for="product" class="col-sm-2 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="price" class="form-control" id="price" name="price" placeholder="${product.price }">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="product" class="col-sm-2 control-label">제조일자</label>
		    <div class="col-sm-4">
  			  <input type="text" class="col-sm-6 form-control" id="manuDate" name="manuDate" placeholder="${product.manuDate }"/>
  				</div>
		  </div>
		 
		
		  <div class="form-group">
   			<label for="product" class="col-sm-2 control-label">이미지</label>
   			 <div class="col-sm-5">
           <img src="/images/uploadFiles/${product.fileName}" width="300" height="300"/>
      	  </div>
    	</div>

							
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" id="add" class="btn btn-primary"  >추가 등록</button>
			  <a class="btn btn-primary btn" id="ok" href="#" role="button">확&nbsp;인</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		</div>
 	</div>
 

</body>
</html>