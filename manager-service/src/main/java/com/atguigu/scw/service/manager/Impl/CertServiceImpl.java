package com.atguigu.scw.service.manager.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.bean.TAccountTypeCert;
import com.atguigu.scw.bean.TAccountTypeCertExample;
import com.atguigu.scw.bean.TAccountTypeCertExample.Criteria;
import com.atguigu.scw.bean.TCert;
import com.atguigu.scw.dao.TAccountTypeCertMapper;
import com.atguigu.scw.dao.TCertMapper;
import com.atguigu.scw.service.manager.CertService;

/**
 * @author panpala
 * @date 2017年8月6日
 */
@Service
public class CertServiceImpl implements CertService {
	
	@Autowired
	TCertMapper certMapper;
	
	@Autowired
	TAccountTypeCertMapper accountTypeCertMapper;
	
	@Override
	public List<TCert> listAllCerts() {
		return certMapper.selectByExample(null);
	}

	@Override
	public List<TAccountTypeCert> listAllTypeCerts() {
		return accountTypeCertMapper.selectByExample(null);
	}

	@Override
	public void insertAccountTypeCert(TAccountTypeCert accountTypeCert) {
		accountTypeCertMapper.insertSelective(accountTypeCert);
	}

	@Override
	public void deletetAccountTypeCert(TAccountTypeCert accountTypeCert) {
		TAccountTypeCertExample example = new TAccountTypeCertExample();
		Criteria criteria = example.createCriteria();
		criteria.andAccttypeEqualTo(accountTypeCert.getAccttype());
		criteria.andCertidEqualTo(accountTypeCert.getCertid());
		accountTypeCertMapper.deleteByExample(example);
	}

}
