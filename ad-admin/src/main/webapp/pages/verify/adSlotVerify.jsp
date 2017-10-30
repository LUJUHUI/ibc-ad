<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%
    String status = request.getParameter("status");
    request.setAttribute("status",status);
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
            <label class="control-label" for="slot_type">广告类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="slot_type">
                <option value="">全部</option>
                <option value="1">开机广告位</option>
                <option value="2">导航广告位</option>
                <option value="3">频道广告位</option>
            </select>
            <label class="control-label" for="slot_Channel">导航名称</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="slot_Channel">
                <option value="">全部</option>
                <option value="1">首页</option>
                <option value="2">直播</option>
                <option value="3">会员</option>
            </select>
			<span id="slot_status">
                <label class="control-label" for="status">状态</label>
                <select class="form-control input-sm" style="margin-left: 5px;" id="status">
                    <option value="">全部</option>
                    <option value="102">待使用</option>
                    <option value="103">使用中</option>
                    <option value="104">审核驳回</option>
                    <option value="105">删除</option>
                </select>
            </span>
            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>
			<button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="reset">
                <i class="ace-icon fa fa-reply bigger-110"></i><fmt:message key="icon-reset"/>
            </button>
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

<script type="text/javascript">

    jQuery(function($) {
        var status = "${status}";
        if(status == 101){
            $("#slot_status").addClass("hidden");
        }
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
            "startDate": moment().subtract('days', 29),
            "endDate": moment().subtract('days', -1),
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
                type:$("#slot_type").val(),
                status: status == 0 ? $("#status").val():status,
                status_not:status == 0 ? 101:'',
                beginDate: startDate +" 00:00:00",
                endDate: endDate+ " 23:59:59"
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
                {name : 'slotName', index : 'slot_name', width : 100, align:'center',hidden:true },
                {name : 'navig', index : 'navig', width : 100, align:'center', sortable : false,formatter:attrNavig},
                {name : 'channelId', index : 'channel_id', width : 100, align:'center', sortable : false},
                {name : 'width', index : 'width_', width : 100, align:'center', sortable : false},
                {name : 'height', index : 'height_', width : 150, align:'center', sortable : false},
                {name : 'status', index : 'status_', width : 150, align:'center', sortable : false,formatter:attrStatus},
                {name : 'createTime', index : 'create_time', width : 220, align:'center', sortable : false,formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createPeople', index : 'create_people', width : 150, align:'center', sortable : false},
                {name : 'updateTime', index : 'update_time', width : 220, align:'center', sortable : false,formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updatePeople', index : 'update_people', width : 150, align:'center', sortable : false},
                {name : 'remark', index : 'remark_', width : 270, align:'center', sortable : false},
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
        if(status == 101){
            $("#t_grid-table").append('<table cellspacing="0" cellpadding="0" border="0" style="float:left;table-layout:auto;margin-top:7px" class="topnavtable"><tr>' +
                '<td><button type="button" id="verify_via" class="btn btn-xs btn-success"><i class="ace-icon fa fa-paper-plane-o"></i>审核通过</button></td>' +
                '<td>|</td>' +
                '<td><button type="button" id="verify_refuse" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-wrench"></i>审核驳回</button></td>' +
                '<td></td>' +
                '</table>');
        }else{
            $("#t_grid-table").addClass("hidden");
        }

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

        function attrStatus(callValue, options, rowObject) {
            var result="";
            switch (callValue){
                case 101:
                    result='<span class="green">待审核</span>';
                    break;
                case 102:
                    result = '<span class="orange">待使用</span>';
                    break;
                case 103:
                    result = '<span class="green">使用中</span>';
                    break;
                case 104:
                    result = '<span class="red">审核驳回</span>';
                    break;
                case 105:
                    result = '<span class="red">删除</span>';
                    break;
            }
            return result;
        }
        
        function tranStatus(callValue) {
            var result="";
            switch (callValue){
                case '待审核':
                    result='101';
                    break;
                case '待使用':
                    result = '102';
                    break;
                case '使用中':
                    result = '103';
                    break;
                case '审核失败':
                    result = '104';
                    break;
                case '删除':
                    result = '105';
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
                    type:$("#slot_type").val(),
                    status: status == 0 ? $("#status").val():status,
                    status_not:status == 0 ? 101:'',
                    beginDate: startDate +" 00:00:00",
                    endDate: endDate+ " 23:59:59"
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        }
        function verify(ids,type) {
            $.ajax({
                url: "<c:url value='/json/adSlot_verify.do'/>",
                data:{ids:ids.join(","),type:type},
                type:"post",
                success:function (resp) {
                    if(resp.success == true) {
                        if(resp.code == 101){
                            bootbox.alert("操作成功！");
                            $("#search").click();
                        }else if (resp.code = 102){
                            bootbox.alert("操作失败，节目中有未处于”待审核“状态节目！");
                        }
                    }else{
                        bootbox.alert("系统发生异常，操作失败！");
                    }

                },error:function () {

                }
            });
        }
        //审核通过
        $("#verify_via").on("click",function () {
            var rows = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (rows.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var ids = [];
            $.each(rows,function (index, items) {
                var rowdDta = $("#grid-table").jqGrid('getRowData', rows[index])
                ids.push(rowdDta.id);
            })
            verify(ids,0);
        })
        //审核驳回
        $("#verify_refuse").on("click",function () {
            var rows = $("#grid-table").jqGrid('getGridParam', 'selarrrow');
            if (rows.length == 0){
                bootbox.alert("请选择要操作的记录！");
                return;
            }
            var ids = [];
            $.each(rows,function (index, items) {
                var rowdDta = $("#grid-table").jqGrid('getRowData', rows[index])
                ids.push(rowdDta.id);
            })
            verify(ids,1);
        })
    });
</script>
