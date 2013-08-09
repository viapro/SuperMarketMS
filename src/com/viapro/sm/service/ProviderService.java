package com.viapro.sm.service;

import java.io.Serializable;
import java.util.List;

import com.viapro.sm.bean.Provider;
import com.viapro.sm.util.Page;

public interface ProviderService {
	boolean addProvider(Provider provider);
	boolean deleteProviderById(Serializable id);
	boolean updateProvider(Provider provider);
	Provider getProviderById(Serializable id);
	Page<Provider> getProviderPage(String proName, String proDesc, String currentPage);
	List<Provider> getAllProviderList();
}
