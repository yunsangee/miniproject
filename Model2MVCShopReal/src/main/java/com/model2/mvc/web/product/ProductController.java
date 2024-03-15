package com.model2.mvc.web.product;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;



//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product, Model model ) throws Exception {

		System.out.println("/product/addProduct : POST");
		//Business Logic
		product.setManuDate(product.getManuDate().replace("-",""));
		productService.addProduct(product);
		model.addAttribute("product",product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct(HttpServletResponse response, HttpServletRequest request, @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		
		String history = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals("history")) {
                    history = cookie.getValue();
                    break;
                }
            }
        }
        
        String newProdNo = request.getParameter("prodNo");
        if (newProdNo != null && !newProdNo.isEmpty()) {
            if (history == null) {
                history = ":" + newProdNo;
            } else {
                history += ":" + newProdNo;
            }

            Cookie historyCookie = new Cookie("history", history);
            historyCookie.setPath("/");
            response.addCookie(historyCookie);
        }
            if (request.getParameter("menu").equals("search")) {
                return "forward:/product/readProduct.jsp";
            } else {
                return "forward:/product/getProduct.jsp";
            }
        
	}

	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProductView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateProductView : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}

	@RequestMapping(value = "updateProduct", method=RequestMethod.POST)
	public String updateProduct( HttpServletRequest request, @ModelAttribute("prodNo") Product product , Model model ) throws Exception{

		System.out.println("/product/updateProductView : POST");
		//Business Logic
		productService.updateProduct(product);
		product.setRegDate(Date.valueOf(request.getParameter("regDatee")));
		System.out.println("/Product.do");
		//Business Logic
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}

	@RequestMapping(value = "listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		request.getAttribute("menu");
		System.out.println("/product/listProduct : POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value = "updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@ModelAttribute("Product") Product product,
						@RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateTranCodeByProd : GET");
		//Business Logic
		System.out.println("protranCode test:" + product.getProTranCode());
		purchaseService.updateTranCodeByProd(prodNo);
		
		//Business Logic
		// Model 과 View 연결
			
		return "forward:/product/listProduct";
	}
}