if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.reviewerinfo){
    Ext.lt.pmkpi.reviewerinfo = {};
}
Ext.lt.pmkpi.reviewerinfo = function(config, service){
    try{
        window.parent.Ext.lt.pmkpi.childwindow = window;
    }catch (e){}
    var cmp = {};
    var serviceid = service,
        _mainguid = config.mainguid,//主单id
        _type = config.type,//类型 1.mainreviewer主评人  2.otheremploy其他绩效评价从业人员  3.expert 合作专家信息
        _projguid = config.projguid,//项目id
        _projcode = config.projcode,
        _agency = config.agency,
        _viewtype = config.viewtype,
        _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//绩效类型
        _tablecode = config.tablecode,//table表名
        _saveAgency = config.saveAgency,
        _busguid = config.busguid,
        _defquery,
        _taskguid = config.taskguid;//任务guid
    Ext.lt.pmkpi.isadd = false;

    cmp.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.menuid = _menuid;
        params.proguid = _projguid;
        params.procode = _projcode
        params.mainguid = _mainguid;
        params.taskguid = _taskguid;
        params.saveAgency = _saveAgency;
        params.defquery = _defquery;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            if (isquery){
                parent._isQuery = true;
            }
            Ext.lt.ui.loadingClose();
            setTimeout( function(){
                datatable.resetSum();
            }, 300 );
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });

    }

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        Ext.lt.ui.loadingShow();
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        params.pro_code = _projcode;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.agency = _agency;
        params.type = _type;
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        cmp.query(true);
        return rs;
    }
    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
        var newguid = Ext.lt.RCP.asyncall(service , "getCreateguid", null);
        var newdata ={};
        newdata.guid = newguid;
        newdata.isedit = '1';
        newdata.rowtype = "add";
        datatable.getRecordSet().addData(newdata,999);
    });
    /**
     * 刪除行
     */
    Ext.lt.message.hook("delRow", "uidatatable", function() {
        var selDatas = datatable.getSelected();
        if (selDatas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                datatable.removeData(selDatas);
            }
        })
    })

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
    });

    $(function () {
        if (_viewtype == "query") {
            document.getElementById("add").style.display = "none";
            document.getElementById("del").style.display = "none";
        }
        cmp.query(true);
    })

    return cmp;
}
