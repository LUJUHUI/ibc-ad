package com.wondertek.mobilevideo.gke.ad.core.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "ad_material")
public class AdMaterial implements Serializable {

    public enum AdMaterialStatus {
        /*状态  101:待审核;103:审核失败;104:待使用;105:使用中;106：已删除*/
        STATUS_101(101), STATUS_103(103), STATUS_104(104), STATUS_105(105),  STATUS_106(106);
        private final int status;
        private AdMaterialStatus(int status) {
            this.status = status;
        }

        public int getStatus() {
            return status;
        }
    }
    public enum AdMaterialType{
    	/*201图片，202文字*/
    	TYPE_201(201), TYPE_202(202);
        private final int type;
        private AdMaterialType(int type) {
            this.type = type;
        }
        public int getType() {
            return type;
        }
    }

    private Integer id;  // 素材ID
    private String materialName; //广告素材名
    private Integer type;    //素材类型  1:图片;2:文字
    private String clickHref;  // 链接地址
    private Integer status;  // 状态  101:待审核;103:审核失败;104:待使用;105:使用中;106：已删除
    private Date createTime ;  //创建时间
    private String createPerson;       //创建者ID
    private Date updateTime;   //修改时间
    private String updatePerson;   //修改者ID
    private List<AdMaterialPic> listAdMaterialPic;

    public AdMaterial() {
        super();
    }
    public AdMaterial(int id) {
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_ADMATERIAL_SEQ")
    @SequenceGenerator(name = "AD_ADMATERIAL_SEQ", allocationSize = 1, sequenceName = "AD_ADMATERIAL_SEQ")
    // 素材ID get/set
    @Column(name = "id_")
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    //广告素材名 get/set
    @Column(name = "material_name")
    public String getMaterialName() {
        return materialName;
    }
    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }
    //素材类型  get/set 1:图片;2:文字
    @Column(name = "type_")
    public Integer getType() {
        return type;
    }
    public void setType(Integer type) {
        this.type = type;
    }
    // 链接地址 get/set
    @Column(name = "click_href")
    public String getClickHref() {
        return clickHref;
    }
    public void setClickHref(String clickHref) {
        this.clickHref = clickHref;
    }
    // 状态  get/set 101:待审核;103:审核失败;104:待使用;105:使用中;106：已删除
    @Column(name = "status_")
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

    //创建时间 get/set
    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    //创建者ID get/set
    @Column(name = "create_person")
    public String getCreatePerson() {
        return createPerson;
    }
    public void setCreatePerson(String createPerson) {
        this.createPerson = createPerson;
    }

    //修改时间 get/set
    @Column(name = "update_time")
    public Date getUpdateTime() {
        return updateTime;
    }
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    //修改者ID get/set
    @Column(name = "update_person")
    public String getUpdatePerson() {
        return updatePerson;
    }
    public void setUpdatePerson(String updatePerson) {
        this.updatePerson = updatePerson;
    }
    @Transient
    public List<AdMaterialPic> getListAdMaterialPic() {
		return listAdMaterialPic;
	}
	public void setListAdMaterialPic(List<AdMaterialPic> listAdMaterialPic) {
		this.listAdMaterialPic = listAdMaterialPic;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((clickHref == null) ? 0 : clickHref.hashCode());
		result = prime * result + ((createPerson == null) ? 0 : createPerson.hashCode());
		result = prime * result + ((createTime == null) ? 0 : createTime.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((listAdMaterialPic == null) ? 0 : listAdMaterialPic.hashCode());
		result = prime * result + ((materialName == null) ? 0 : materialName.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		result = prime * result + ((updatePerson == null) ? 0 : updatePerson.hashCode());
		result = prime * result + ((updateTime == null) ? 0 : updateTime.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AdMaterial other = (AdMaterial) obj;
		if (clickHref == null) {
			if (other.clickHref != null)
				return false;
		} else if (!clickHref.equals(other.clickHref))
			return false;
		if (createPerson == null) {
			if (other.createPerson != null)
				return false;
		} else if (!createPerson.equals(other.createPerson))
			return false;
		if (createTime == null) {
			if (other.createTime != null)
				return false;
		} else if (!createTime.equals(other.createTime))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (listAdMaterialPic == null) {
			if (other.listAdMaterialPic != null)
				return false;
		} else if (!listAdMaterialPic.equals(other.listAdMaterialPic))
			return false;
		if (materialName == null) {
			if (other.materialName != null)
				return false;
		} else if (!materialName.equals(other.materialName))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		if (updatePerson == null) {
			if (other.updatePerson != null)
				return false;
		} else if (!updatePerson.equals(other.updatePerson))
			return false;
		if (updateTime == null) {
			if (other.updateTime != null)
				return false;
		} else if (!updateTime.equals(other.updateTime))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AdMaterial [id=" + id + ", materialName=" + materialName + ", type=" + type + ", clickHref=" + clickHref
				+ ", status=" + status + ", createTime=" + createTime + ", createPerson=" + createPerson
				+ ", updateTime=" + updateTime + ", updatePerson=" + updatePerson + ", listAdMaterialPic="
				+ listAdMaterialPic + "]";
	}
	
	
}
