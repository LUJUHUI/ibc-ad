package com.wondertek.mobilevideo.bc.core.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wondertek.mobilevideo.bc.core.dao.AuthVerifyLogDao;
import com.wondertek.mobilevideo.bc.core.model.AuthVerifyLog;
import com.wondertek.mobilevideo.bc.core.service.AuthVerifyLogManager;

/**
 * Created by D11 on 2017/6/7.
 */
@Service
public class AuthVerifyLogManagerImpl extends GenericManagerImpl<AuthVerifyLog,Integer> implements AuthVerifyLogManager{
    
	private AuthVerifyLogDao authVerifyLogDao;
	
	@Autowired
	public AuthVerifyLogManagerImpl(AuthVerifyLogDao authVerifyLogDao) {
		super(authVerifyLogDao);
		this.authVerifyLogDao = authVerifyLogDao;
	}

}
