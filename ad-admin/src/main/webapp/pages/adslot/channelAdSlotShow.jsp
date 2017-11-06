<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="adSlotModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">添加频道广告位</h4>
            </div>
            <div class="modal-body">
               <form id="ad_SlotForm">
                	 <div class="form-group">
                        <input type="hidden" class="form-control" id="adSlot_id" name="adSlot.id">
                     </div>
                     <div class="form-group">
                      	<label for="adSlot_name" class="control-label">广告位名称:</label>
                        <input type="text" class="form-control" id="adSlot_name" name="adSlot.slotName" >
                     </div>
                     <div class="form-group">
                        <label for="adSlot_navig" class="control-label">导航名称:</label>
                        <select class="form-control"  id="adSlot_navig" name="adSlot.navig">
                            <option value="">请选择</option>
                            <option value="1"  >首页</option>
                            <option value="2"  >直播</option>
                            <option value="3">会员</option>
                        </select>
                    </div>
                    <div class="form-group">
                         <label for="adSlot_channelId" class="control-label">频道ID</label>
                         <select class="form-control"  id="adSlot_channelId" name="adSlot.channelId">
                            <option value="">请选择</option> 
                         </select>
                    </div>
                    <div class="form-group">
                        <label for="adSlot_width" class="control-label">广告位宽度</label>
                        <input type="text" class="form-control" id="adSlot_width" name="adSlot.width">
                    </div>
                    <div class="form-group">
                        <label for="adSlot_height" class="control-label">广告位高度</label>
                        <input type="text" class="form-control" id="adSlot_height" name="adSlot.height">
                    </div>
                    <div class="form-group">
                        <label for="adSlot_remark" class="control-label">备注</label>
                        <textarea   class="form-control" id="adSlot_remark" name="adSlot.remark"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="adSlot_type" class="control-label" hidden="true"></label>
                        <input type="hidden" class="form-control" id="adSlot_type" name="adSlot.type" value="2"  >
                    </div>
                     <div class="form-group">
                        <label for="adSlot_status" class="control-label" hidden="true"></label>
                        <input type="hidden" class="form-control" id="adSlot_status" name="adSlot.status" >
                    </div>
                     <div class="form-group">
                        <label for="adSlot_createTime" class="control-label" hidden="true"></label>
                        <input type="hidden" class="form-control" id="adSlot_createTime" name="adSlot.createTime" >
                    </div>
                     <div class="form-group">
                        <label for="adSlot_createPeople" class="control-label" hidden="true"></label>
                        <input type="hidden" class="form-control" id="adSlot_createPeople" name="adSlot.createPeople">
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" id="close_adad" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" id=save_update_adSlot class="btn btn-primary">保存</button>
                </div>
            </div> 
        </div> 
    </div> 
</div>
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
            <fmt:message key="ad.slot"/>
        </li> 
        <li class="active">
            <span><fmt:message key="channel.slot.content.show"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>

<style type="text/css">
    .ui-jqgrid .ui-jqgrid-bdiv {
        overflow: auto;
    }
    .ui-jqgrid .ui-userdata {
        border-left: 1px solid #D3D3D3;
        border-right: 1px solid #D3D3D3;
        height: 44px;
        overflow: hidden;
    }
    .ui-jqgrid .topnavtable td {
        font-weight: 400;
        vertical-align: middle;
        padding: 0 8px;
    }
</style>

<div class="page-content">
    <div class="page-header">
        <form class="form-inline">
        	<label class="control-label" for="slot_Name">广告位名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="slot_Name">
        
            <label class="control-label" for="attr">导航名称</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="slot_Channel">
                <option value="">全部</option>
                <option value="1">首页</option>
                <option value="2">直播</option>
                <option value="3">会员</option>
            </select>
			
			<label class="control-label" for="attr">状态</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="slot_status">
                <option value="">全部</option>
                <option value="101">待审核</option>
                <option value="102">待使用</option>
                <option value="103">使用中</option>
                <option value="104">审核驳回</option>
                <option value="105">已删除</option>
            </select>
            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>
            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
			<button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="reset">
                <i class="ace-icon fa fa-reply bigger-110"></i><fmt:message key="icon-reset"/>
            </button>
        </form>
    </div>
    <!-- /.page-header -->
    <div class="row">
        <div class="col-xs-12">
            <table id="grid-table"></table>
            <div id="grid-pager"></div>
        </div>
    </div>
    <!-- /.row -->
