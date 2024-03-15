<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.*" %>

<%
   Page resultPage = (Page)request.getAttribute("resultPage");
   Search search =(Search)request.getAttribute("search");
   
%>

<html>
<head>
<title>상품 목록조회</title>




<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetProductList(currentPage){
    document.getElementById("currentPage").value = currentPage;
    document.detailForm.submit();
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">

<table width="100%" height="37" border="0" cellpadding="0"   cellspacing="0">
   <tr>
      <td width="15" height="37">
         <img src="/images/ct_ttl_img01.gif" width="15" height="37">
      </td>
      <td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td width="93%" class="ct_ttl01">
               <c:if test = "${not empty param.menu and param.menu eq 'manage' }" >
					상품 관리
				</c:if>
				<c:if test = "${empty param.menu or param.menu eq 'null' or param.menu eq 'search' }">
					상품 목록조회
				</c:if></td>
            </tr>
         </table>
      </td>
      <td width="12" height="37">
         <img src="/images/ct_ttl_img03.gif" width="12" height="37">
      </td>
   </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
   <tr>
<br><br>
      <td align="right">
         <select name="searchCondition" class="ct_input_g" style="width:80px">
         <option value="0"  ${!empty search.searchCondition && search.searchCondition == 0 ? "selected":"" }>상품번호</option>
            <option value="1" ${!empty search.searchCondition && search.searchCondition == 1 ? "selected":"" }>상품가격</option>
               <option value="2" ${!empty search.searchCondition && search.searchCondition == 2 ? "selected":"" }>상품명</option>
         </select>
         </select>
         <input    type="text" name="searchKeyword" 
         value="${! empty search.searchKeyword ? search.searchKeyword : ""}"  
         class="ct_input_g"  style="width:200px; height:20px" >
      </td>

      <td align="right" width="70">
         <table border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td width="17" height="23">
                  <img src="/images/ct_btnbg01.gif" width="17" height="23">
               </td>
               <td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
                  <a href="javascript:fncGetProductList('1');">검색</a>
               </td>
               <td width="14" height="23">
                  <img src="/images/ct_btnbg03.gif" width="14" height="23">
               </td>
            </tr>
         </table>
      </td>
   </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
   <tr>
      <td colspan="11" >전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage } 페이지</td>
   </tr>
   <tr>
      <td class="ct_list_b" width="100">No</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">상품명</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b" width="150">가격</td>
      <td class="ct_line02"></td>
      <td class="ct_list_b">등록일</td>   
      <td class="ct_line02"></td>
      <td class="ct_list_b">현재상태</td>      
   </tr>
   <tr>
      <td colspan="11" bgcolor="808285" height="1"></td>
   </tr>
   <%---    
      for(int i=0; i<list.size(); i++) {
         Product vo = list.get(i);
   
   <tr class="ct_list_pop">
      <td align="center"> <%=i+1%></td>
      <td></td>
      <td align="left">
         <a href="/product/getProduct?prodNo=<%=vo.getProdNo()%>&menu=<%=request.getParameter("menu")%>"><%= vo.getProdName()%></a>
      </td>
      <td></td>
      <td align="left">   <%= vo.getPrice() %></td>
      <td></td>
      <td align="left">    <%= vo.getRegDate() %>
      </td><td>
      <td align="left">      
   </tr>
   <tr>
      <td colspan="11" bgcolor="D6D7D6" height="1"></td>
   </tr>
   <% } --%>
   <c:set var="i" value="0" />
<c:forEach var="vo" items="${list}">
    <c:set var="i" value="${i + 1}" />
    <tr class="ct_list_pop">
        <td align="center">${i}</td>
        <td></td>
        <td align="left"><a href="/product/getProduct?prodNo=${vo.prodNo}&menu=${param.menu}">${vo.prodName}</a></td>
        <td></td>
        <td align="left">${vo.price}</td>
        <td></td>
        <td align="left">${vo.regDate}</td>
         <td></td>
        <td align="left">
        <c:if test = "${not empty param.menu and param.menu eq 'manage' }" >
        <c:choose>
        <c:when test="${vo.proTranCode==null }">
        판매중
        </c:when>
        <c:when test="${vo.proTranCode eq '0' }">
        구매완료
        	<a href="/product/updateTranCodeByProd?prodNo=${vo.prodNo }&menu=${param.menu}">배송하기</a>
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
    </tr>
    <tr>
        <td colspan="11" bgcolor="D6D7D6" height="1"></td>
    </tr>
</c:forEach>
</table>

</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"   style="margin-top:10px;">
   <tr><td colspan="11">
         <input type="hidden" id="currentPage" name="currentPage" value=""/>
            <div style="text-align: center; margin-top: 10px;">
                <%-- 이전 페이지로 이동하는 링크 버튼 --%>
                <a href="javascript:fncGetProductList(<%= resultPage.getBeginUnitPage() - 1 %>)">&lt;&lt; 이전</a>

                <%-- 페이지 번호 표시 부분 --%>
                <% for (int i = resultPage.getBeginUnitPage(); i <= resultPage.getEndUnitPage(); i++) { %>
                    <a href="javascript:fncGetProductList(<%= i %>)"><%= i %></a>
                <% } %>

                <%-- 다음 페이지로 이동하는 링크 버튼 --%>
                <a href="javascript:fncGetProductList(<%= resultPage.getEndUnitPage() + 1 %>)">다음 &gt;&gt;</a>
            </div>
        </td>
   </tr>

</table>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>