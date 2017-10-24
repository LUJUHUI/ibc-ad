package com.wondertek.mobilevideo.gke.ad.core.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ad_material")
public class AdMaterial implements Serializable {
    public enum AdMaterialStatus {
        STATUS_101(101), STATUS_102(102),STATUS_103(103), STATUS_104(104), STATUS_105(105),STATUS_106(106);

        private final int _status;

        private AdMaterialStatus(int _status) {
            this._status = _status;
        }

        public int get_status() {
            return _status;
        }
    }

    private int id;  // 素材ID
    private String materialName; //广告素材名
    private int type;    //素材类型  1:图片;2:文字
    private String clickHref;  // 链接地址
    private int status;  // 审核状态  101:待审核;102:审核通过;103:审核失败;104:已删除;105:已使用
    private Date createTime = new Date();  //创建时间
    private String createPerson;       //创建者ID
    private Date updateTime = new Date();   //修改时间
    private String updatePerson;   //修改者ID
    public AdMaterial() {
        super();
    }
    
    public AdMaterial(int id) {
        this.id = id;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "AD_ADMATERIAL_SEQ")
    @SequenceGenerator(name = "AD_ADMATERIAL_SEQ", allocationSize = 1, sequenceName = "AD_ADMATERIAL_SEQ")
    @Column(name = "id_")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    @Column(name = "material_name")
    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }
    @Column(name = "type_")
    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
    @Column(name = "click_href")
    public String getClickHref() {
        return clickHref;
    }

    public void setClickHref(String clickHref) {
        this.clickHref = clickHref;
    }
    @Column(name = "status_")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    @Column(name = "create_person")
    public String getCreatePerson() {
        return createPerson;
    }
    @Column(name = "update_person")
    public void setCreatePerson(String createPerson) {
        this.createPerson = createPerson;
    }

    public String getUpdatePerson() {
        return updatePerson;
    }

    public void setUpdatePerson(String updatePerson) {
        this.updatePerson = updatePerson;
    }
    @Column(name = "update_time")
    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    @Override
    public String toString() {
        return "AdMaterial{" +
                "id=" + id +
                ", materialName='" + materialName + '\'' +
                ", type=" + type +
                ", clickHref='" + clickHref + '\'' +
                ", status=" + status +
                ", createTime=" + createTime +
                ", createPerson='" + createPerson + '\'' +
                ", updateTime=" + updateTime +
                ", updatePerson='" + updatePerson + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AdMaterial that = (AdMaterial) o;

        if (id != that.id) return false;
        if (type != that.type) return false;
        if (status != that.status) return false;
        if (materialName != null ? !materialName.equals(that.materialName) : that.materialName != null) return false;
        if (clickHref != null ? !clickHref.equals(that.clickHref) : that.clickHref != null) return false;
        if (createTime != null ? !createTime.equals(that.createTime) : that.createTime != null) return false;
        if (createPerson != null ? !createPerson.equals(that.createPerson) : that.createPerson != null) return false;
        if (updateTime != null ? !updateTime.equals(that.updateTime) : that.updateTime != null) return false;
        return updatePerson != null ? updatePerson.equals(that.updatePerson) : that.updatePerson == null;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (materialName != null ? materialName.hashCode() : 0);
        result = 31 * result + type;
        result = 31 * result + (clickHref != null ? clickHref.hashCode() : 0);
        result = 31 * result + status;
        result = 31 * result + (createTime != null ? createTime.hashCode() : 0);
        result = 31 * result + (createPerson != null ? createPerson.hashCode() : 0);
        result = 31 * result + (updateTime != null ? updateTime.hashCode() : 0);
        result = 31 * result + (updatePerson != null ? updatePerson.hashCode() : 0);
        return result;
    }
}
