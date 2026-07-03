if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.depttask){
    Ext.lt.pmkpi.depttask = {};
}
Ext.lt.pmkpi.depttask = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    try{
        window.parent.Ext.lt.pmkpi.childwindow = window;
    }catch (e){}
    var cmp = {};
    var _mainguid = config.mainguid,//主单id
        _projguid = config.projguid,//项目id
        _projcode = config.projcode,
        _agency = config.agency,
        _viewtype = config.viewtype,
        _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//绩效类型
        _tablecode = config.tablecode,//table表名
        _saveAgency = config.saveAgency,
        _busguid = config.busguid,
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
        params.viewtype = _viewtype;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setMidSaveHidButtons(rs);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
            if (isquery) {
                setTimeout(function(){
                    parent._isQuery = true;
                },500);
            }
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
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
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        var rs = Ext.lt.RCP.asyncall(service, "save", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }
    /**
     * 暂存
     */
    cmp.savetmp = function (obj){
        var rns = datatable.getEditor();
        if (rns){
            datatable.closeEdit();
        }
        var params = {};
        Ext.lt.ui.loadingShow();
        params.data = datatable.getRecordSet().toArray();
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        params.url = datatable.config.pageurl;
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsave", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
        return rs;
    }

    /**
     * 清除暂存
     */
    cmp.savetmpdel = function (obj){
        var params = {};
        params.url = datatable.config.pageurl;
        params.mainguid = _mainguid;
        params.componentid = datatable.config.server;
        params.compconfigid = "datatable";
        Ext.lt.ui.loadingShow();
        var rs = Ext.lt.RCP.asyncall(serviceid , "midsavedel", params);
        Ext.lt.ui.loadingClose();
        if (rs && rs.success) {
            cmp.query();
        }
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
        amtTotal(datatable);
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
                amtTotal(datatable);
            }
        })
    })

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"]=="financialfund" || col["colcode"]=="otherfund" || col["colcode"]=="basicfund" || col["colcode"]=="projectfund"){
                col.oneditend = function (table, el, l, c, d) {
                    var otherfund = d.otherfund ? d.otherfund :0;
                    var sumamt1 = parseFloat(otherfund);
                    var financialfund = d.financialfund ? d.financialfund :0;
                    var sumamt2 = parseFloat(financialfund);
                    var basicfund = d.basicfund ?d.basicfund :0;
                    var sumamt3 = parseFloat(basicfund);
                    var projectfund = d.projectfund ? d.projectfund :0;
                    var sumamt4 = parseFloat(projectfund);
                    d.totalamt =(sumamt1 +sumamt2+sumamt3+sumamt4).toFixed(2);
                    amtTotal(datatable);
                }
            }
        }
    });

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_viewtype == "query") {
            if($("div[compid='toolbutton']")){
                $("div[compid='toolbutton']").hide();
            }
            if(document.getElementById("add")){
                document.getElementById("add").style.display = "none";
            }
            if(document.getElementById("del")){
                document.getElementById("del").style.display = "none";
            }
            for(var i = 2; i<datatable.getCols().length; i++){
                datatable.getCols()[i].edit = false;
            }
            datatable.redraw();
        }
        cmp.query(true);
    })

    return cmp;
}

function amtTotal(table) {
    if(table.getSumobj()){
        var totalrow = table.getRecordset();
        var sumamt1 = 0;
        var sumamt2 = 0;
        var sumamt3 = 0;
        var sumamt4 = 0;
        var rowarr = totalrow.toArray();
        var len = rowarr.length;
        for ( var i = 0; i < len; i++) {
            var financialfund = rowarr[i]["financialfund"] ? rowarr[i]["financialfund"] : 0;
            sumamt1 += parseFloat(financialfund);
            var otherfund = rowarr[i]["otherfund"] ? rowarr[i]["otherfund"] : 0;
            sumamt2 += parseFloat(otherfund);
            var basicfund = rowarr[i]["basicfund"] ? rowarr[i]["basicfund"] : 0;
            sumamt3 += parseFloat(basicfund);
            var projectfund = rowarr[i]["projectfund"] ? rowarr[i]["projectfund"] : 0;
            sumamt4 += parseFloat(projectfund);
        }
        var totalrs = {};
        totalrs["financialfund"] = sumamt1 == 0 ? "" : sumamt1.toFixed(2);        //年初预算
        totalrs["otherfund"] = sumamt2 == 0 ? "" : sumamt2.toFixed(2);        //年度调整预算
        totalrs["basicfund"] = sumamt3 == 0 ? "" : sumamt3.toFixed(2);        //调整后预算
        totalrs["projectfund"] = sumamt4 == 0 ? "" : sumamt4.toFixed(2);        //实际执行数
        totalrs["totalamt"] =(sumamt1 +sumamt2+sumamt3+sumamt4);
        totalrs.datatable_do_sum=true;
        table.getClockRowSet().setData(totalrs,0);
        //if((totalrow.size&&totalrow.size()>0)||(totalrow.length&&totalrow.length>0)){
        table.reflashdata();
        //}
    }
}