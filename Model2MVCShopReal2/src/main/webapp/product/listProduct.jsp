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
   
   function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit();
	}   
   //============== 검색 =================
   $(function() {
		// alert(1);
		 $( "button" ).on("click" , function() {
			//alert(1);
			fncGetList(1);	
		});
	 });
   
   $(function fncGetCategory(currentPage){
	    $(".list-group-item").on("click", function(){
	        var category = $(this).text().trim();
	        $("#currentPage").val(1);
	        $("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}&category="+category).submit();
	    });
	});

   
   
   $(function() {
	 
	    $(".ct_list_pop td:nth-child(8)").on("click", function() {
	    	var prodNo = $(this).closest("tr").find('input[name^="prodNo"]').val();
	    	$(this).closest("form").append('<input type="hidden" name^="prodNo" value="' + prodNo + '">');
	        $(this).closest("form").submit();
	        $.ajax({
	            url: "/product/json/getProduct/" + prodNo,
	            method: "GET",
	            dataType: "json",
	            success: function(JSONData, status) {
	                var displayValue = "<h6>" +
	                    "상품명 : " + JSONData.prodName + "<br>" +
	                    "상품상세정보 : " + JSONData.prodDetail + "<br>" +
	                    "제조일자 : " + JSONData.manuDate + "<br>" +
	                    "가격 : " + JSONData.price + "<br>" +
	                    "종류 :" + JSONData.category + "<br>" +
	                    "</h6>";
	                
	                $("h3").remove();
	                $("#" + prodNo + "").html(displayValue);
	            }
	        });
	    });
   });
   
   $(function() {
	    $(".ct_list_pop td:nth-child(2)").on("click", function() {
	        var prodNo = $(this).closest("tr").find('input[name^="prodNo"]').val();
	        // hidden input을 추가하여 form에 'prodNo' 값을 함께 전송합니다.
	        $(this).closest("form").append('<input type="hidden" name^="prodNo" value="' + prodNo + '">');
	        // form을 제출합니다.
	        $(this).closest("form").submit();
	       
	        self.location="/product/getProduct?menu=${param.menu}&prodNo="+prodNo;
	    });
	});
   
   
   $(function() {
	    // .ct_list_pop td:nth-child(3) 요소에 스타일 적용
	    $(".ct_list_pop td:nth-child(2)").css("color", "blue");
	    $("h7").css("color", "blue");

	    // .ct_list_pop:nth-child(4n+6) 요소에 스타일 적용
	    $(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
   });
   
	    //trancode 처리
	    $(function() {
	    $("#tranCode").on("click", function() {
	    	 var prodNo = $(this).closest("tr").find('input[name^="prodNo"]').val();		 
		        $(this).closest("form").append('<input type="hidden" name^="prodNo" value="' + prodNo + '">');
		        $(this).closest("form").submit();
		        alert(prodNo);
	        self.location = "/product/updateTranCodeByProd?prodNo="+prodNo+"&menu=${param.menu}";
	    });
	    });

</script>
</head>

<body>


<jsp:include page="/layout/toolbar.jsp" />

<div class="panel panel-default pull-left" style="width: 200px; margin-top: 150px;">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">카테고리</div>
                
                <!-- List group -->
                <ul class="list-group">
                    <li class="list-group-item">스포츠 용품</li>                 
                    <li class="list-group-item">가전제품</li>
                    <li class="list-group-item">음료/주류</li>
                    <li class="list-group-item">식물/화분</li>
                    
                </ul>
            </div>
        </div>
<div class="container col-md-10">
	
		<div class="page-header text-info">
	       
					<h3>상품 관리</h3>
				
	    </div>
	    
<div class="row">
	    
<div class="col-md-6 text-left">
  	<p class="text-primary">
  		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
   	</p>
</div>
		    
<div class="col-md-6 text-right">

	<form class="form-inline" name="detailForm">
			    
<div class="form-group">
 <select class="form-control" name="searchCondition" >
   <option value="0"  ${!empty search.searchCondition && search.searchCondition == 0 ? "selected":"" }>상품번호</option>
   <option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected":"" }>상품명</option>
   <option value="2" ${!empty search.searchCondition && search.searchCondition == 2 ? "selected":"" }>상품가격</option>
 </select>  
</div>   
	
<div class="form-group">
  <label class="sr-only" for="searchKeyword">검색어</label>
  <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
	 value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
</div>
				  
<button type="button" class="btn btn-default">검색</button>	
	
<input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
</form>
</div>	    	
</div>
	
<table class="table table-hover table-striped" >   

<thread>
   <tr>
   <th align="center">No</th>
   <th align="center">상품명</th>
   <th align="center">가격</th>
   <th align="center">등록일</th>
   <th align="center">분류</th>
   <th align="center">현재상태</th>
   <th align="center">간략정보</th>    
   </tr>
</thread>

<tbody>
<c:set var="i" value="0" />
<c:forEach var="vo" items="${list}">
    <c:set var="i" value="${i + 1}" />
    <tr class="ct_list_pop">
        <td align="center">${i}</td>    
        <td align="left">${vo.prodName}</td>
        <input type="hidden" name="prodNo${i}" value="${vo.prodNo }"/>
        <td align="left">${vo.price}</td>
        <td align="left">${vo.regDate}</td>
        <td align="left">${vo.category }</td>
        <td align="left">
   <c:if test = "${not empty param.menu and param.menu eq 'manage' }" >
        <c:choose>
      <c:when test="${vo.proTranCode==null }">
        판매중
      </c:when>
      <c:when test="${vo.proTranCode eq '0' }">
        구매완료
  	<span class="glyphicon glyphicon-envelope" id="tranCode"></span>
      </c:when>
      <c:when test="${vo.proTranCode eq '1' }">
         배송중
      </c:when> 
      <c:when test="${vo.proTranCode eq '2' }">  
         배송완료
      </c:when>   
        </c:choose>
        </c:if>             
        <c:if test = "${empty param.menu or param.menu eq 'null' or param.menu eq 'search' }">
        <c:choose>
        <c:when test="${vo.proTranCode==null}">
            판매중
        </c:when>
        <c:otherwise>
            재고없음
        </c:otherwise>
    </c:choose></c:if></td>
      <td align="left">
      	<i class="glyphicon glyphicon-ok" id="${vo.prodNo }"></i>
    </td>
       </tr>
</c:forEach>
</tbody>
</table>
<input type="hidden" id="currentPage" name="currentPage" value=""/>
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
</div>


	
</body>
</html>