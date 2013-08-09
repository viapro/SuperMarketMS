package com.viapro.sm.service.impl;

import java.io.Serializable;
import java.util.List;

import com.viapro.sm.bean.Provider;
import com.viapro.sm.dao.impl.ProviderDaoImpl;
import com.viapro.sm.service.ProviderService;
import com.viapro.sm.util.Page;

public class ProviderServiceImpl implements ProviderService{
	
	private ProviderDaoImpl pdi = null;
	
	public ProviderServiceImpl(){
		pdi = new ProviderDaoImpl();
	}
	
	@Override
	public Page<Provider> getProviderPage(String proName, String proDesc, String currentPage){
		return pdi.getPage(proName, proDesc, currentPage);
	}
	
	@Override
	public List<Provider> getAllProviderList(){
		return pdi.getPageList(null, null, null, null);
	}

	@Override
	public boolean addProvider(Provider provider) {
		return pdi.add(provider);
	}

	@Override
	public boolean deleteProviderById(Serializable id) {
		return pdi.deleteById(id);
	}

	@Override
	public boolean updateProvider(Provider provider) {
		return pdi.update(provider);
	}

	@Override
	public Provider getProviderById(Serializable id) {
		return pdi.getById(id);
	}
}
