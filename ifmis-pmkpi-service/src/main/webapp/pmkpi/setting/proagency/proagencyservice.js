if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.proagencyservice)
    Ext.lt.pmkpi.proagencyservice = {};

Ext.lt.pmkpi.proagencyservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _tablecode,//表名
        _delcols,
        _updatecols,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight,
        _defquery;//页签过滤条件

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query();
    })

    /**
     * 列配置
     */
    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _delcols = config.delcols;
        _updatecols = config.updatecols;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.querySql = queryform.getQuerySQL();
        params.beanid = "pmkpi.setting.proagency.ProagencyBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 新增
     */
    cmp.add = function (){
        var newdata ={};
        newdata.rowtype = "add";
        var url = "/pmkpi/setting/proagency/edit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, newdata);
        Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"项目单位变更维护页面");
    }

    /**
     * 修改
     */
    cmp.update = function (){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var newdata ={};
        newdata.guid = datas[0].guid;
        newdata.rowtype = "mod";
        var url = "/pmkpi/setting/proagency/edit.page";
        url = Ext.lt.pmkpi.genPageUrl(url, newdata);
        Ext.lt.ui.openModalWindow(url,_scrWidth*0.75, _scrHeight*0.75,"项目单位变更维护页面");
    }

    /**
     * 删除
     */
    cmp.deleted = function () {
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要删除的数据！",function(){});
            return;
        }
        var params ={};
        params.tablecode = _tablecode;
        params.datas = datas;
        Ext.lt.ui.confirm('是否删除已选择的数据!？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        location.reload();
                        Ext.lt.pmkpi.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    //导入
    cmp["import"] = function(obj){
        // 暂时写死导入模板的code
        var importcode = "pmkpi_gx_proagency";
        var vchtypeid = "F7ED80BE9997742DE0533315A8C08F56";
        var tokenid = Ext.lt.getparam("tokenid");
        // 调用导入接口，需要参数有tokenid,模板编码，单据id，args组合传给后台的参数
        var params = {};
        params.importcode = importcode;
        params.vchtypeid = vchtypeid;
        params.rowtype = "add";
        params.tablecode = _tablecode;
        window.importparam = params;
        Ext.lt.importdata.imports(tokenid,importcode,vchtypeid,Object.toJSON(params),function(obj){
            window.parent.Ext.lt.outfile.window.close()
            parent.Ext.lt.pmkpi.impsucess(obj);
        });
    }

    Ext.lt.pmkpi.impsucess = function (obj){
        var params;
        Ext.lt.RCP.call(serviceid , "getImportData", null, function(rs){
            if (rs.data != ""){
                cmp.infosave(rs.data);
            } else {
                Ext.lt.ui.alert("导入成功！", function () {
                    Ext.lt.pmkpi.query();
                });
            }
        });
    }

    /**
     * 导入保存
     * @returns {{}}
     */
    cmp.infosave = function (data) {
        if (!datatable.checkAll()) return;//先校验
        var params = {};
        params.data = data;
        //新增数据 -- 校验
        //根据项目编码校验当前年度是否已维护，如是则提示“XX项目已维护，确认是否更新？”点击确认则替换原有数据
        Ext.lt.RCP.call(serviceid, "checkDataUpdate", params, function (rs) {
            if (!rs.success) {
                var returnvalue = confirm("项目编码为" + rs.procodes + '的项目已维护，确认是否更新？');
                if (returnvalue) {
                    params.data = rs.data;
                    Ext.lt.ui.loadingShow();
                    Ext.lt.RCP.call(service , "saveDatas", params, function(rs){
                        if (rs && rs.success) {
                            Ext.lt.ui.alert('导入成功！',function(){
                                Ext.lt.pmkpi.query();
                            });
                        } else {
                            Ext.lt.ui.alert('导入失败！',function(){
                            });
                        }
                        Ext.lt.ui.loadingClose();
                    });
                } else {
                    Ext.lt.pmkpi.query();
                    return;
                }
            } else {
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "saveDatas", params, function(rs){
                    if (rs && rs.success) {
                        Ext.lt.ui.alert('导入成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    } else {
                        Ext.lt.ui.alert('导入失败！',function(){
                        });
                    }
                    Ext.lt.ui.loadingClose();
                });
            }
        });
    }
    return cmp;
}

