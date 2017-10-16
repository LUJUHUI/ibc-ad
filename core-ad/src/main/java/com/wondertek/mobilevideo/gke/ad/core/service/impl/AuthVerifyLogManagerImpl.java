package com.wondertek.mobilevideo.gke.ad.core.service.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AuthVerifyLogDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AuthVerifyLog;
import com.wondertek.mobilevideo.gke.ad.core.service.AuthVerifyLogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



/**
 * Created by D11 on 2017/6/7.
 */
@Service
public class AuthVerifyLogManagerImpl extends GenericManagerImpl<AuthVerifyLog,Integer> implements AuthVerifyLogManager {
    
	private AuthVerifyLogDao authVerifyLogDao;
	
	@Autowired
	public AuthVerifyLogManagerImpl(AuthVerifyLogDao authVerifyLogDao) {
		super(authVerifyLogDao);
		this.authVerifyLogDao = authVerifyLogDao;
	}

}
