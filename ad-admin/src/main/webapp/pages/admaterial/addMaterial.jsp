<%@ page import="javax.persistence.Id" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%

    String orderId = request.getParameter("id");
    request.setAttribute("id", orderId);
%>
<div class="breadcrumbs" id="breadcrumbs">
    <script type="text/javascript">
        try {
            ace.settings.check('breadcrumbs', 'fixed')
        } catch (e) {
        }
    </script>
    <ul class="breadcrumb">
        <li><i class="ace-icon fa fa-home home-icon"></i>
            <a href=""><fmt:message key="webapp.home"/></a>
        </li>
        <li>
            <fmt:message key="ad.material"/>
        </li>
        <li>
            <fmt:message key="ad.ad.createMaterial"/>
        </li>
    </ul>
    <!-- /.breadcrumb -->
    <div class="nav-search">
        <button type="button" class="btn btn-danger btn-sm" id="backBtn">
            <i class="ace-icon fa fa-reply"></i><fmt:message key="button.back"/>
        </button>
    </div>
</div>

<div class="page-content">

    <div class="page-content">

        <div id="basicInfo" class="">

            <div class="page-header">
                <h1>
                    新建素材
                    <small>
                        <i class="icon-double-angle-right"></i>
                        基本信息
                    </small>
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-xs-12">

                    <form class="form-horizontal" role="form" id="adform">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="add_adMaterialName"> 素材名称 </label>
                            <div class="col-sm-9">
                                <input type="text" id="add_adMaterialName" placeholder="素材名称" class="col-xs-10 col-sm-5"
                                       name="adMaterial.materialName">
                            </div>
                        </div>
                        <div class="space-4"></div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right"
                                   for="create_materialType"> 素材类型 </label>
                            <div class="col-sm-9">
                                <select class="col-xs-10 col-sm-5 chosen-select" id="create_materialType"
                                        data-placeholder="Choose a Country..." name="adMaterial.type" ;>
                                    <option value="">--请选择--</option>
                                    <option value="1">图片</option>
                                    <option value="2">文字</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right" for="add_clickHref"> 链接地址 </label>
                            <div class="col-sm-9">
                                <input type="text" id="add_clickHref" class="col-xs-10 col-sm-5"
                                       name="adMaterial.clickHref">
                            </div>
                        </div>

                        <div class="page-header hidden" id="title_pic">
                            <h1>
                                <small>
                                    <i class="icon-double-angle-right"></i>
                                    素材图片信息
                                </small>
                            </h1>
                        </div>
                       <hr  class="hidden" id="title_hr">
                        <div class="form-group hidden" id="save_uploadPic">
                            <label class="col-sm-3 control-label no-padding-right" for="type"></label>
                            <div class="col-sm-9" >
                                
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="col-sm-9" style="border: 1px solid red;height: 200px;">
                                            <div class="thumbnail search-thumbnail" style=" width: 300px;height: 200px;" >
                                                <img id="temp" class="media-object" data-src="holder.js/300px200?theme=gray" alt="100%x300" style="height: 190px; width: 100%; display: block;"
                                                     src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMjAwIDEwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj4jaG9sZGVyXzE1ZmEwNWI4MDI4IHRleHQgeyBmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MTRwdCB9IDwvc3R5bGU+PC9kZWZzPjxnIGlkPSJob2xkZXJfMTVmYTA1YjgwMjgiPjxyZWN0IHdpZHRoPSIyMDAiIGhlaWdodD0iMTAwIiBmaWxsPSIjRUVFRUVFIj48L3JlY3Q+PGc+PHRleHQgeD0iMjM1LjY3OTY4NzUiIHk9IjE1Ni4zIj4yMDB4MTAwIGpwZy9wbmcvanBlZzwvdGV4dD48L2c+PC9nPjwvc3ZnPg==" data-holder-rendered="true">
                                                <img id="preview" class="media-object hidden" alt="100%x300" style="height: 190px; width: 100%; display: block;" src="" data-holder-rendered="true">
                                                <input type="file" class="hidden" id="tu" accept="image/jpeg,image/jpg,image/png">
                                            </div>
                                        </div>
                                        <div class="col-sm-3"style="border: 1px solid red;height: 200px;">
                                            <textarea id="add_upload" style="width: 300px;height: 100px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="space-4"></div>
                    </form>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div> <!-- /basicInfo -->
        <div class="row-fluid wizard-actions">
            <button type="button" id="save_addAdMaterial" class="btn btn-primary">保存</button>
            <button type="button" id="close_addAdMaterial" class="btn btn-default" data-dismiss="modal">取消</button>
        </div>
    </div>
</div>
<script type="text/javascript">

    jQuery(function ($) {

        $("#backBtn").on("click", function () {
            $("#main_page > div:last").remove();
            $("#main_page > div:last").removeClass("main-page-div-display");
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
        });
        //var id = "${id}";

        $("#create_materialType").on("change", function () {
            var val = $("#create_materialType").val();
            if (val == 1) {
                $("#save_uploadPic").removeClass("hidden");
                $("#title_pic").removeClass("hidden");
                $("#title_hr").addClass("hidden");

            } else if (val == "" || val == 2) {
                $("#save_uploadPic").addClass("hidden");
                $("#title_pic").addClass("hidden");
                $("#title_hr").removeClass("hidden");
            }
        })

        $(".media-object").on("click",function () {
            $("#tu").click();
        });
        $("#tu").on("change",function () {
            var reader = new FileReader();
            var file = this.files[0];
            reader.onload = function(e) {
                var img = $("#preview").attr("src",e.target.result);
            };
            reader.readAsDataURL(file);
            $("#temp").addClass("hidden");
            $("#preview").removeClass("hidden");
        })

        $("#save_addAdMaterial").on("click", function () {
            if ($("#add_adMaterialName").val() == "") {
                $("#add_adMaterialName").tips({side: 2, msg: '此项必填', time: 3});
                return false;
            }
            if ($("#create_materialType").val() == "") {
                $("#create_materialType").tips({side: 2, msg: '此项必填', time: 3});
                return false;
            }
            if ($("#add_clickHref").val() == "") {
                $("#add_clickHref").tips({side: 2, msg: '此项必填', time: 3});
                return false;
            }
        })

    });
</script>
