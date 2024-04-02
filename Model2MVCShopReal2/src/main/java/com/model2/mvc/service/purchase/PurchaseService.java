package com.model2.mvc.service.purchase;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;


	public interface PurchaseService {
		
		public void addPurchase(Purchase purchase) throws Exception;
		
		public Purchase getPurchase(int tranNo) throws Exception;
		
		public Map<String, Object> getPurchaseList(Search search) throws Exception;
		
		public void updatePurchase(Purchase purchase) throws Exception;

		public Product getPurchase02(int prodNo) throws Exception;
		
		public void updateTranCodeByProd(int tranCode) throws Exception;
		
		public void updateTranCode(int tranCode) throws Exception;
}
