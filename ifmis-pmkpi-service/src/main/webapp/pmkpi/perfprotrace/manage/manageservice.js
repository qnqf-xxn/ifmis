if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprotrace){
	Ext.lt.pmkpi.perfprotrace = {};
}
if(!Ext.lt.pmkpi.perfprotrace.manageservice){
	Ext.lt.pmkpi.perfprotrace.manageservice = {};
}

Ext.lt.pmkpi.perfprotrace.manageservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
     var cmp = {};
     var _menuid = config.menuid,//菜单id
         _pagetype = config.pagetype,//菜单类型，部门、财政
         _tablecode = config.tablecode,
         _prolev = config.prolev,
         _defquery,
         _orderby,
         _treeid,
         _isleaf,
         scrWidth =document.body.clientWidth,
         scrHeight =document.body.clientHeight;

     var serviceid = service;

     $(function (){
         //组件配置，service不放到第一位时，组件初始化消息不走问题
         common.initDatatable();
         Ext.lt.pmkpi.query();
     })

     //查询
     cmp.query = function (obj){
         Ext.lt.pmkpi.query();
     }

     Ext.lt.pmkpi.query = function(){
         if(!_treeid){
             _treeid = "treeroot";
             _isleaf = 0;
         }
         Ext.lt.ui.loadingShow();
         var params = {};
         params.treeid = _treeid;
         params.isleaf = _isleaf + "";
         params.queryConfig = queryform.getQueryParam();
         params.querySql = queryform.getQuerySQL();
         params.tablecode = _tablecode;
         params.tablesql = _defquery;
         params.orderby = _orderby;
         params.menuid = _menuid;
         Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
             datatable.setDatas(rs.data);
             Ext.lt.ui.loadingClose();
         },function(){
             Ext.lt.ui.loadingClose();
             Ext.lt.ui.alert('查询失败！',function(){
             });
         });
     }

     Ext.lt.message.hook("left", "click",function(obj){
         var treeNode = obj.node.data;
         if(treeNode){
             _treeid = treeNode.guid;
             _isleaf = treeNode.isleaf;
         } else {
             _treeid = "treeroot";
             _isleaf = 0;
         }
         cmp.query();
     });

     Ext.lt.message.hook("perfcommon", "tablequery",function(){
         Ext.lt.pmkpi.query();
     });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

     Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
         var uiconfig = obj.table.uiconfig;
         _defquery = uiconfig.defquery;
         _orderby = uiconfig.orderby;
     });

     /**
      * 监控任务
      */
     cmp.tasktrace = function (obj){
         var data = datatable.getSelected();
         if(data.length != 1 ){
             Ext.lt.ui.alert("请选中一条数据！",function(){});
             return;
         }
         var url = "";
         var tasktype = data[0].tasktype;
         var params = {};
         params.pagetype = _pagetype;
         params.taskguid = data[0].guid;
         params.taskstage = data[0].taskstage;
         params.tasksname = data[0].name;
         params.tasksenddate = data[0].enddate;
         params.tasktype = tasktype;
         params.prolev = _prolev;
         params.taskstage = data[0].taskstage;
         if ("protrace" == tasktype && "dept"== _pagetype) {//项目支出-一般监控
             url = "/pmkpi/program/trace/manage/prolist.page";
         } else if ("protrace" == tasktype && "province"== _pagetype) {//项目支出-重点监控
             url = "/pmkpi/program/trace/manage/prolistimp.page";
         } else if ("depttrace" == tasktype && "dept"== _pagetype) {//部门整体-一般监控
             url = "/pmkpi/program/trace/manage/deptlist.page";
         } else if ("depttrace" == tasktype && "province"== _pagetype) {//部门整体-重点监控
             url = "/pmkpi/program/trace/manage/deptlistimp.page";
         }
         url = Ext.lt.pmkpi.genPageUrl(url, params);
         Ext.lt.ui.openModalWindow(url,scrWidth-100,scrHeight-100,"布置任务范围");
     }

     return cmp;
}