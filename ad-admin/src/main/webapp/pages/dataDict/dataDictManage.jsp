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
            <fmt:message key="data.dict"/>
        </li>
        <li class="active">
            <span><fmt:message key="data.dict.manage"/></span>
        </li>
    </ul>
    <!-- /.breadcrumb -->
</div>
<style>
    .modal {
        z-index: 1048;
    }
    .modal-dialog {
        margin: 120px auto;
    }
</style>

<div class="page-content">
    <div class="page-header">
        <form class="form-inline">
            <label class="control-label" for="type"><fmt:message key="data.dict.type"/> </label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="type">

            <label class="control-label" for="typeDesc"><fmt:message key="data.dict.type.desc"/> </label>
            <input type="text" class="form-control input-sm" style="width: 80px;margin-left: 5px;" id="typeDesc">

            <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="search">
                <i class="ace-icon fa fa-search bigger-110"></i><fmt:message key="icon-search"/>
            </button>
            <cas:havePerm url="/json/dataDict_refreshDict.do">
                <button type="button" class="btn btn-info btn-sm" style="margin-left: 20px;" id="refresh">
                    <i class="ace-icon fa fa-refresh bigger-110"></i><fmt:message key="icon-refresh-dict"/>
                </button>
            </cas:havePerm>
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
    <div class="modal-dialog" role="document" style="width: 800px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="gridSystemModalLabel"><fmt:message key="data.dict.item.list" /> </h4>
            </div>
            <div class="modal-body">
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
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

        jQuery(grid_selector).jqGrid({
            datatype: "json",
            mtype: "post",
            url: "<c:url value='/json/dataDict_dictList.do'/>",
            postData: {
                type: $("#type").val(),
                typeDesc: $("#typeDesc").val()
            },
            height: 560,
            colNames:['id',
                '<fmt:message key="data.dict.type"/>',
                '<fmt:message key="data.dict.type.desc"/>',
            ],
            colModel:[
                {key:true, hidden: true},
                {name:'type',index:'type_', align:'center', width:200, sortable: false},
                {name : 'typeDesc', index : 'type_desc', align:'center', width:200, sortable: false}
            ],
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
            caption: '<fmt:message key="data.dict.type.list" />',
            <cas:havePerm url="/dataDict_loadItemPage.do">
                ondblClickRow : function (rowid, iRow, iCol, e) {
                    var type = $(grid_selector).getRowData(rowid).type;
                    var typeDesc = $(grid_selector).getRowData(rowid).typeDesc;
                    showDictItemList(type, typeDesc);
                },
            </cas:havePerm>
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

        function showDictItemList(type, typeDesc) {
            $("#detailModal").modal();
            $.get("<c:url value='/dataDict_loadItemPage.do'/>", {"type": type, "typeDesc": typeDesc}, function (data) {
                $("#detailModal .modal-body").html(data);
            }, "html");
        }

        $("#search").on("click", function () {
            $("#grid-table").jqGrid('setGridParam', {
                url : "<c:url value='/json/dataDict_dictList.do'/>",
                postData : {
                    type: $("#type").val(),
                    typeDesc: $("#typeDesc").val()
                },
                page : 1,
                datatype: "json",
                mtype : "post"
            }).trigger("reloadGrid"); //重新载入
        })

        $("#refresh").on("click", function () {
            $.get('<c:url value="/json/dataDict_refreshDict.do" />', function (data) {
                if (data.result == "success"){
                    bootbox.alert("刷新数据字典缓存成功！");
                }
            })
        })
    });
</script>
