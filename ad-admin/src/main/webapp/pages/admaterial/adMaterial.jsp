<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=utf-8" %>
<%@ include file="/common/taglibs.jsp" %>
<div class="modal fade bs-example-modal-sm" tabindex="-1" id="adMaterialModel" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel">添加素材</h4>
            </div>
            <div class="modal-body">
                <form id="add_material_Form">

                    <div class="form-group">
                        <label for="add_adMaterialName" class="control-label">素材名称:</label>
                        <input type="text" class="form-control" id="add_adMaterialName" name="adMaterial.adMaterialName">
                    </div>

                    <div class="form-group">
                        <label for="add_type" class="control-label">素材类型 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="add_type" name="adMaterial.type">
                            <option value="1">图片</option>
                            <option value="2">文字</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="add_clickHref" class="control-label">链接地址:</label>
                        <input type="text" class="form-control" id="add_clickHref" name="adMaterial.clickHref">
                    </div>

                    <div class="form-group">
                        <label for="add_status" class="control-label">审核状态 :</label>
                        <select class="form-control input-sm" style="margin-left: 5px;" id="add_status" name="adMaterial.status">
                            <option value="101">待审核</option>
                        </select>
                    </div>

                </form>
                <div class="modal-footer">
                    <button type="button" id="close_adad" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" id="save_adad" class="btn btn-primary">保存</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
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
            <fmt:message key="ad.material"/>
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
            <label class="control-label" for="materialName">素材名称</label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="materialName">

            <label class="control-label" for="type">素材类型</label>
            <select class="form-control input-sm" style="margin-left: 5px;" id="type">
                <option value="">全部</option>
                <option value="1">图片</option>
                <option value="2">文字</option>
            </select>

            <label class="control-label" for="status">素材状态</label>
            <select class="form-control input-sm" id="status" style="margin-left: 5px;">
                <option value="">全部</option>
                <option value="101">待审核</option>
                <option value="102">审核成功</option>
                <option value="103">审核失败</option>
                <option value="104">已删除</option>
                <option value="105">已使用</option>
                <c:forEach var="status" items="${pubStatus}">
                    <option value="${status.key}">${status.value}</option>
                </c:forEach>
            </select>

            <label class="control-label" for="createTime">创建时间</label>
            <input class="form-control input-sm" style="width: 200px;" type="text" id="createTime"/>

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
            url: "<c:url value='/json/adMaterial_getAdMaterial.do'/>",
            postData: {
                materialName: $("#materialName").val(),
                type: $("#type").val(),
                status: $("#status").val(),
                beginDate: startDate,
                endDate: endDate
            },
            height: 560,
            colNames:[
                '<fmt:message key="ad.material.id"/>',
                '<fmt:message key="ad.material.materialName"/>',
                '<fmt:message key="ad.material.type"/>',
                '<fmt:message key="ad.material.clickHref"/>',
                '<fmt:message key="ad.material.status"/>',
                '<fmt:message key="ad.material.createTime"/>',
                '<fmt:message key="ad.material.createId"/>',
                '<fmt:message key="ad.material.updateTime"/>',
                '<fmt:message key="ad.material.updateId"/>'
            ],
            colModel:[
                {name:'id',index:'id', width : 80,align:'center', sortable : true},
                {name: 'materialName',index: 'materialName', width : 300, align:'center', sortable : true},
                {name : 'type', index : 'type', width : 270, align:'center', sortable : true},
                {name : 'clickHref', index : 'clickHref', width : 280, align:'center', sortable : true},
                {name : 'status', index : 'status', width : 108, align:'center', sortable : false,formatter:statusFmt},
                {name : 'createTime', index : 'createTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'createId', index : 'createId', width : 100, align:'center', sortable : true},
                {name : 'updateTime', index : 'updateTime', width : 200, align:'center', sortable : true, formatter:"date", formatoptions: {srcformat:'Y-m-d H:i:s',newformat:'Y-m-d H:i:s'}},
                {name : 'updateId', index : 'updateId', width : 100, align:'center', sortable : true},
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
            caption: '<fmt:message key="ad.material" />',
            <cas:havePerm url="/ad.material.do">
            ondblClickRow : function (rowid, iRow, iCol, e) {
                openMainPage('<c:url value="/pages/admaterial/adMaterial.jsp"/>', {"id": rowid}, function () {
                });
            },
            </cas:havePerm>
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
            '<td><button type="button" id="adm_create" class="btn btn-xs btn-success"><i class="ace-icon fa fa-paper-plane-o"></i>创建</button></td>' +
            '<td><button type="button" id="adm_update" class="btn btn-xs btn-success"><i class="ace-icon glyphicon glyphicon-wrench"></i>修改</button></td>' +
            '<td><button type="button" id="adm_delete" class="btn btn-xs btn-danger"><i class="ace-icon  glyphicon glyphicon-remove"></i>删除</button></td>' +
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

        function statusFmt(cellvalue, options, rowObject){
            var result="";
            switch (cellvalue){
                case 101:
                    result='待审核';
                    break;
                case 102:
                    result = '审核通过';
                    break;
                case 103:
                    result = '审核失败';
                    break;
                case 104:
                    result = '已删除';
                    break;
                case 105:
                    result = '已使用';
                    break;
            }
            return result;
        }

        $("#search").on("click", function () {

            if($('#createTime').val() == ""){
                startDate = "";
                endDate = "";
            } else{
                dateRange = $('#createTime').val().replace(/\s/g, "").split("至");
                startDate = dateRange[0];
                endDate = dateRange[1];
            }

            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/adMaterial_getAdMaterial.do'/>",
                postData : {
                    materialName: $("#materialName").val(),
                    type: $("#type").val(),
                    status: $("#status").val(),
                    beginDate: startDate,
                    endDate: endDate
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })
 		
        $("#adm_create").on("click",function () {
            $("#adMaterialModel").modal();
        });

        $("#adm_create").on("click",function () {
            if($("#add_adMaterialName").val() == ""){
                $("#add_adMaterialName").tips({side:2,msg:'此项必填 ',time:3});
                return false;
            }
            if($("#add_type").val() == ""){
                $("#add_type").tips({side:2,msg:'类型不能为空 ',time:3});
                return false;
            }
            $.ajax({
                url:"<c:url value='/json/adMaterial_addAdMaterial.do'/>",
                data:$("#add_material_Form").serialize(),
                type:"post",
                success:function(data){
                    $("#adMaterialModel").modal('hide')
                    $("#search").click();
                    alert("添加成功");
                },error:function(){
                    alert("保存失败，无法连接服务器");
                }
            });

        })
    });
</script>

