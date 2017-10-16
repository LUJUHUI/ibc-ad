<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>

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
            <fmt:message key="live.channel.title"/>
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
            <label class="control-label" for="code">code</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="code">

            <label class="control-label" for="searchName">频道名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="name">

            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
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
<div class="modal" aria-labelledby="gridSystemModalLabel" id="detailModal">
    <div class="modal-dialog" role="document" style="width: 1200px;">

    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" aria-labelledby="gridSystemModalLabel" id="scheduleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					导入节目单
				</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<form action="<c:url value='/json/liveChannel_schedule.do'/>" method="post" id="uploadScheduleForm" enctype="multipart/form-data">
						<input type="file" id="schedule" name="schedule" onchange="uploadSchedule(this,'txt')">
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" id="upload" class="btn btn-primary">
					导入
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
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


    var dateRange = "";
    //$('#createTime').val().replace(/\s/g, "").split("至");

    jQuery(grid_selector).jqGrid({
        datatype: "json",
        mtype: "post",
        url: "<c:url value='/json/liveChannel_getChannelByPage.do'/>",
        postData: {
            code: $("#code").val(),
            name: $("#name").val(),
        },
        height: 560,
        colNames:['cId',
            '<fmt:message key="channel.bestvStatus"/>',
            '<fmt:message key="channel.code"/>',
            '<fmt:message key="channel.channelNumber"/>',
            '<fmt:message key="channel.name"/>',
            '<fmt:message key="channel.callSign"/>',
            '<fmt:message key="channel.timeShift"/>',
            '<fmt:message key="channel.description"/>',
            '<fmt:message key="channel.type"/>',
            '<fmt:message key="channel.language"/>',
            '<fmt:message key="channel.status"/>',
            '<fmt:message key="channel.startTime"/>',
            '<fmt:message key="channel.endTime"/>',
            '<fmt:message key="channel.macrovision"/>',
            '<fmt:message key="channel.bilingual"/>',
            '<fmt:message key="channel.createTime"/>',
            '<fmt:message key="channel.updateTime"/>'
        ],
        colModel:[
            {name:'cId',index:'cId', width : 100, hidden:true,key:true},
            {name: 'bestvStatus',index: 'bestvStatus', width : 100, hidden:true},
            {name : 'code', index : 'code', width : 120, align:'center', sortable : false},
            {name : 'channelNumber', index : 'channelNumber', width : 100, align:'center', sortable : false},
            {name : 'name', index : 'name', width : 100, align:'center', sortable : false},
            {name : 'callSign', index : 'callSign', width : 100, align:'center', sortable : false},
            {name : 'timeShift', index : 'timeShift', width : 100, align:'center', sortable : false,formatter:timeShiftFmt},
            {name : 'description', index : 'description', width : 150, align:'center', sortable : false},
            {name : 'type', index : 'type', width : 150, align:'center', sortable : false,formatter:typeFmt},
            {name : 'language', index : 'language', width : 200, align:'center', sortable : false},
            {name : 'status', index : 'status', width : 200, align:'center', sortable : false,formatter:statusFmt},
            {name : 'startTime', index : 'startTime', width : 200, align:'center', sortable : false, formatter:"date", formatoptions: {srcformat:'H:i',newformat:'H:i'}},
            {name : 'endTime', index : 'endTime', width : 200, align:'center', sortable : false, formatter:"date", formatoptions: {srcformat:'H:i',newformat:'H:i'}},
            {name : 'macrovision', index : 'macrovision', width : 200, align:'center', sortable : false,formatter:macrovisionFmt},
            {name : 'bilingual', index : 'bilingual', width : 200, align:'center', sortable : false},
            {name : 'createTime', index : 'create_time', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
            {name : 'updateTime', index : 'update_time', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}}
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
        caption: '<fmt:message key="live.channel.list" />',
       	ondblClickRow : function (rowid, iRow, iCol, e) {
       		showScheduleModal();
 		},
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
        '<td><button type="button" id="addChannel" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-plus"></i>添加频道</button></td>' +
        '<td>|</td>' +
        '<td><button type="button" id="addSchedule" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-plus"></i>导入节目单</button></td>' +
        '<td>|</td>' +
        '<td><button type="button" id="syncSchule" class="btn btn-xs btn-success"><i class="ace-icon fa fa-cloud-upload"></i>同步节目单</button></td>' +
        '<td>|</td>' +
        '<td><button type="button" id="online" class="btn btn-xs btn-success"><i class="ace-icon fa fa-cloud-upload"></i>上线</button></td>' +
        '<td>|</td>' +
        '<td><button type="button" id="offline" class="btn btn-xs btn-danger"><i class="ace-icon fa fa-cloud-download"></i>下线</button></td>' +
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

    //it causes some flicker when reloading or navigating grid
    //it may be possible to have some custom formatter to do this as the grid is being created to prevent this
    //or go back to default browser checkbox styles for the grid
    function styleCheckbox(table) {
        /**
         $(table).find('input:checkbox').addClass('ace')
         .wrap('<label />')
         .after('<span class="lbl align-top" />')


         $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
         .find('input.cbox[type=checkbox]').addClass('ace')
         .wrap('<label />').after('<span class="lbl align-top" />');
         */
    }


    //unlike navButtons icons, action icons in rows seem to be hard-coded
    //you can change them like this in here if you want
    function updateActionIcons(table) {
        /**
         var replacement =
         {
             'ui-ace-icon fa fa-pencil' : 'ace-icon fa fa-pencil blue',
             'ui-ace-icon fa fa-trash-o' : 'ace-icon fa fa-trash-o red',
             'ui-icon-disk' : 'ace-icon fa fa-check green',
             'ui-icon-cancel' : 'ace-icon fa fa-times red'
         };
         $(table).find('.ui-pg-div span.ui-icon').each(function(){
		var icon = $(this);
		var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
		if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
	})
         */
    }

    //replace icons with FontAwesome icons like above
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

    function attrFmt(cellvalue, options, rowObject){
        return cellvalue == '1' ? '单片' : '连续剧';
    }
    
    function timeShiftFmt(callValue,options,rowObject){
    	return callValue == '0' ? '不生效':'生效';
    }
    
    function typeFmt(callValue,options,rowObject){
    	return callValue == '1' ? '直播频道' : 'Web Channel';
    }
    
    function statusFmt(callValue,options,rowObject){
    	return callValue == '0' ? '失效' : '生效';
    }

    function macrovisionFmt(callValue,options,rowObject){
    	return callValue == '0' ? '无拷贝保护' : '有拷贝保护';
    }

    function showAddModal() {
        $.get("<c:url value='/liveChannel_formPage.do'/>", {}, function (data) {
            $("#detailModal .modal-dialog").html(data);
        }, "html");
        $("#detailModal").modal();
    }
    
    function showScheduleModal() {
        $.get("<c:url value='/liveChannel_formPage.do'/>", {}, function (data) {
            $("#detailModal .modal-dialog").html(data);
        }, "html");
        $("#detailModal").modal();
    }

    $("#search").on("click", function () {

        $("#grid-table").jqGrid('setGridParam', {
            url : "<c:url value='/json/liveChannel_getChannelByPage.do'/>",
            postData : {
                code: $("#code").val(),
                name: $("#name").val(),
            },
            page : 1,
            datatype: "json",
            mtype : "post"
        }).trigger("reloadGrid"); //重新载入
    })
    
    
    $("#addChannel").on("click",showAddModal);
    
    $("#addSchedule").on("click",function(){
        $("#scheduleModal").modal();
    });
    
    function onOrOffLine(){
        var actionType = $(this).attr("id") == 'online' ? '1' : '2';//上线为1，下线为2
       
       
        var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
        if (ids.length == 0){
            bootbox.alert("请选择要操作的记录！");
            return;
        }
        var codes = [];
        for (var index in ids){
            var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
            codes.push(rowData.cId);
        }
        if (codes.length < 1){
            bootbox.alert("没有选择有效记录！");
            return;
        }
        var codeStr = '';
        for (var index in codes){
            codeStr =codeStr + codes[index] + ',';
        }
        $.post('<c:url value="/json/liveChannel_bcChannel.do"/>', {"cId": codeStr.substring(0, codeStr.length-1), "actionType": actionType}, function (result) {
            bootbox.alert(result.message);
            $("#search").trigger('click');
        });
    }
    
    $("#upload").on("click",function(){
    	var formData = new FormData($("#uploadScheduleForm")[0]);
    	$.ajax({
			url:"<c:url value='/json/liveChannel_addSchedule.do'/>",
			cache: false,
			data:formData,
			type:"post",
			processData: false,
			contentType: false,
			success:function(data){
				alert(data.message);
			},error:function(){
				alert("保存失败，无法连接服务器");
			}
		});
    });
    
    $("#syncSchule").on("click",function(){
    	var ids = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
        if (ids.length == 0){
            bootbox.alert("请选择要操作的记录！");
            return;
        }
        var codes = [];
        for (var index in ids){
            var rowData = $("#grid-table").jqGrid('getRowData', ids[index]);
            codes.push(rowData.cId);
        }
        var codeStr = '';
        for (var index in codes){
            codeStr =codeStr + codes[index] + ',';
        }
        $.ajax({
			url:"<c:url value='/json/liveChannel_syncSchedule.do'/>",
			data:{"cId":codeStr},
			type:"post",
			success:function(data){
				alert(data.message);
			},error:function(){
				alert("保存失败，无法连接服务器");
			}
		});
    })
});
function uploadSchedule(obj,filter){
	var file = obj.value.match(/[^\/\\]+$/gi)[0];
    var rx = new RegExp('\\.(' + (filter?filter:'') + ')$','gi');
    if(filter&&file&&!file.match(rx)){
      alert("只能选择txt");
      $("#uploadScheduleForm")[0].reset();
    } 
}
</script>
