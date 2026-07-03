if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.indexservice)
    Ext.lt.pmkpi.indexservice = {};

Ext.lt.pmkpi.indexservice = function(config, service){
    var _treeid,
        _indextype,
        _tablecode,
        _isleaf,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;
    var cmp = {};

    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (treeNode){
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
            if (_treeid == "FINANCE") {
                _indextype = "FINANCE";
                _tablecode = "v_bas_perf_indicator";
            } else {
                _indextype = "DEPT";
                _tablecode = "v_perf_t_deptindicator";
            }
            cmp.query();
        }
    });

    Ext.lt.pmkpi.query = function(){
        cmp.query();
    }

    cmp.query = function(){
        if (!_treeid) {
            Ext.lt.ui.alert("请选择左侧树进行查询！",function(){});
            return;
        }
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.tablecode = _tablecode;
        params.isleaf = _isleaf;
        try{
            if (!queryform)params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }catch (e) {}
        Ext.lt.ui.loadingShow();
        params.beanid = "pmkpi.setting.index.IndexBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 新增
     */
    cmp.add = function () {
        if (!_treeid || "DEPT" == _treeid) {
            Ext.lt.ui.alert("请选择左侧共性指标或具体单位（部门）进行新增！",function(){});
            return;
        }
        var url = "/pmkpi/index/edit.page";
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.pagetype = "add";
        params.tablecode = _tablecode;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"指标编辑");
    }

    /**
     * 修改
     */
    cmp.mod = function () {
        var selectDatas = datatable.getSelected();
        if (!selectDatas || selectDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条指标进行修改！",function(){});
            return;
        }
        var url = "/pmkpi/index/edit.page";
        var params = {};
        params.treeid = _treeid;
        params.indextype = _indextype;
        params.pagetype = "mod";
        params.tablecode = _tablecode;
        params.guid = selectDatas[0]["guid"];
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight,"指标编辑");
    }

    /**
     * 删除
     */
    cmp.del = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.size() <= 0) {
            Ext.lt.ui.alert('请选择要删除的数据！',function(){
            });
            return;
        }
        var params = {};
        params.selDatas = datas;
        params.tablecode = _tablecode;
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "del", params, function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除成功！',function(){
                        cmp.query();
                    });
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('删除失败！',function(){
                    });
                });
            }
        })
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}