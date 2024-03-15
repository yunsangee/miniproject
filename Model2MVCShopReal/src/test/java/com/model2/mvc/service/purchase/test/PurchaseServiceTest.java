package com.model2.mvc.service.purchase.test;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

//	@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
		user.setUserId("user19");
		purchase.setBuyer(user);
		product.setProdNo(10001);
		purchase.setPurchaseProd(product);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("신윤상");
		purchase.setReceiverPhone("010-3422-4660");
		purchase.setDivyAddr("서울 은평구");
		purchase.setDivyRequest("빨리좀");
		purchase.setDivyDate("2024-03-24");		
		purchase.setTranCode("1");
		
		purchaseService.addPurchase(purchase);
		
		//==> console 확인
		System.out.println(purchase);
		
		//==> API 확인
	
		Assert.assertEquals("1", purchase.getPaymentOption());
		Assert.assertEquals("신윤상", purchase.getReceiverName());
		Assert.assertEquals("010-3422-4660", purchase.getReceiverPhone());
		Assert.assertEquals("서울 은평구", purchase.getDivyAddr());
		Assert.assertEquals("빨리좀", purchase.getDivyRequest());
		Assert.assertEquals("2024-03-24", purchase.getDivyDate());
	
	}

	//@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = purchaseService.getPurchase(10007);
		
		//==> console 확인
		System.out.println(purchase);
		
		//==> API 확인
		
		Assert.assertEquals("1", purchase.getPaymentOption().trim());
		Assert.assertEquals("신윤상", purchase.getReceiverName());
		Assert.assertEquals("010-3422-4660", purchase.getReceiverPhone());
		Assert.assertEquals("서울 은평구", purchase.getDivyAddr());
		Assert.assertEquals("빨리좀", purchase.getDivyRequest());
		Assert.assertEquals("2024-03-24", purchase.getDivyDate());
	}

	//@Test
	 public void testUpdatePurchase() throws Exception{
		
		System.out.println("start");
		Purchase purchase = purchaseService.getPurchase(10007);
		System.out.println(purchase);
		User user = new User();
				
		
		Assert.assertEquals("user19", purchase.getBuyer().getUserId());
		Assert.assertEquals("신윤상", purchase.getReceiverName());
		Assert.assertEquals("010-3422-4660", purchase.getReceiverPhone());
		Assert.assertEquals("서울 은평구", purchase.getDivyAddr());
		Assert.assertEquals("빨리좀", purchase.getDivyRequest());
		Assert.assertEquals("2024-03-24", purchase.getDivyDate());

		user.setUserId("user19");
		purchase.setBuyer(user);
		purchase.setReceiverName("change");
		purchase.setReceiverPhone("010-7191-1225");
		purchase.setDivyAddr("인천 광역시");
		purchase.setDivyRequest("change");
		purchase.setDivyDate("2024-03-04");
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(Integer.parseInt("10001"));
		Assert.assertNotNull(purchase);
		
		//==> console 확인
		System.out.println(purchase);
			
		//==> API 확인
		Assert.assertEquals("change", purchase.getReceiverName());
		Assert.assertEquals("010-7191-1225",purchase.getReceiverPhone());
		Assert.assertEquals("인천 광역시", purchase.getDivyAddr());
		Assert.assertEquals("change", purchase.getDivyRequest());
		Assert.assertEquals("2024-03-04", purchase.getDivyDate());
	 
	}
	
	 //==>  주석을 풀고 실행하면....
	 @Test
	 public void testGetPurchaseListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = purchaseService.getPurchaseList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = purchaseService.getPurchaseList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	//System.out.println(list);
	 	System.out.println(list);
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 /*
	 //@Test
	 public void testGetUserListByUserId() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("admin");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 @Test
	 public void testGetUserListByUserName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("SCOTT");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 */
}