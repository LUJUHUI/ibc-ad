package com.wondertek.mobilevideo.gke.ad.core.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "ad_material")
public class AdMaterial implements Serializable {

    @Id
    @Column(name = "id_")
    private int id;  // 素材ID
    @Column(name = "material_name")
    private String materialName; //广告素材名
    @Column(name = "type_")
    private int type;    //素材类型  1:图片;2:文字
    @Column(name = "click_href")
    private String clickHref;  // 链接地址
    @Column(name = "status_")
    private int status;  // 审核状态  101:待审核;102:审核通过;103:审核失败;104:已删除;105:已使用
    @Column(name = "create_time")
    private Date createTime = new Date();  //创建时间
    @Column(name = "create_person")
    private String createPerson;       //创建者ID
    @Column(name = "update_time")
    private Date updateTime = new Date();   //修改时间
    @Column(name = "update_person")
    private String updatePerson;   //修改者ID

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getMaterialName() {
        return materialName;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getClickHref() {
        return clickHref;
    }

    public void setClickHref(String clickHref) {
        this.clickHref = clickHref;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreatePerson() {
        return createPerson;
    }

    public void setCreatePerson(String createPerson) {
        this.createPerson = createPerson;
    }

    public String getUpdatePerson() {
        return updatePerson;
    }

    public void setUpdatePerson(String updatePerson) {
        this.updatePerson = updatePerson;
    }

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
