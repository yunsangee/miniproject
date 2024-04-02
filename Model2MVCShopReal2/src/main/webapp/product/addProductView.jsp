<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html lang ="ko">
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
		<script src="/javascript/calendar.js"></script>
  
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	body{
		padding:50px;
		}
     body > div.container{
        	border: 10px solid #D6CDB7;
            margin-top: 5px;
        }
    .flatpickr-calendar {
    left: auto;
    right: 0;
    width: 10px;
  }
    </style>

	<script type="text/javascript">
    $(document).ready(function() {
        // 달력 아이콘을 클릭했을 때 달력을 보여주는 이벤트 처리
        $("#calendarIcon").click(function() {
            show_calendar('document.detailForm.manuDate', $('#manuDate').val());
        });

        function fncAddProduct() {
            //Form 유효성 검증
            var name = $("#prodName").val();
            var detail = $("#prodDetail").val();
            var manuDate = $("#manuDate").val();
            var price = $("#price").val();
            var fileName = $("#fileName").val();

            if (name == null || name.length < 1) {
                alert("상품명은 반드시 입력하여야 합니다.");
                return;
            }
            if (detail == null || detail.length < 1) {
                alert("상품상세정보는 반드시 입력하여야 합니다.");
                return;
            }
            if (manuDate == null || manuDate.length < 1) {
                alert("제조일자는 반드시 입력하셔야 합니다.");
                return;
            }
            if (price == null || price.length < 1) {
                alert("가격은 반드시 입력하셔야 합니다.");
                return;
            }

            $("form[name='detailForm']")
                .attr("method", "POST")
                .attr("action", "/product/addProduct")
                .attr("enctype", "multipart/form-data")
                .submit();
        }

        $("#add").on("click", function() {
            alert("등록");
            fncAddProduct();
        });

        $("#cancel").on("click", function() {
            alert("취소");
            $("form")[0].reset();
        });
    });
</script>
</head>

<body>

<jsp:include page="/layout/toolbar.jsp" />

	<div class="col-sm-3 offset-sm-5 control-label page-header text-info">
	<h3> &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 상품 등록</h3>
	
	<div class="container">
<form class="form-horizontal" name="detailForm" enctype = "multipart/form-data">
<div style="border: 5px solid #ccc; border-radius: 30px; padding: 10px;">
	<div class="form-group">
                <label for="product" class="col-sm-2 control-label" >상 품 명</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" id="prodName" name="prodName">
                </div>
                </div>
              
	<div class="form-group">
    <label for="product" class="col-sm-2 control-label">상품 상세정보</label>
    <div class="col-sm-6">
        <input type="text" class="form-control" id="prodDetail" name="prodDetail" style="word-wrap: break-word;">
    </div>
</div>
		  
		  <div class="form-group">
		    <label for="product" class="col-sm-2 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="price" class="form-control" id="price" name="price">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="product" class="col-sm-2 control-label">제조일자</label>
		    <div class="col-sm-4">
  			  <input type="text" class="col-sm-6 form-control" id="manuDate" name="manuDate"/>
  				</div>
  				 <button class="btn btn-default" type="button" id="calendarIcon">
                    <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
				</button>
		  </div>
		 
		
		  <div class="form-group">
   			<label for="product" class="col-sm-2 control-label">이미지 삽입</label>
   			 <div class="col-sm-5">
            <input type="file" class="form-control" id="imagefile" name="imagefile" value="../../images/empty.GIF">
      	  </div>
    	</div>

							
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" id="add" class="btn btn-primary"  >등&nbsp;록</button>
			  <a class="btn btn-primary btn" id="cancle" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		</div>
 	</div>
 

</body>
</html>