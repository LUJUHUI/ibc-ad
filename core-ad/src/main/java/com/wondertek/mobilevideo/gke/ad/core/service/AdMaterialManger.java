package com.wondertek.mobilevideo.gke.ad.core.service;

import java.io.File;
import java.util.List;

import com.wondertek.mobilevideo.gke.ad.core.model.AdMaterial;

public interface AdMaterialManger extends GenericManager<AdMaterial,Integer> {

    public void verify(String ids, int type,String userName)throws RuntimeException;

	public void saveAdMaterial(AdMaterial adMaterial, List<File> uploadPic, List<String> uploadPicFileName,String username);

	public void updateAdMaterial(AdMaterial adMaterial,String username);
}
