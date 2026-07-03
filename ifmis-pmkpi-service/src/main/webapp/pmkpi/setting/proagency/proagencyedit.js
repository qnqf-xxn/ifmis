if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.proagencyedit)
    Ext.lt.pmkpi.proagencyedit = {};

Ext.lt.pmkpi.proagencyedit = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _tablecode=config.tablecode,//表名
        _province = config.province,
        _year = config.year,
        _guid =config.guid, //主键id
        _defquery,
        _rowtype = config.rowtype;//修改/新增

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_rowtype == "mod") {
           cmp.query();
           document.getElementById("add").style.display = "none";
           document.getElementById("del").style.display = "none";
        }
    })

    /**
     * 列配置
     */
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++) {
            var col = cols[i];
            if(col["colcode"]=="pro_code" && _rowtype == "mod") {
                col.oneditstart = function (table, e, l, c, d) {
                    if (d.isedir != "0") {
                        return false;
                    }
                }
            }
        }
    });

    /**
     * 查询
     */
    cmp.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.guid = _guid;
        params.tablecode = _tablecode;
        params.beanid = "pmkpi.setting.proagency.ProagencyBOTX";
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    /**
     * 保存数据
     */
    cmp.infosave = function () {
        var data = datatable.getRecordSet().toArray();
        if (!datatable.checkAll()) return;//先校验
        var params = {};
        params.data = data;
        params.tablecode = _tablecode;
        params.year=_year;
        params.province=_province;
        params.rowtype = _rowtype;
        Ext.lt.ui.loadingShow();
        if (_rowtype == "add"){
            //新增数据 -- 校验
            //1、校验项目编码是否存在，如否则提示“XXXXXX，XXXXXX项目编码不存在，请检查！”
            Ext.lt.RCP.call(serviceid, "checkData", params, function (rs) {
                if (!rs.success) {
                    Ext.lt.ui.alert(rs.remark, function () {
                        Ext.lt.ui.loadingClose();
                        return;
                    });
                } else {
                    //2.根据项目编码校验当前年度是否已维护，如是则提示“XX项目已维护，确认是否更新？”点击确认则替换原有数据
                    Ext.lt.RCP.call(serviceid, "checkDataUpdate", params, function (rs) {
                        if (!rs.success) {
                            var returnvalue = confirm("项目编码为" + rs.procodes + '的项目已维护，确认是否更新？');
                            if (returnvalue) {
                                params.data = rs.data;
                                saveDatas(params, service);
                            } else {
                                Ext.lt.ui.loadingClose();
                                return;
                            }
                        } else {
                            saveDatas(params, service);
                        }
                    });
                }
            });
        } else {
            //修改数据 - 不校验直接保存
            saveDatas(params,service);
        }
    }

    /**
     * 新增行.
     */
    Ext.lt.message.hook("addRow", "uidatatable", function(){
        var newdata ={};
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

    return cmp;
}
function saveDatas (params,service){
    Ext.lt.ui.loadingShow();
    Ext.lt.RCP.call(service , "saveDatas", params, function(rs){
        if (rs && rs.success) {
            Ext.lt.ui.alert('保存成功！',function(){
                // parent.Ext.lt.pmkpi.query();
                window.parent.Ext.lt.pmkpi.query();
                Ext.lt.ui.closeModalWindow();
            });
        } else {
            Ext.lt.ui.alert('保存失败！',function(){
            });
        }
        Ext.lt.ui.loadingClose();
    });
}