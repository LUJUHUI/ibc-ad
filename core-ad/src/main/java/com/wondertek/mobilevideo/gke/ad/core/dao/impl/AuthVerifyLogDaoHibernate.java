package com.wondertek.mobilevideo.bc.core.dao.impl;

import org.springframework.stereotype.Repository;

import com.wondertek.mobilevideo.bc.core.dao.AuthVerifyLogDao;
import com.wondertek.mobilevideo.bc.core.model.AuthVerifyLog;

/**
 * Created by D11 on 2017/6/7.
 */
@Repository
public class AuthVerifyLogDaoHibernate extends GenericDaoHibernate<AuthVerifyLog,Integer> implements AuthVerifyLogDao{

	public AuthVerifyLogDaoHibernate() {
		super(AuthVerifyLog.class);
	}

}
