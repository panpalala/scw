package com.atguigu.scw.service.manager;

import java.util.List;

import com.atguigu.scw.bean.TAccountTypeCert;
import com.atguigu.scw.bean.TCert;

/**
 * @author panpala
 * @date 2017年8月6日
 */
public interface CertService {

	List<TCert> listAllCerts();

	List<TAccountTypeCert> listAllTypeCerts();

	void insertAccountTypeCert(TAccountTypeCert accountTypeCert);

	void deletetAccountTypeCert(TAccountTypeCert accountTypeCert);

}