</div>

<script type="text/javascript">

    jQuery(function($) {
        var grid_selector = "#grid-table";
        var pager_selector = "#grid-pager";

        var parent_column = $(grid_selector).closest('[class*="col-"]');
        //resize to fit page size
        $(window).on('resize.jqGrid', function () {
            $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
        })

        //resize on sidebar collapse/expand
        $(document).on('settings.ace.jqGrid' , function(ev, event_name, collapsed) {
            if( event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed' ) {
                //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                setTimeout(function() {
                    $(grid_selector).jqGrid( 'setGridWidth', parent_column.width() );
                }, 20);
            }
        })

        $('#createTime').daterangepicker({
            "ableToNull": true,
            "showDropdowns":true,
            "showCustomRangeLabel":false,
            "alwaysShowCalendars": true,
            "startDate": moment().subtract('days', 30),
            "endDate": moment().subtract('days', 0),
            "opens": "left",
            "drops": "down"
        }, function(start, end, label) {//时间改变后执行该方法
            //alert(label);
        });

        var dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
        var startDate = dateRange[0];
        var endDate = dateRange[1];

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/adSlot_listAdSlots.do'/>",
            postData: {
            	   slotName: $('#slot_Name').val(),
          	       navig: $('#slot_Channel').val(),
          	       status: $('#slot_status').val(),
            	   type:2,
            	   startDate: startDate + " 00:00:00",
           	       endDate: endDate + " 23:59:59"
            },
            height: 560,
            colNames:[ 
                '<fmt:message key="ad.slot.id"/>',                      
                '<fmt:message key="ad.slot.name"/>',
                '<fmt:message key="ad.slot.navig"/>',
                '<fmt:message key="ad.slot.channel.id"/>',
                '<fmt:message key="ad.slot.width"/>',
                '<fmt:message key="ad.slot.height"/>',
                '<fmt:message key="ad.slot.status"/>',
                '<fmt:message key="ad.slot.createTime"/>',
                '<fmt:message key="ad.slot.creater"/>',
                '<fmt:message key="ad.slot.updateTime"/>',
                '<fmt:message key="ad.slot.updater"/>',
                '<fmt:message key="ad.slot.remark"/>',
            ],
            colModel:[
                {name : 'id', index:'id', width : 100, align:'center',hidden:true},
                {name : 'slotName', index : 'slotName', width : 150, align:'center',sortable : true},
                {name : 'navig', index : 'navig', width : 100, align:'center', sortable : true,formatter:attrNavig},
                {name : 'channelId', index : 'channelId', width : 100, align:'center', sortable : true},
                {name : 'width', index : 'width', width : 100, align:'center', sortable : true},
                {name : 'height', index : 'height', width : 150, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 120, align:'center', sortable : true,formatter:attrStatus,unformat:unAttrStatus},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true,formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createPeople', index : 'createPeople', width : 150, align:'center', sortable : true},
                {name : 'updateTime', index : 'updateTime', width : 200, align:'center', sortable : true,formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updatePeople', index : 'updatePeople', width : 150, align:'center', sortable : true},
                {name : 'remark', index : 'remark', width : 200, align:'center', sortable : true},
            ],
            shrinkToFit : false,
            hidegrid : false,
            viewrecords : true,
            rowNum:20,
            rowList:[10,20,30],
            pager : pager_selector,
            altRows : true,
            multiselect: true,
            multiboxonly: true,
            jsonReader : {
                total : 'pageCount',
                records : 'records',
                root : 'rows',
                repeatitems : true
            },
            caption: '<fmt:message key="channel.slot.content.list" />',
            toolbar: [true,'top'],
            loadComplete : function(data) {
                var table = this;
                setTimeout(function(){
                    styleCheckbox(table);
                    updateActionIcons(table);
                    updatePagerIcons(table);
                    enableTooltips(table);
                }, 0);
            }

        });

        $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
        		 '<td><button type="button" id="addSlot" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-plus"></i>增加</button></td>' +
                 '<td>|</td>' +
                 '<td><button type="button" id="updateSlot" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-edit"></i>修改</button></td>' +
                 '<td>|</td>' +
                 '<td><button type="button" id="deleteSlot" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-remove""></i>删除</button></td>' +
                 '<td>|</td>' +
                 '<td><button type="button" id="useSlot" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-check""></i>启用</button></td>' +
                 '</tr></table>');

        $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size

        //navButtons
        jQuery(grid_selector).jqGrid('navGrid',pager_selector,
            { 	//navbar options
                edit: false,
                editicon : 'ace-icon fa fa-pencil blue',
                add: false,
                addicon : 'ace-icon fa fa-plus-circle purple',
                del: false,
                delicon : 'ace-icon fa fa-trash-o red',
                search: false,
                searchicon : 'ace-icon fa fa-search orange',
                refresh: true,
                refreshicon : 'ace-icon fa fa-refresh green',
                view: false,
                viewicon : 'ace-icon fa fa-search-plus grey',
            }
        )
        function styleCheckbox(table) {
            
        }

        function updateActionIcons(table) {
            
        }
        function updatePagerIcons(table) {
            var replacement =
                {
                    'ui-icon-seek-first' : 'ace-icon fa fa-angle-double-left bigger-140',
                    'ui-icon-seek-prev' : 'ace-icon fa fa-angle-left bigger-140',
                    'ui-icon-seek-next' : 'ace-icon fa fa-angle-right bigger-140',
                    'ui-icon-seek-end' : 'ace-icon fa fa-angle-double-right bigger-140'
                };
            $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function(){
                var icon = $(this);
                var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
            })
        }

        function enableTooltips(table) {
            $('.navtable .ui-pg-button').tooltip({container:'body'});
            $(table).find('.ui-pg-div').tooltip({container:'body'});
        }

        $(document).one('ajaxloadstart.page', function(e) {
            $.jgrid.gridDestroy(grid_selector);
            $('.ui-jqdialog').remove();
        });

        function attrNavig(callValue,options,rowObject){
            var result="";
            switch (callValue){
                case 1:
                    result = '首页';
                    break;
                case 2:
                    result = '直播';
                    break;
                case 3:
                    result = '会员';
            }
            return result;
        }
        
        function attrStatus(callValue) {
            var result="";
	            switch (callValue){
	            case  101:
	                result=  '<span class="green">待审核</span>';
	                break;
	            case  102:
	                result = '<span class="orange">待使用</span>';
	                break;
	            case  103:
	                result = '<span class="green">使用中</span>';
	                break;
	            case  104:
	                result = '<span class="red">审核驳回</span>';
	                break;
	            case  105:
	                result = '<span class="red">已删除</span>';
	                break;
	        }
            return result;
        }
        
        function unAttrStatus(callValue) {
            return callValue;
        }
        
        function tranStatus(callValue) {
            var result="";
            switch (callValue){
	            case  '待审核':
	                result=  101;
	                break;
	            case  '待使用':
	                result = 102;
	                break;
	            case  '使用中':
	                result = 103;
	                break;
	            case  '审核驳回':
	                result = 104;
	                break;
	            case  '已删除':
	                result = 105;
	                break;
            }
            return result;
        }
        
        $("#reset").on("click", function () {
        	$('#slot_Name').val("");
      	    $('#slot_Channel').val("");
      	    $('#slot_status').val("");
            search();
        })
        $("#search").on("click",search);
        function search(){
            if($('#createTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/adSlot_listAdSlots.do'/>",
                postData : {
           		    slotName: $('#slot_Name').val(),
      	       		 navig: $('#slot_Channel').val(),
      	       		 status: $('#slot_status').val(),
         	   		 type:2,
         	   	 	 startDate: startDate + " 00:00:00",
        	         endDate: endDate + " 23:59:59"
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        }
        $("#addSlot").on("click",function () {
       	 $('#adSlot_id').val("");
         $('#adSlot_name').val("");
       	 $('#adSlot_navig').val("");
       	 $('#adSlot_channelId').val("");
       	 $('#adSlot_width').val("");
       	 $('#adSlot_height').val("");
       	 $('#adSlot_remark').val("");
       	 $('#adSlot_status').val("");
       	 $('#adSlot_createTime').val("");
       	 $('#adSlot_createPeople').val("");
       	 $("#adSlotModel").modal();
       });

       $("#save_update_adSlot").on("click",function () {
       	if($("#adSlot_navig").val() == ""){
                 $("#adSlot_navig").tips({side:2,msg:'请选择导航 ',time:3});
                 return false;
           }
       	if($("#adSlot_channelId").val() == ""){
               $("#adSlot_channelId").tips({side:2,msg:'频道ID必填 ',time:3});
               return false;
           }
           if($("#adSlot_width").val() == ""){
               $("#adSlot_width").tips({side:2,msg:'宽度必填 ',time:3});
               return false;
           }
           if($("#adSlot_height").val() == ""){
               $("#adSlot_height").tips({side:2,msg:'高度必填 ',time:3});
               return false;
           }
           var reg = new RegExp("^[0-9]*$");
       	   var widthStart = $("#adSlot_width").val().substring(0,$("#adSlot_width").val().length-2);
           var heightStart = $("#adSlot_height").val().substring(0,$("#adSlot_height").val().length-2);
           if(!reg.test(widthStart)){
               $("#adSlot_width").tips({side:2,msg:'宽度应为数字 ',time:3});
               return false;
           }
           if(!reg.test(heightStart)){
               $("#adSlot_height").tips({side:2,msg:'高度应为数字 ',time:3});
               return false;
           }
           if($("#adSlot_id").val() == ""){
          	   $.ajax({
                     url:"<c:url value='/json/adSlot_addAdSlot.do'/>",
                     data:$("#ad_SlotForm").serialize(),
                     type:"post",
                     success:function(data){
                         $("#adSlotModel").modal('hide');
                         $("#search").click();
                     },error:function(){
                         alert("保存失败");
                     }
                 });
           }else{
          	   $.ajax({
                     url:"<c:url value='/json/adSlot_updateAdSlot.do'/>",
                     data:$("#ad_SlotForm").serialize(),
                     type:"post",
                     success:function(data){
                         $("#adSlotModel").modal('hide');
                         $("#search").click();
                     },error:function(){
                         alert("修改失败");
                     }
                 });
           }
        
       })
        
        $("#updateSlot").on("click",function () {
      	   var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
             if (ids.length == 0){
                 bootbox.alert("请选择要操作的记录！");
                 return;
             }
             if (ids.length > 1){
                 bootbox.alert("只能选择一条记录！");
                 return;
             } 
           for (var index in ids){ 
              var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
              if(rowData.status != "使用中"){
              $("#adSlot_id").val(rowData.id); 
              $("#adSlot_name").val(rowData.slotName);
              $("#adSlot_channelId").val(rowData.channelId);
              $("#adSlot_width").val(rowData.width);
              $("#adSlot_height").val(rowData.height);
              $("#adSlot_remark").val(rowData.remark);
              $("#adSlot_status").val(tranStatus(rowData.status));
              $("#adSlot_createTime").val(rowData.createTime);
              $("#adSlot_createPeople").val(rowData.createPeople);
              switch (rowData.navig){
              case "首页":
           	   $("#adSlot_navig option[value='1']").attr("selected","selected")
                  break;
              case "直播":
           	   $("#adSlot_navig option[value='2']").attr("selected","selected")
                  break;
              case "会员":
           	   $("#adSlot_navig option[value='3']").attr("selected","selected") 
           	   break;
              }
              $("#adSlotModel").modal();
              }else{
              bootbox.alert("该广告位正在使用，不能修改！");  
              }
          }
          
       });

       $("#deleteSlot").on("click",deleteSlot);
       function deleteSlot(){
           var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
           if (ids.length == 0){
               bootbox.alert("请选择要操作的记录！");
               return;
           }
           var codes = [];
           var del = true;
           for (var index in ids){
               var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
               if(rowData.status == "待审核" || rowData.status == "审核驳回"){
               codes.push(rowData.id); 
               }else{
               bootbox.alert("该记录中有，非审核驳回或待审核状态！");
               del = false;
               }
           }
           var codeStr = '';
           for (var index in codes){
               codeStr =codeStr + codes[index] + ',';
           }
           if(codes.length > 0 && del == true){
           bootbox.confirm("确定删除？",function(re){
           if(re) {
           $.ajax({
               url:"<c:url value='/json/adSlot_deleteAdSlot.do'/>",
               data:{"deleteIds": codeStr.substring(0, codeStr.length-1)},
               type:"post",
               success:function(data){
               	bootbox.alert("操作成功！");
                   $("#search").click();
               },error:function(){
                   alert("删除失败");
               }
           });
           }
           })
           }
       }
       //启用广告位
       $("#useSlot").on("click",useSlot);
       function useSlot(){
           var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
           if (ids.length == 0){
               bootbox.alert("请选择要操作的记录！");
               return;
           }
           var codes = [];
           var use = true;
           for (var index in ids){
               var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
               if(rowData.status == "已删除"){
                   codes.push(rowData.id);
               }else{
                   bootbox.alert("记录中有非删除状态，不能启用！");	
                   use = false;
               }
           }
           var codeStr = '';
           for (var index in codes){
               codeStr =codeStr + codes[index] + ',';
           }
           if(codes.length > 0 && use == true){
           bootbox.confirm("确定启用？",function(re){
           if(re) {
           $.ajax({
               url:"<c:url value='/json/adSlot_useAdSlot.do'/>",
               data:{"useIds": codeStr.substring(0, codeStr.length-1)},
               type:"post",
               success:function(data){
               	bootbox.alert("操作成功！");
                   $("#search").click();
               },error:function(){
                   alert("启用失败");
               }
           });
           }
           })
           }
       }
     
       $("#adSlot_navig").on("change",function(){
    	   $("#adSlot_channelId").empty();
    	   if( $("#adSlot_navig").val() == "1"){
    		   $.ajax({
                   url:"<c:url value='/json/adSlot_getHomePageChannelId.do'/>",
                   data:{},
                   type:"post",
                   success:function(data){
                   if(null != data.HomePageChannel && data.HomePageChannel.length>0){
                	   var listData = data.HomePageChannel;
                		 for(var i in listData){
                			 $("#adSlot_channelId").append("<option value='"+listData[i].nodeId+"'>"+listData[i].name+"</option>");
                		 }
                	}
                   },error:function(){
                   }
               });
    	   }else if($("#adSlot_navig").val() == "2"){
    		   $.ajax({
                   url:"<c:url value='/json/adSlot_getLiveChannelId.do'/>",
                   data:{},
                   type:"post",
                   success:function(data){
               	   if(null != data.LiveChannel && data.LiveChannel.length>0){
                   	   var listData = data.LiveChannel;
                   		 for(var i in listData){
                   			 $("#adSlot_channelId").append("<option value='"+listData[i].nodeId+"'>"+listData[i].name+"</option>");
                   		 }
                   	}
                   },error:function(){
                   }
               });
    	   }
       })
    })
</script>
