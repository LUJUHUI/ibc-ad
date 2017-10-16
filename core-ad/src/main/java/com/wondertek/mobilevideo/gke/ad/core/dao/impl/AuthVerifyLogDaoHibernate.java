package com.wondertek.mobilevideo.gke.ad.core.dao.impl;

import com.wondertek.mobilevideo.gke.ad.core.dao.AuthVerifyLogDao;
import com.wondertek.mobilevideo.gke.ad.core.model.AuthVerifyLog;
import org.springframework.stereotype.Repository;

/**
 * Created by D11 on 2017/6/7.
 */
@Repository
public class AuthVerifyLogDaoHibernate extends GenericDaoHibernate<AuthVerifyLog,Integer> implements AuthVerifyLogDao {

	public AuthVerifyLogDaoHibernate() {
		super(AuthVerifyLog.class);
	}

}
