package com.viapro.sm.service;

import java.io.Serializable;
import java.util.List;

import com.viapro.sm.bean.Bill;
import com.viapro.sm.util.Page;

public interface BillService {
	boolean addBill(Bill bill);
	boolean deleteBillById(Serializable id);
	boolean updateBill(Bill bill);
	Bill getBillById(Serializable id);
	Page<Bill> getBillPage(String productName, String paystate,	String currentPage);
	List<Bill> getAllBillList();
}
