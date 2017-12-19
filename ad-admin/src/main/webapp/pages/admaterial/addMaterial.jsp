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

        <div id="basicInfo">

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

                    <form class="form-horizontal" role="form" id="adMaterialForm" enctype="multipart/form-data" method="post"  >
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
                                    <option value="201">图片</option>
                                    <option value="202">文字</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group" id="edit_clickHref_">
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
                            <label class="col-sm-2 control-label no-padding-right" for="add_clickHref"> 素材图片及其链接地址 </label>
                               <div class="col-xs-7">
	                               <div style="float:left;margin-top:7px;margin-left: 5%" cellspacing="10px">
	                           	   <span><button type="button" id="addPic" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-plus"></i></button></span> 
	                               <span><button type="button" id="minPic" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-minus"></i></button></span> 
	                               </div>
	                               <div class="col-sm-6" id="morePic" >
	                               </div>
                              </div>
                        </div>
                        <div class="space-4"></div>
                    </form>
                </div><!-- /.col -->
            </div><!-- /.row -->
        </div> <!-- /basicInfo -->
        <div class="row-fluid wizard-actions"  style="margin-right:20%;margin-top: 5%">
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
	        $("#close_addAdMaterial").on("click", function () {
	            $("#main_page > div:last").remove();
	            $("#main_page > div:last").removeClass("main-page-div-display");
	            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
	        });
	        $("#create_materialType").on("change", function () {
	            var val = $("#create_materialType").val();
	            if (val == 201) {
	                $("#save_uploadPic").removeClass("hidden");
	                $("#title_pic").removeClass("hidden");
	                $("#title_hr").removeClass("hidden");   
	                $("#edit_clickHref_").addClass("hidden");
	            } else if (val == "" || val == 202) {
	            	$("#save_uploadPic").addClass("hidden");
	                $("#title_pic").addClass("hidden");
	                $("#title_hr").addClass("hidden");   
	                $("#edit_clickHref_").removeClass("hidden");
	            }
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
	            var formData = new FormData($("#adMaterialForm")[0]);
	            $.ajax({
                    url:"<c:url value='/json/adMaterial_addAdMaterial.do'/>",
                    data:formData,
                    dataType:"json",
                    type:"post",
                    contentType: false,
                    processData: false,
                    cache: false,
                    success:function(data){
                     	 $("#search").click();
                         $("#backBtn").click();
                         bootbox.alert("保存成功 ！");
                    },error:function(){
                         bootbox.alert("保存失败，无法连接服务器！");
                    }
                });
	        })
	        
	        var inputsWrapper  = $("#morePic"); //Input boxes wrapper ID    
	        var addButton      = $("#addPic"); //Add button ID    
	        var minButton      = $("#minPic"); //Add button ID    
	        var FieldCount = 0;   
	        addButton.click(function (){   
               	FieldCount++; 
                inputsWrapper.append('<div id="uploadPic_'+FieldCount+'" " ><div  class="thumbnail search-thumbnail" onclick="addUpload(this);" style="width: 300px;height: 210px;" >'+
                '<img  class="media-object"   data-src="holder.js/300px200?theme=gray" alt="100%x300" style="width: 300px;height: 200px;display: block;" src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNjQwIiBoZWlnaHQ9IjMwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgNjQwIDMwMCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PGRlZnM+PHN0eWxlIHR5cGU9InRleHQvY3NzIj4jaG9sZGVyXzE1ZmEwNWI4MDI4IHRleHQgeyBmaWxsOiNBQUFBQUE7Zm9udC13ZWlnaHQ6Ym9sZDtmb250LWZhbWlseTpBcmlhbCwgSGVsdmV0aWNhLCBPcGVuIFNhbnMsIHNhbnMtc2VyaWYsIG1vbm9zcGFjZTtmb250LXNpemU6MjBwdCB9IDwvc3R5bGU+PC9kZWZzPjxnIGlkPSJob2xkZXJfMTVmYTA1YjgwMjgiPjxyZWN0IHdpZHRoPSI2NDAiIGhlaWdodD0iMzAwIiBmaWxsPSIjRUVFRUVFIj48L3JlY3Q+PGc+PHRleHQgeD0iMjAwIiB5PSIxNTAiPmpwZy9wbmcvanBlZzwvdGV4dD48L2c+PC9nPjwvc3ZnPg==" data-holder-rendered="true">'+
                '<img  class="media-object hidden"   alt="100%x300" style="width: 300px;height: 200px; display: block;" src="" data-holder-rendered="true">'+
                '<input type="file" class="hidden" onchange="prePic(this);" name="imageUpload"  accept="image/jpeg,image/jpg,image/png"/></div><div><textarea style="width:100%;height:80%;"name="imageUploadSrc"></textarea></div></div>'); 
	        });    
	        minButton.on("click",function(){ 
	             $("#uploadPic_"+FieldCount).remove();   
	             FieldCount--; 
	        });  
		});
	    function addUpload(e){
   			$(e).children().get(2).click();
   		}
	    function prePic(pic){
        var reader = new FileReader();
	        var file = pic.files[0];
	        reader.onload = function(e) {
	            var img = $(pic).prev().attr("src",e.target.result);
	        };
	        reader.readAsDataURL(file);
	        $(pic).prev().prev().addClass("hidden");
	        $(pic).prev().removeClass("hidden");     
	    }
</script>
 
