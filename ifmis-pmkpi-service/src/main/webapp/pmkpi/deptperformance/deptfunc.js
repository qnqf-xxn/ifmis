if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptfunc){
    Ext.lt.pmkpi.deptfunc = {};
}

Ext.lt.pmkpi.deptfunc = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _mainguid = config.mainguid,
        _proguid = config.proguid,//关联项目id
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _isadj = config.isadj, //是否调整
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义
        _findex,//一级指标\
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var cmp = {};


    Ext.lt.message.hook("addRow", "uidatatable", function(editdatatable){
        var newdata ={};
        newdata.mainguid = _mainguid;
        newdata.agencyguid = _saveAgency;
        newdata.findex = _findex;
        newdata.rowtype = "add";
        Ext.lt.pmkpi.isadd = true;
        datatable.getRecordSet().addData(newdata,999);
    });

    Ext.lt.message.hook("delRow", "uidatatable", function(editdatatable){
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
    });

    //查询职能职责跳转js
    cmp.choose =function (){
        var url = _uikey + ".page";
        var params = {};
        params.saveAgency = _saveAgency;
        params.mainguid = _mainguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"选择职能职责");
    }

    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        _uikey = config.uikey;
        _findex = config.findex;
    });

    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if (_viewtype == 'query' && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });

    cmp.query = function(isquery){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.isadj = _isadj;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
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
        debugger;
        if (!datatable.checkAll()) return false;//先校验
        if(!checkLength()) return false; //校验录入长度不得超过150
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.busguid = _busguid;
        params.isadj = _isadj;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        if (rs && rs.success) {
            // Ext.lt.ui.alert('保存成功！',function(){
            //     setTimeout(function () {
                    cmp.query();
                // },300);
            // });
        }
        return rs;
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_viewtype == "query") {
            try{
                $("div[compid='toolbutton']").hide();
            }catch (e){
            }
            document.getElementById("add").style.display = "none";
            document.getElementById("del").style.display = "none";
        }
        cmp.query(true);
    })

    return cmp;
}

/**
 * 部门职能校验不能超过150字
 */
function checkLength() {
    var flag = true;
    var datas = datatable.getRecordSet().toArray();
    if (datas != null && datas.length > 0) {
        for (var i = 0; i < datas.length; i++) {  //
            var tempObj = datas[i];
            var name = tempObj.name;
            if(name.length > 150){
                Ext.lt.ui.alert("第"+(i+1)+"行，部门职能不能超过150字，您已书写"+name.length+"字，超出"+(name.length-150)+"字， 请重新填写！", {timeout: 1}, function () { });
                return false;
            }
        }
    }
    return flag;
}